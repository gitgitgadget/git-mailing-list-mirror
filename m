From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] add: don't complain when adding empty project root
Date: Thu, 30 Jan 2014 12:39:51 +0100
Message-ID: <52EA3A07.2090203@web.de>
References: <CAEcj5uWHpem+5os+3Mc_a42pk6f30i4UiV=LRPdXkoqiy1jQ_w@mail.gmail.com> <1387789361-29036-1-git-send-email-pclouds@gmail.com> <52B87759.2090901@web.de> <CACsJy8A7j_ERqH_TDuKDdssaLFCvM5yVT4eUjTqkN_qW4iXuGA@mail.gmail.com> <52BA0110.4050003@web.de> <CACsJy8ApEBq+G+swpBPPJwL1E94x-P+e+V_jYknG+rXybLxPgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jan 30 12:40:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8pyY-0003tL-3M
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 12:40:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbaA3LkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 06:40:00 -0500
Received: from mout.web.de ([212.227.15.3]:54306 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751429AbaA3Lj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 06:39:59 -0500
Received: from [192.168.209.20] ([78.72.74.102]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0MOAmi-1WEK9g11bY-005V0t for <git@vger.kernel.org>;
 Thu, 30 Jan 2014 12:39:56 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <CACsJy8ApEBq+G+swpBPPJwL1E94x-P+e+V_jYknG+rXybLxPgQ@mail.gmail.com>
X-Provags-ID: V03:K0:wjszZMiQnkfgGGM++HSBXvLOWYyxU/8hbKx+WDIB/INemyXoTQF
 8izGTbGvtDyg3cQhuyRgsCMXIeb4/owy98d6qtdFeKnl6nzxEjwQRqmMZiutuerwlhDJzob
 3Ds9nBCp/HdEQ9PtYBCLRVfnv2jpu4ERwXc4Y5Np2czzTD3xokVv8mUGxqbKItTr8+X+FUo
 +8Q5NvZOoQiR+Co4myekQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241267>

[]
> filepattern is related to current directory too (e.g. "*.sh" from "t"
> won't cover git-rebase.sh, ":/*.sh" does). Yes a patch to update
> git-add.txt to use the term "pathspec" instead of "filepattern" would
> be nice. A pointer to pathspec glossary could help discover
> case-insensitive matching, negative matching..


To somewhat end this thread: 
I haven't been able to find a patch that really improves the documentation,
because "Documentation/git-add.txt" has already been updated:

commit 30784198b766b19a639c199e4365f2a805fc08c6
Author: Junio C Hamano <gitster@pobox.com>
Date:   Thu Feb 14 15:51:43 2013 -0800

    Documentation/git-add: kill remaining <filepattern>
--------------------

And all changes are here:
http://git-htmldocs.googlecode.com/git/git-add.html

But, look at
https://www.kernel.org/pub/software/scm/git/docs/git-add.html

This page seems to need an update too, and I wonder why:
a) The makefile did'nt re-generate html even if it should have
b) That page is not owned or updated by the git.git maintainer
c) Any other reason?


Does anybody know how to trigger an update at kernel.org?

/Torsten
