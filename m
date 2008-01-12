From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: [ANNOUNCE] GIT 1.5.4-rc3
Date: Sat, 12 Jan 2008 09:47:48 +0200
Organization: Pardus / KDE
Message-ID: <200801120947.48602.ismail@pardus.org.tr>
References: <7vsl13wmas.fsf@gitster.siamese.dyndns.org> <200801120926.14307.ismail@pardus.org.tr> <7vejcnwl85.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 08:47:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDb4z-00036L-R6
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 08:46:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757919AbYALHq3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jan 2008 02:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757352AbYALHq3
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 02:46:29 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:51231 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757272AbYALHq3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jan 2008 02:46:29 -0500
Received: from [192.168.1.3] (unknown [85.97.18.122])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id AC5A761E2734;
	Sat, 12 Jan 2008 09:46:24 +0200 (EET)
User-Agent: KMail/1.9.6 (enterprise 0.20071204.744707)
In-Reply-To: <7vejcnwl85.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70286>

Saturday 12 January 2008 09:34:34 tarihinde =C5=9Funlar=C4=B1 yazm=C4=B1=
=C5=9Ft=C4=B1n=C4=B1z:
>  sh t9200-git-cvsexportcommit.sh -i -v

Thanks for the tip, I saw the following error :

cvs=20
commit -F .msg 'A/newfile1.txt' 'B/newfile2.txt' 'C/newfile3.png' 'D/ne=
wfile4.png'
cvs [commit aborted]: 'root' is not allowed to commit files

So looks like tests no longer work as root, so I run make test as norma=
l user=20
and I now see t7300-clean.sh fail, this time a real failure:

Removing part3.c
=2E/test-lib.sh: line 193: 19413 Aborted                 git-clean
* FAIL 5: git-clean with prefix


                mkdir -p build docs &&
                touch a.out src/part3.c docs/manual.txt obj.o build/lib=
=2Eso &&
                (cd src/ && git-clean) &&
                test -f Makefile &&
                test -f README &&
                test -f src/part1.c &&
                test -f src/part2.c &&
                test -f a.out &&
                test ! -f src/part3.c &&
                test -f docs/manual.txt &&
                test -f obj.o &&
                test -f build/lib.so

Regards,
ismail

--=20
Never learn by your mistakes, if you do you may never dare to try again=
=2E
