From: Maurice Francois <francoismaurice2001@yahoo.ca>
Subject: In search of a version control system
Date: Mon, 8 Oct 2012 11:06:21 -0700 (PDT)
Message-ID: <1349719581.76671.YahooMailNeo@web122505.mail.ne1.yahoo.com>
Reply-To: Maurice Francois <francoismaurice2001@yahoo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 08 20:12:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLHo9-0000te-Mn
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 20:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068Ab2JHSLu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2012 14:11:50 -0400
Received: from nm7-vm1.bullet.mail.ne1.yahoo.com ([98.138.90.250]:48193 "HELO
	nm7-vm1.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751185Ab2JHSLt convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 8 Oct 2012 14:11:49 -0400
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Oct 2012 14:11:49 EDT
Received: from [98.138.90.51] by nm7.bullet.mail.ne1.yahoo.com with NNFMP; 08 Oct 2012 18:06:21 -0000
Received: from [98.138.226.160] by tm4.bullet.mail.ne1.yahoo.com with NNFMP; 08 Oct 2012 18:06:21 -0000
Received: from [127.0.0.1] by omp1061.mail.ne1.yahoo.com with NNFMP; 08 Oct 2012 18:06:21 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 744402.77296.bm@omp1061.mail.ne1.yahoo.com
Received: (qmail 77564 invoked by uid 60001); 8 Oct 2012 18:06:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s1024; t=1349719581; bh=qDJ5jCApt49BPWEVh4TmTGpG3pBJX8kxiyy6GHKmQ6I=; h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=LLrmlX3vXJYabvk7f50dbVS2qPjrW07nfGwV6bXvvyZ/BxIfCOdTchC5xeCMQygDhYdDn4Qu1biRx21gcsfk7JJiPJ93LPnDUPWqF7hWDxhW3bB7jggwmco3Qls7uF8pY5okMhycIzABySmCo/tV0O28bF4IPgExi+2fV1KEANU=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.ca;
  h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=xq7p7TxkdyZAS0XLsrrYvylOsUzhjUQXwpIPJMxVuylzDLoI3SLiNE+TDYimZrZayDPbWJsARv4e/LiZMyIPNef/DBdCft2HUyuSAAQhB87ZrybXg2vkhY1LuDPmbTjjrvD20eK8N5PNzZMye0bwd3ZhmuFqN/3qL/mDgH95i5M=;
X-YMail-OSG: 5MFdV5AVM1mdS8Mvo_uxfx_yL938VD74qjlTTfn1GWKiyPp
 viz19bM4XSZhOtuZqCC8_PFB9K4L89EQPb52UQieFa8NR_VEWGr.U.8JAU8C
 .Qtgb1F4oXcedeb4VimTgL4VhOLERw8EALaUooia.nJVCDxu7ODhHrGJhHjL
 mEHVqzPRUBu7QIXuaR.9MyUCR8j_85LqUJDMCmYHVjRdtPFThl7Zf7FHv.cG
 oKchRdf0AjWPsIXoSg9leguWs8WQISXIDSbUHySBK9399O9dg7UFv90sqV.M
 VgDyzWNpcwzCFT_mYlQKt7bSPHrAazOpFqa_XOvIpVNghrcYkn8.h6tErC6a
 7LklvpDhCeA25Q2WJDOkTMHXG096QmXuf_bxxUbiKLQRIgBpJSaGmtVdH1eT
 rpWNAQh33BAFUyYrpZigvTLunBtojlnYg4zoItLdR8w6iM8Jqm744blF8OvC
 I2X2nPzkqiRoy0hNfNdLXoRbJHtG5VOveVDpZHMeBohtY9dmE1cH9ehSRKJs
 tDr8-
Received: from [216.239.94.120] by web122505.mail.ne1.yahoo.com via HTTP; Mon, 08 Oct 2012 11:06:21 PDT
X-Mailer: YahooMailWebService/0.8.121.434
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207252>

Hi,

My thesis supervisor asked me to find a VCS. He wants to version-contro=
lled all his projects.


The needs are not that big, that is to say it is academic and research =
projects. A project can have dozens of=20
Word, PDF and program files (Stata do-files, SAS programs, SPPS syntaxe=
=20
files and R scripts) and their corresponding log files.

Like many people, I hesitate between Git and Subversion. I like the ide=
a of distributed version control system. But is that such a system elim=
inates the need for a real server ? Can we just=A0set up a=A0repository=
 on one of the computers in our workplace and give access=A0to that rep=
ository via a local connection or via a remote VPN connection ?=20

We do not need to work at the same time on a file. The work is not so i=
ntense. So, is it possible to lock a file while someone work on it ?

Thanks,=A0

=46ran=E7ois Maurice
Candidat =E0 la ma=EEtrise
D=E9partement de sociologie
Universit=E9 de Montr=E9al=A0=A0=A0=A0=A0=A0
