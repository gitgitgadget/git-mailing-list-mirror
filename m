X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-show: grok blobs, trees and tags, too
Date: Fri, 15 Dec 2006 09:50:36 +0100
Organization: At home
Message-ID: <eltng7$te5$2@sea.gmane.org>
References: <Pine.LNX.4.63.0612141129320.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 15 Dec 2006 08:50:27 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 18
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34478>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv8lh-0001Ig-Qp for gcvg-git@gmane.org; Fri, 15 Dec
 2006 09:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751298AbWLOIuK convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006 03:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWLOIuK
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 03:50:10 -0500
Received: from main.gmane.org ([80.91.229.2]:40898 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751298AbWLOIuI
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 03:50:08 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1Gv8lW-0003Gx-3z for git@vger.kernel.org; Fri, 15 Dec 2006 09:50:02 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 09:50:02 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 15 Dec 2006
 09:50:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:

> +For tags, it shows the tag message and the referenced objects.
[...]
> +EXAMPLES
> +--------
> +
> +git show v1.0.0::
> +=A0=A0=A0=A0=A0=A0=A0Shows the tag `v1.0.0`.

This changes semantic. Before this patch "git show v1.0.0" showed
_commit_, not a tag. Well, you can get commit using "git show v1.0.0^{}=
"...

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

