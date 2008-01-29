From: Max Pollard <ajaxsupremo@yahoo.com>
Subject: Can git log <file> follow log of its origins?
Date: Tue, 29 Jan 2008 09:48:05 -0800 (PST)
Message-ID: <333479.13589.qm@web45901.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 18:48:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJuZf-0006O9-2d
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 18:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbYA2RsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 12:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbYA2RsJ
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 12:48:09 -0500
Received: from n9a.bullet.ukl.yahoo.com ([217.146.183.157]:24222 "HELO
	n9a.bullet.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750785AbYA2RsH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 12:48:07 -0500
Received: from [217.12.4.215] by n9.bullet.ukl.yahoo.com with NNFMP; 29 Jan 2008 17:48:06 -0000
Received: from [216.252.122.219] by t2.bullet.ukl.yahoo.com with NNFMP; 29 Jan 2008 17:48:06 -0000
Received: from [69.147.65.155] by t4.bullet.sp1.yahoo.com with NNFMP; 29 Jan 2008 17:48:05 -0000
Received: from [127.0.0.1] by omp403.mail.sp1.yahoo.com with NNFMP; 29 Jan 2008 17:48:05 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 703588.54152.bm@omp403.mail.sp1.yahoo.com
Received: (qmail 13809 invoked by uid 60001); 29 Jan 2008 17:48:05 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=cfjJqjJIrKkCRUHaoaHVFbMbdcmvnOWiqQZ3iwTuBzF3M0P0xHirfHMO/p/BH23l8FuiYW7q9ZYMxzHrTJ0ak1i56OsdLE4W16LcIKH0l0ADgRHhu/bWzRvNM+zPBEbgA7ft1P7O4+nonWai1Z4UlPTAPRfQsA2GZqCTaCFrAd8=;
X-YMail-OSG: WAz0.NMVM1n_t_8bQWaWiPfLOZoT2IozNYBDB.MXBLQzApdi27J185KLxZ8KKkIy4UUX9d6KGErvBuN6V4CQA8wfXw--
Received: from [76.103.40.65] by web45901.mail.sp1.yahoo.com via HTTP; Tue, 29 Jan 2008 09:48:05 PST
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71984>

Hi all,

If I do the following:

     $ git init
     $ echo "The brown fox is getting old" > a.txt
     $ git add a.txt
     $ git commit -m "Commit a.txt"

     $ cp a.txt b.txt
     $ git add b.txt
     $ git commit -m "Copy a.txt to b.txt"

     $ git log b.txt

I only see the log corresponding to the 2nd commit (v1.5.3.5).  Is it possible
to have the above command keep going and show the history of a.txt?  Or at
least somehow indicate that b.txt originated from a.txt?


Thanks,
MP



      ____________________________________________________________________________________
Never miss a thing.  Make Yahoo your home page. 
http://www.yahoo.com/r/hs
