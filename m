From: =?UTF-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
Subject: How to fetch missing pack
Date: Sat, 12 Apr 2008 12:07:12 +0000 (UTC)
Message-ID: <slrng019fg.nd8.joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 14:12:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jkeaf-0004xh-8h
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 14:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759409AbYDLMLc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Apr 2008 08:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759069AbYDLMLc
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 08:11:32 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:2728 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757574AbYDLMLc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 08:11:32 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 940C9488053; Sat, 12 Apr 2008 14:11:30 +0200 (CEST)
Received: from news by alea.gnuu.de with local (Exim 4.63)
	(envelope-from <news@alea.gnuu.de>)
	id 1JkeVk-00017r-PT
	for git@vger.kernel.org; Sat, 12 Apr 2008 14:07:13 +0200
Path: not-for-mail
Newsgroups: local.mailinglist.git
X-Trace: alea.gnuu.de 1208002032 4329 192.168.0.5 (12 Apr 2008 12:07:12 GMT)
X-Complaints-To: usenet@alea.gnuu.de
User-Agent: slrn/pre0.9.9-102 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79350>

Hi,

I'm missing a pack. My history of the git repository is broken:
% git show --pretty=3Draw e0fda6ab|head -7
commit e0fda6abd11c567b72f29ec0ee06c541404a9cb7
tree 77a7e4a849bbec646d88ae863f80ea3f519e26bd
parent 1ab58e8d6f728cdde0057f7ee88daab3a1c2d06f
author Wincent Colaiuta <win@wincent.com> 1196066088 +0100
committer Junio C Hamano <gitster@pobox.com> 1196109124 -0800

    Fix typo in draft 1.5.4 release notes
% git log --pretty=3Doneline e0fda6ab | wc -l
1
% git show e0fda6ab~1|cat
fatal: ambiguous argument 'e0fda6ab~1': unknown revision or path not in=
 the working tree.
Use '--' to separate paths from revisions

Can I somehow tell git fetch to check the whole history for holes and
fetch missing packs?

Bye, J=C3=B6rg.
--=20
Der kommt den G=C3=B6ttern am n=C3=A4chsten, der auch dann schweigen ka=
nn,
wenn er im Recht ist.                         (Cato; 234=E2=80=93149 v.=
 Chr.)
