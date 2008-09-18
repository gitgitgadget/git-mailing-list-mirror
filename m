From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/1] Make git archive respect core.autocrlf when creating
   zip format archives
Date: Thu, 18 Sep 2008 22:41:00 +0200
Message-ID: <48D2BCDC.6060809@lsrfire.ath.cx>
References: <1a7cc4db062b7df0dae0f27b29dba66c9d917e59.1221767629.git.charles@hashpling.org> <20080918200120.GB8631@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Thu Sep 18 22:42:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgQKN-00024l-U6
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 22:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755234AbYIRUlH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Sep 2008 16:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755221AbYIRUlF
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 16:41:05 -0400
Received: from india601.server4you.de ([85.25.151.105]:56189 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110AbYIRUlF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 16:41:05 -0400
Received: from [10.0.1.200] (p57B7F617.dip.t-dialin.net [87.183.246.23])
	by india601.server4you.de (Postfix) with ESMTPSA id AB4572F8046;
	Thu, 18 Sep 2008 22:41:00 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20080918200120.GB8631@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96243>

Charles Bailey schrieb:
> There is currently no call to git_config at the start of cmd_archive.
> When creating tar archives the core config is read as a side-effect o=
f
> reading the tar specific config, but this doesn't happen for zip
> archives.
>=20
> The consequence is that in a configuration with core.autocrlf set,
> although files in a tar archive are created with crlf line endings,
> files in a zip archive retain unix line endings.

The patches look good, but it took me a while to realize that there are
two of them (0/1 and 1/1). :)

Thanks,
Ren=E9
