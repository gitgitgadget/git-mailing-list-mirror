From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: THREADED_DELTA_SEARCH
Date: Thu, 10 Jul 2008 10:01:19 +0200
Message-ID: <4875C1CF.1010604@viscovery.net>
References: <20080710075327.GD24819@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jul 10 10:02:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGr6c-0005Pm-An
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 10:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbYGJIBX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jul 2008 04:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbYGJIBX
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 04:01:23 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:52420 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbYGJIBW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jul 2008 04:01:22 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KGr5b-0005oh-TU; Thu, 10 Jul 2008 10:01:20 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 83EEB6D9; Thu, 10 Jul 2008 10:01:19 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080710075327.GD24819@artemis.madism.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87958>

Pierre Habouzit schrieb:
>   I'm using it in production for quite a long time now, and I wonder =
if
> there is any specific reason why it's not default. Debian activated i=
t
> by default too a couple of weeks ago, which means that it's in
> production on quite a large scale, and there are no issues reported
> either. Would a patch making it default be accepted ? It's quite hand=
y
> given that SMP machines are really pervasive nowadays=E2=80=A6

Don't forget to turn it off in the MINGW section in the Makefile since =
we
don't have pthreads on Windows.

-- Hannes
