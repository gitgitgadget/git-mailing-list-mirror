From: dhruva <dhruva@ymail.com>
Subject: git-p4: redirecting p4 error messages
Date: Wed, 10 Sep 2008 12:44:40 +0530 (IST)
Message-ID: <958499.27161.qm@web95016.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Simon Hausmann <simon@lst.de>
To: GIT SCM <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 10 09:15:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdJvh-0001jf-7U
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 09:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbYIJHOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 03:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbYIJHOo
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 03:14:44 -0400
Received: from n1b.bullet.mail.tp2.yahoo.com ([203.188.202.108]:28059 "HELO
	n1b.bullet.mail.tp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751142AbYIJHOn convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 03:14:43 -0400
Received: from [203.188.202.70] by n1.bullet.mail.tp2.yahoo.com with NNFMP; 10 Sep 2008 07:14:42 -0000
Received: from [202.43.196.224] by t1.bullet.mail.tp2.yahoo.com with NNFMP; 10 Sep 2008 07:14:42 -0000
Received: from [203.212.168.60] by t1.bullet.tpe.yahoo.com with NNFMP; 10 Sep 2008 07:14:42 -0000
Received: from [203.104.18.54] by t1.bullet.kr1.yahoo.com with NNFMP; 10 Sep 2008 07:14:42 -0000
Received: from [127.0.0.1] by omp106.mail.in2.yahoo.com with NNFMP; 10 Sep 2008 07:14:41 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 164555.61196.bm@omp106.mail.in2.yahoo.com
Received: (qmail 27202 invoked by uid 60001); 10 Sep 2008 07:14:41 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ymail.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=E5fJ/IX3hNYiXbgEU2CjKeLInHEJNrEj/VQE2057nD5sERhVLOlO5AvlyPRNDFm9VCAqsDIDcgTocFdkAc00TlGjDbNT7HyxSLxnBjyA/NcBnKlVS3B0VpAK7n0KjfdUDVu0SX7LZHNkQTiAVwWBfB0vmjR0eqjtpaBw96t1b6I=;
X-YMail-OSG: JrIByaAVM1nXldKEpE7Z3TXInjlwnlPDfmx2sygCe2iNHTgOksuqhx2o1LZWFw36GDmkwM59PLVl8HR7hPPCFMloDJ5F4B7eQs.odCdHNxX5Ze8a.bkdJL4IgbJD.q0-
Received: from [202.3.112.9] by web95016.mail.in2.yahoo.com via HTTP; Wed, 10 Sep 2008 12:44:40 IST
X-Mailer: YahooMailRC/1096.28 YahooMailWebService/0.7.218.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95490>

Hi,
 In our environment, there are lot of client side hooks in p4. They give lot of verbose information that clutters the useful output of git-p4. I have therefore added an option to redirect p4 stderr to anywhere (file or /dev/null or stdout) optionally. Would that be useful?
 Since I am actively working on git-p4, I would like to know what features the git-p4 user community would like to have. That will give me more ideas and I can chip in and implement them.

-dhruva



      Unlimited freedom, unlimited storage. Get it now, on http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html/
