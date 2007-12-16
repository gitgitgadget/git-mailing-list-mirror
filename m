From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] whitespace: fix initial-indent checking
Date: Sun, 16 Dec 2007 10:08:25 +0100
Organization: At home
Message-ID: <fk2pua$b4p$1@ger.gmane.org>
References: <7vodd4fb2f.fsf@gitster.siamese.dyndns.org> <1197776919-16121-1-git-send-email-bfields@citi.umich.edu> <1197776919-16121-2-git-send-email-bfields@citi.umich.edu> <1197776919-16121-3-git-send-email-bfields@citi.umich.edu> <1197776919-16121-4-git-send-email-bfields@citi.umich.edu> <1197776919-16121-5-git-send-email-bfields@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 16 10:09:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3pUl-0005wN-MT
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 10:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755946AbXLPJIs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Dec 2007 04:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755616AbXLPJIr
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 04:08:47 -0500
Received: from main.gmane.org ([80.91.229.2]:45166 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755554AbXLPJIq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 04:08:46 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1J3pUE-00068K-AR
	for git@vger.kernel.org; Sun, 16 Dec 2007 09:08:38 +0000
Received: from abur199.neoplus.adsl.tpnet.pl ([83.8.189.199])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 16 Dec 2007 09:08:38 +0000
Received: from jnareb by abur199.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 16 Dec 2007 09:08:38 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abur199.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68448>

J. Bruce Fields wrote:

> This allows catching initial indents like '\t =A0 =A0 =A0 =A0' (a tab=
 followed
> by 8 spaces), while previously indent-with-non-tab caught only indent=
s
> that consisted entirely of spaces.

I prefer to use tabs for indent, but _spaces_ for align. While previous=
,
less strict version of check catches indent using spaces, this one also
catches _align_ using spaces.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
