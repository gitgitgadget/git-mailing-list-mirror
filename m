From: dhruva <dhruva@ymail.com>
Subject: Re: [PATCH] Optional shrinking of RCS keywords in git-p4
Date: Tue, 16 Sep 2008 10:23:34 +0530 (IST)
Message-ID: <98627.82548.qm@web95002.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, GIT SCM <git@vger.kernel.org>,
	Simon Hausmann <simon@lst.de>
To: David Brown <git@davidb.org>,
	Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Sep 16 06:54:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfSaQ-0001w1-LI
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 06:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbYIPExm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 00:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbYIPExm
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 00:53:42 -0400
Received: from n5b.bullet.mail.tp2.yahoo.com ([203.188.202.117]:30842 "HELO
	n5b.bullet.mail.tp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751144AbYIPExl convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 00:53:41 -0400
Received: from [203.188.202.76] by n5.bullet.mail.tp2.yahoo.com with NNFMP; 16 Sep 2008 04:53:39 -0000
Received: from [202.43.196.225] by t2.bullet.mail.tp2.yahoo.com with NNFMP; 16 Sep 2008 04:53:39 -0000
Received: from [203.212.168.61] by t2.bullet.tpe.yahoo.com with NNFMP; 16 Sep 2008 04:53:39 -0000
Received: from [203.104.17.89] by t2.bullet.kr1.yahoo.com with NNFMP; 16 Sep 2008 04:53:40 -0000
Received: from [127.0.0.1] by omp103.mail.in2.yahoo.com with NNFMP; 16 Sep 2008 04:53:35 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 398939.44771.bm@omp103.mail.in2.yahoo.com
Received: (qmail 82619 invoked by uid 60001); 16 Sep 2008 04:53:35 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ymail.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=1NPcE26ExxouIMk7Kiho+3ClVWg8ik5J70RSj2FPSwEbtIIMbJJ0Phba+W7TsIovumoegnuWImw/AY3HXvN/Flwmn2oadzzsFIOll+nbY0XUmk6vr1ghAtGSGgv2j2HkXXJHDql4C6aoZpvBfdNs/Nlz6mxBIYYCxu/mpo80hAI=;
X-YMail-OSG: LKIxueQVM1lvBb12eXKF_J__j54golNvayXLXm75h8vcJjW62RGzYl5jt_q237tE5g8x8HFsLuuUD50.q2PVJaCL6ZMTYGUtpxjMVp0JV58.XliVkcUbVzOLZaNTu0k-
Received: from [202.3.112.9] by web95002.mail.in2.yahoo.com via HTTP; Tue, 16 Sep 2008 10:23:34 IST
X-Mailer: YahooMailRC/1096.28 YahooMailWebService/0.7.218.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95970>

Hi,



----- Original Message ----
> From: David Brown <git@davidb.org>
> Part of the problem is that p4 isn't very good at knowing whether
> files have changed or not.  'p4 sync' will update the file _if_ if
> thinks your version is out of date, but it does nothing if someone has
> locally modified the file, hence the need for the 'p4 sync -f'.

If you have modified a file without doing a 'p4 edit' and if there is a new version of the edited file on p4 (from what you have got from a previous 'p4 sync'), 'p4 sync' will overwrite your changes (if the file does not have write perm set or if you have enabled clobbering of writable files). Whereas 'p4 sync -f' will always overwrite all unopened files if a newer version is available.

-dhruva



      Unlimited freedom, unlimited storage. Get it now, on http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html/
