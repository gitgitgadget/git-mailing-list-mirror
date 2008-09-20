From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Use dashless git commands in setgitperms.perl
Date: Sat, 20 Sep 2008 02:02:53 +0200
Organization: At home
Message-ID: <gb1ej9$bg2$1@ger.gmane.org>
References: <20080919234234.GL2939@inocybe.teonanacatl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 20 02:04:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kgpxb-0003Bc-P6
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 02:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbYITADH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Sep 2008 20:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752642AbYITADG
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 20:03:06 -0400
Received: from main.gmane.org ([80.91.229.2]:34431 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbYITADF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 20:03:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kgpw8-0007iM-Uo
	for git@vger.kernel.org; Sat, 20 Sep 2008 00:02:56 +0000
Received: from abvi94.neoplus.adsl.tpnet.pl ([83.8.206.94])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 00:02:56 +0000
Received: from jnareb by abvi94.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 00:02:56 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvi94.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96327>

Todd Zullinger wrote:

> =A0# To save permissions/ownership data, place this script in your .g=
it/hooks
> =A0# directory and enable a `pre-commit` hook with the following line=
s:
> =A0# =A0 =A0 =A0#!/bin/sh
> -# =A0 =A0 SUBDIRECTORY_OK=3D1 . git-sh-setup
> +# =A0 =A0 SUBDIRECTORY_OK=3D1 . git sh-setup
> =A0# =A0 =A0 $GIT_DIR/hooks/setgitperms.perl -r
> =A0#
> =A0# To restore permissions/ownership data, place this script in your=
 .git/hooks
> =A0# directory and enable a `post-merge` and `post-checkout` hook wit=
h the
> =A0# following lines:
> =A0# =A0 =A0 =A0#!/bin/sh
> -# =A0 =A0 SUBDIRECTORY_OK=3D1 . git-sh-setup
> +# =A0 =A0 SUBDIRECTORY_OK=3D1 . git sh-setup
> =A0# =A0 =A0 $GIT_DIR/hooks/setgitperms.perl -w
> =A0#

The rest is probably O.K., but I don't think this change is good one.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
