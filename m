From: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH] graph: avoid infinite loop in =?utf-8?b?Z3JhcGhfc2hvd19jb21taXQoKQ==?=
Date: Sun, 23 Sep 2012 11:55:50 +0000 (UTC)
Message-ID: <loom.20120923T135253-178@post.gmane.org>
References: <1348323880-3751-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 23 13:56:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFknJ-0007tB-86
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 13:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753044Ab2IWL4H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Sep 2012 07:56:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:42717 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752929Ab2IWL4G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2012 07:56:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TFkn6-0007gS-O3
	for git@vger.kernel.org; Sun, 23 Sep 2012 13:56:04 +0200
Received: from 67-181-78-94.net.stream.pl ([94.78.181.67])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 23 Sep 2012 13:56:04 +0200
Received: from michal.kiedrowicz by 67-181-78-94.net.stream.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 23 Sep 2012 13:56:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 94.78.181.67 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_4) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/21.0.1180.89 Safari/537.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206236>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds <at> gmail.com> writ=
es:

>=20
> The loop can be triggered with "git diff-tree --graph commit" where
> the commit is a non-merge. It goes like this


Isn't this the same issue as in=20
http://article.gmane.org/gmane.comp.version-control.git/123979
? (with slightly different fix)
