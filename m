From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: [PATCH] bash: Disable __git_ps1() if NO_GIT_PS1 is set
Date: Thu, 5 May 2011 19:48:40 +0200
Message-ID: <1k0t770.1lqbn2d43agaoM%lists@haller-berlin.de>
References: <20110504221153.GB15161@linode>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: sunny@sunbase.org (=?ISO-8859-1?Q?=D8yvind_A=2E_Holm?=),
	git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu May 05 19:48:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI2fU-0002yt-3A
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 19:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755566Ab1EERso convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 13:48:44 -0400
Received: from mail.ableton.net ([62.96.12.117]:49405 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755463Ab1EERsn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 13:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:From:Subject:In-Reply-To:To; bh=1J1F5g1zEC0v4+999GRiUeSiDKt/GrV2pUdUq/VAgOg=;
	b=NtcZfqW9IcmIDCMvfOpIh8lvC5Bf6EjvehsvzKiER1xNheFfsj9d8b1X/TObAc7yc7J8fuHwF8gkzlvLtiyvKxJBtEVZko9AQ2UL2myp/nsh4nbevGaZCRRuVg1umGJAAz21Jo4pPmGHjPwHxVW3msWsvudBadkExEOlk2RnYl8=;
Received: from [10.1.15.242]
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1QI2fJ-0005mA-2S; Thu, 05 May 2011 19:48:41 +0200
In-Reply-To: <20110504221153.GB15161@linode>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.7 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172859>

=D8yvind A. Holm <sunny@sunbase.org> wrote:

> If the user works in a big repository on a slow USB disk or network
> drive, __git_ps1() can result in a significant delay before the promp=
t
> reappears. By setting the environment variable NO_GIT_PS1 to a nonemp=
ty
> value, the use of __git_ps1() is temporarily disabled.

As far as I can tell, the only thing that makes the prompt slow in larg=
e
repositories is determining the dirty state; so instead of disabling th=
e
prompt entirely, you may want to just unset GIT_PS1_SHOWDIRTYSTATE.
That way you still see which branch you are on, for example.


--=20
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
