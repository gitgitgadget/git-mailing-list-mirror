From: Jeroen Michiel <jmichiel@yahoo.com>
Subject: Repository corrupt after push
Date: Tue, 9 Feb 2010 02:38:32 -0800 (PST)
Message-ID: <185094.23660.qm@web65505.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 11:38:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NenUP-0006k4-HT
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 11:38:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893Ab0BIKie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 05:38:34 -0500
Received: from n6.bullet.mail.ac4.yahoo.com ([76.13.13.234]:46520 "HELO
	n6.bullet.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753335Ab0BIKid convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 9 Feb 2010 05:38:33 -0500
Received: from [76.13.13.26] by n6.bullet.mail.ac4.yahoo.com with NNFMP; 09 Feb 2010 10:38:32 -0000
Received: from [76.13.10.173] by t3.bullet.mail.ac4.yahoo.com with NNFMP; 09 Feb 2010 10:38:32 -0000
Received: from [127.0.0.1] by omp114.mail.ac4.yahoo.com with NNFMP; 09 Feb 2010 10:38:32 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 399185.46618.bm@omp114.mail.ac4.yahoo.com
Received: (qmail 24660 invoked by uid 60001); 9 Feb 2010 10:38:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1265711912; bh=p8WPWif1LwagAzmHrxKI+QIycXPuXRZGBLxriZyi21M=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=DAHimqtuJzZgDQSQzASX0OogFFJ1t9gpvCj6SEfTdngy8nM1M5cGZ6zX1DnObNcZifeGkvVgdG79vxe4x4X4qmPNRJFvH5VdAREpsnN4WwG4gRukTZxHbfOeYwvyY8hu3zb0GKJyfydzMIU7Tla+6mQkpaJQI0wo7nmzUBdq4iY=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=OSEcGQYsIwGgIfvewAeX4H4LzwbbXp9nDftIMpycapGkr6ihFb+/oA3b3b2yR+vIkvndNEnr3AKkzWlT/mD3Qo9G/OOdv/JjN+h4fcMMWUB0vt3tZZgX/zBI9FO8DQljchKgfJStkjigYtYkU4mtPulH60yKWetZcftyxFlg8QY=;
X-YMail-OSG: ImBN5FgVM1kQOop7Sweav8QPueEu7Ay7o2gkdyGtlBjS8sv5LUIPhCIJcr1FyHesSQkcgNkuw1NhruZgKAoBmVfo459scpi_Eit9UDWdPpgFBVjilUCW2tAGl7tymbTMWZoPQOx8RvHE1gvQCzV0Nif9C7X5OakN6vkLpdaICp0we07qre5MDryfenzla9iTaLDMYn7lT6mh8YItOMGzdkBNPCpsuQ9pvBrbGV4v_pU9MDj1.4KsM0_dHTd97gcgENuN2UZLGt6JWW0Fg9ybRfqLvwFx5AbZB7p1LXKEdh3.TFKKiwlymr8D3e5MUomueP2gXAWw3rle0U7FfuRNMg--
Received: from [194.78.31.114] by web65505.mail.ac4.yahoo.com via HTTP; Tue, 09 Feb 2010 02:38:32 PST
X-Mailer: YahooMailRC/272.8 YahooMailWebService/0.8.100.260964
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139393>

Hi,

I'm trying to run a git server on my synology Diskstation DS108j with gitosis.
I can clone the gitosis-admin.git reposotory, but if I edit the gitosis.conf file, commit and then try to push to the server, the repository on the server ends up being corrupt. My client PC is running Windows (tried on XP and 7) git Git Extensions. I tried with Git Extensions, Git GUI and Git Bash, but it all ends up being corrupt.
What can be causing this?

Any hints and help appreciated!
Jeroen


      
