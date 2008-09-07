From: dhruva <xshelf@yahoo.com>
Subject: git-p4
Date: Sun, 7 Sep 2008 18:47:37 +0530 (IST)
Message-ID: <967383.98362.qm@web95011.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 07 15:18:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcKAE-00080f-PS
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 15:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbYIGNRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 09:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753720AbYIGNRo
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 09:17:44 -0400
Received: from n3b.bullet.mail.tp2.yahoo.com ([203.188.202.110]:32489 "HELO
	n3b.bullet.mail.tp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753194AbYIGNRo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 7 Sep 2008 09:17:44 -0400
Received: from [203.188.202.76] by n3.bullet.mail.tp2.yahoo.com with NNFMP; 07 Sep 2008 13:17:42 -0000
Received: from [202.43.196.224] by t2.bullet.mail.tp2.yahoo.com with NNFMP; 07 Sep 2008 13:17:42 -0000
Received: from [203.212.168.61] by t1.bullet.tpe.yahoo.com with NNFMP; 07 Sep 2008 13:17:42 -0000
Received: from [203.104.18.48] by t2.bullet.kr1.yahoo.com with NNFMP; 07 Sep 2008 13:17:42 -0000
Received: from [127.0.0.1] by omp104.mail.in2.yahoo.com with NNFMP; 07 Sep 2008 13:17:38 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 162612.91362.bm@omp104.mail.in2.yahoo.com
Received: (qmail 98717 invoked by uid 60001); 7 Sep 2008 13:17:38 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=H5GLWq4qvTMoMS3ab2l3NKfKJHfIXM3W8QNa6B+PqqbwUyOlf4Dr0xhYL9MYHCd0UVKAdTlLGbX5N+Z2/+vc1Cfe0Q2Q6oIqiBP/60Wi0aXninEuegGWS44uzvFtRDd3QbI5xlLyhY+54rhX6eu0JtAMseDuXwLryF1ppnNx+G0=;
X-YMail-OSG: EE56vskVM1kiOu9b8wyt0AK07KkiWN.QAXnDVSH0EZ6BGmYZYzwS4ktgcePfwmFfAVWBsk8lDYw3RbcVOvM7Ye1bgYFQlXyYYvGpDK2lW5QxExm9e.yj3wA3n1JFlyY-
Received: from [59.92.137.244] by web95011.mail.in2.yahoo.com via HTTP; Sun, 07 Sep 2008 18:47:37 IST
X-Mailer: YahooMailRC/1096.28 YahooMailWebService/0.7.218.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95136>

Hi,
 I am eager to have a full blown git-p4 with ability to _seamlessly_ submit to perforce. The one way pulling of p4 changesets to git works fine except for the un-expanding of RCS keywords like "$Id: ......$" to "$Id$". When submiting back to p4, the file would not have recorded any diff in the keyword which would have changed in p4 due to modifications. Applying the patch during the submission process fails. Also, the 'git-p4 submit --continue' fails saying that '--continue' is an invalid argument.
 I can work on fixing these issues but need help from someone with knowledge of this script 'git-p4'. I have basic expereince in git and am a newbie in p4. I am willing to invest my time in this area. I have written a p4 to hg converter in perl which I have been using. I feel git-p4 is more complete than the script I have written especially in handling file mode.

-dhruva


      Bollywood news, movie reviews, film trailers and more! Go to http://in..movies.yahoo.com/
