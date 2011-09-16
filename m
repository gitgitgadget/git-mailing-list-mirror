From: Rodrigo Rosenfeld Rosas <lbocseg@yahoo.com.br>
Subject: Re: [PATCH/RFC] bash: add --word-diff option to diff [AND --set-upstream
 TO push] auto-completion
Date: Fri, 16 Sep 2011 12:56:09 -0300
Message-ID: <4E737199.1000107@yahoo.com.br>
References: <4E6F720A.3020103@yahoo.com.br> <20110913165847.GB11076@elie>	<4E6FA541.7000100@yahoo.com.br> <20110913191448.GC14917@elie>	<20110913232941.GC2078@goldbirke> <20110913233712.GE2078@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@fzi.de>
X-From: git-owner@vger.kernel.org Fri Sep 16 18:01:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4ar7-0006TX-7H
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 18:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755142Ab1IPQB2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Sep 2011 12:01:28 -0400
Received: from nm6-vm0.bullet.mail.bf1.yahoo.com ([98.139.213.146]:20470 "HELO
	nm6-vm0.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753557Ab1IPQB1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2011 12:01:27 -0400
X-Greylist: delayed 316 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Sep 2011 12:01:27 EDT
Received: from [98.139.212.150] by nm6.bullet.mail.bf1.yahoo.com with NNFMP; 16 Sep 2011 15:56:11 -0000
Received: from [98.139.212.208] by tm7.bullet.mail.bf1.yahoo.com with NNFMP; 16 Sep 2011 15:56:11 -0000
Received: from [127.0.0.1] by omp1017.mail.bf1.yahoo.com with NNFMP; 16 Sep 2011 15:56:10 -0000
X-Yahoo-Newman-Id: 991137.91955.bm@omp1017.mail.bf1.yahoo.com
Received: (qmail 30961 invoked from network); 16 Sep 2011 15:56:10 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.br;
  h=DKIM-Signature:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=gTFCdTVwsm9KCi5bqt/X98NWMrhgjDB+NVur56RuMb28gY6rT9GFvZOQXdCRnHumOC0TulGGcxLxCs1hK9+Bqpt3WW4saVY1JAYofedIIeaBSCF+kUe4t2n2Mmf8EoQhZbR4QbP7R7RcW79zRJ7GrXrJ4oIwnJxKQG503Cl8qvI=  ;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.br; s=s1024; t=1316188570; bh=xYfhchqJlasMNdHPCFV9/19ImJcYmbi3CEwCUw3hvnY=; h=X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding; b=iAeKb0eXXKcKz3kQz3P7uhUHjM4SWS0Me6P3pUQ07JJ+TyCu9P7vewhhM8muEUpDbwmQoLfiohNtYa3GUsKesaTW9rAkL8Etj3T2WkV5lsCRestC8+vP5975U30IZXhxpCobrEJTDA8xP0f32Dewh+MuBkxve7TCJ5VwKz6GuPM=
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: teMRhrUVM1kR2b32bwv4bOhSylhsv95cs0ApBoQlofYdJYp
 Ng7FOPD_XnUdkWmbqwv0Ndl.4cfi0wWlVsjTfKDlMDOkOU7PvmEs5DkmXBGA
 zdeFZZrs0f6t.0ROTk5ftHQcaSnCWPXi2CXDbl7UxinCce1g90BKUdv77QJW
 I5TUJWEnP8O9nIrOi_Sq2d5RN03nS6LuRYthXe3W_xQaDV.P18ee8Ad.ogUJ
 M5EDMfjwkpixwgf4hiMBdabYCa3Dc5NtpdDjzBqk3E09tPlmW9rqzPhSDay8
 vQ8vkA5MaZf8NkRPV.cvHOdAI_6aXTpbZTrDtYJUzg09AwwacaB4.kiTPnLl
 EaxZSUpfGi261x4RalerpqVC45ca2eMg3IB2ua8UjGdaK1W.fjlw.d7.POFd
 SbSKQw_xa8culBDrX
X-Yahoo-SMTP: gTgpchKswBBA40XrC4I4vHx_atc-
Received: from [192.168.2.6] (lbocseg@186.212.254.52 with plain)
        by smtp107.mail.bf1.yahoo.com with SMTP; 16 Sep 2011 08:56:10 -0700 PDT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.21) Gecko/20110831 Icedove/3.1.13
In-Reply-To: <20110913233712.GE2078@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181536>

While on the topic, it would also be interesting to add "--set-upstream=
"=20
to "git push" autocompletion. Don't you agree?

Cheers, Rodrigo.

Em 13-09-2011 20:37, SZEDER G=E1bor escreveu:
> On Wed, Sep 14, 2011 at 01:29:41AM +0200, SZEDER G=E1bor wrote:
>> Or is it just too late here and I'm missing something
>> obvious?
>>
>> Completing the mode for --word-diff=3D<TAB>  is a good idea, but c'm=
on,
>> there are plenty of examples ;)  Have a look at _git_am(),
>> _git_format_patch(), or _git_init() for something easy, and
>> _git_commit(), _git_log(), or _git_notes() for something fancy.
>>
>> Note that --word-diff=3D is also valid for log and shortlog, so the =
same
>> can be done there, too.
>
> Not shortlog, show.  It's definitely too late... ;)
>
>
