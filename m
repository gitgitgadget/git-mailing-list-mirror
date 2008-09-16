From: dhruva <dhruva@ymail.com>
Subject: multi-threading or processing of converts
Date: Tue, 16 Sep 2008 19:53:00 +0530 (IST)
Message-ID: <655551.96611.qm@web95006.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: GIT SCM <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 16 16:25:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfbTW-0003fO-Vk
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 16:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbYIPOXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 10:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752295AbYIPOXI
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 10:23:08 -0400
Received: from n2a.bullet.in.yahoo.com ([202.43.219.19]:42403 "HELO
	n2a.bullet.in.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753146AbYIPOXH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2008 10:23:07 -0400
Received: from [202.86.4.170] by n2.bullet.in.yahoo.com with NNFMP; 16 Sep 2008 14:23:00 -0000
Received: from [203.104.18.50] by t1.bullet.in.yahoo.com with NNFMP; 16 Sep 2008 14:23:00 -0000
Received: from [127.0.0.1] by omp111.mail.in2.yahoo.com with NNFMP; 16 Sep 2008 14:23:00 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 862891.28057.bm@omp111.mail.in2.yahoo.com
Received: (qmail 96983 invoked by uid 60001); 16 Sep 2008 14:23:00 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ymail.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=eQCFK7uPHpRPic25xqg0YICOx4pxhnh/Ql+ERhRbKBNZCUX8kBqjQnk5TkOZRbGFgi56BfnD1NdiSoxTYq5nt4eRFfJHDCVjh+CiqLa7q2zdxo5FCtyPLM4Sx56u0oP9sB8BWti5SQw/PeA8BTeXwfFlrIDk2ruUIVZ1a8EJDAk=;
X-YMail-OSG: ugUa694VM1l7ee1O3XqOPqWkr3f76qdVf0ENacHCpPVMa6DmYoXPGI3xxEQnoECnRi3t_I2dXSevINxD2sOBE2hHs6weFScVvNnD0v.iR9ToWbMIX9B6oyqLXsHBGpE-
Received: from [202.3.112.9] by web95006.mail.in2.yahoo.com via HTTP; Tue, 16 Sep 2008 19:53:00 IST
X-Mailer: YahooMailRC/1096.28 YahooMailWebService/0.7.218.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96006>

Hi,
 I am running git-p4 to import around 11147 changes from perforce, it has done 38% in 4h39m. Wonder if it would have been faster to get a bunch of changes in parallel and import them sequentially. I do understand that importing of full history does not happen too often by still it might be a good idea.
 Have a multi-threaded fetcher from source SCM and dump it in some format locally. git fast-import can pull it from the local at its own speed (which will be real fast). Basically, I am suggesting better using the available bandwidth and CPU resources for doing network IO.

-dhruva



      Cricket on your mind? Visit the ultimate cricket website. Enter http://in.sports.yahoo.com/cricket/
