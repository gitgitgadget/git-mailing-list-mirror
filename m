From: Namit Bhalla <namitbhalla@yahoo.com>
Subject: organizing multiple repositories with dependencies
Date: Mon, 16 Apr 2012 02:27:12 -0700 (PDT)
Message-ID: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com>
Reply-To: Namit Bhalla <namitbhalla@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 11:34:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJiJl-0007L9-NI
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 11:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464Ab2DPJds convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 05:33:48 -0400
Received: from nm8.bullet.mail.ac4.yahoo.com ([98.139.52.205]:38601 "HELO
	nm8.bullet.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751360Ab2DPJds convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 05:33:48 -0400
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Apr 2012 05:33:47 EDT
Received: from [98.139.52.195] by nm8.bullet.mail.ac4.yahoo.com with NNFMP; 16 Apr 2012 09:27:12 -0000
Received: from [98.139.52.130] by tm8.bullet.mail.ac4.yahoo.com with NNFMP; 16 Apr 2012 09:27:12 -0000
Received: from [127.0.0.1] by omp1013.mail.ac4.yahoo.com with NNFMP; 16 Apr 2012 09:27:12 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 712371.50100.bm@omp1013.mail.ac4.yahoo.com
Received: (qmail 64564 invoked by uid 60001); 16 Apr 2012 09:27:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1334568432; bh=44ROhOErlrKzWyaoAY0M/xGa+ta+c0+bzDz/29v4nFg=; h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=mtpArnc7N8xAB3bHP9QMmuClhia6LoT64c7HyoqjoJcZ7j+OkZbGO4M6dcJHJvlKgb+veuNYCi4YZOuBSw5RAzAgh3J0tBl/0w/G9ElmwmcUyrsNbYCr6ko9N69UP4HY4E/iHjUChtIW/XLm1yxB4erm7ulT+WeohmjyEEA8+KM=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=1kA9lO2nY734PrYZY4IKHd3IQVqfuA/81cxCxe9SB4JEhbc30vEJpGM5c3lt1lBzd8KVF+FzCwCpyVO/N5cgbTyejOXnuJ0JoD29kaIIUbKkQDx5nLPuAot3F2W1T0x9E64eSBOCsQQGJ/0lIpamdlSGa++M8ZCLAgOa29aGyNQ=;
X-YMail-OSG: 7grkEMMVM1l1DRHVZ40WCpHJWK2Nc8YPVnTRq01ZfMbwxX3
 gDQyQ.1eVwuwmO_OIOge9Qv_.TDUM7ZaH1l2bEcJale61HzzQFru5dRNYU0R
 SMofcr1SMz1MEh.tQO92CFfXskND_dRdjHr_FO4KHAFyfk6DfkB1A0IDc2zR
 B7wxX0f7gKylfrlW0pQ9Oo41SJg_110ljONk.s2v5QAVk3XDK0NYC9M7uTqo
 zPLyku5W3hQQ5Jqf5DEipv6Extq_lZn3ho6Y1hzs51S1BrgjMcxddM77ZBcD
 n9OujkhO1rVhFUYHN99AR3ts5EpL4JbMCME0ht9VL9D7.gyT7cXhcE7ocl0h
 40nrEuVx2JQ_25C1lfX6Uo8_E8Fi_Pdd4r8iDPVaEeBiHXesG.2kfYHF1Zwz
 DQPoJMkvLRMMNmSZ7CsBrzuSqdGxKNazjTsb6Yvab.EUXGxUdhfduzFn_edR
 uEA--
Received: from [194.121.90.163] by web65906.mail.ac4.yahoo.com via HTTP; Mon, 16 Apr 2012 02:27:12 PDT
X-Mailer: YahooMailWebService/0.8.117.340979
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195604>

I am looking to track some projects using Git with each project as a=20
separate repository.
Even after reading the documentation, I am still wondering if there is =
a=20
way to organize things as described below.

Consider 2 projects, Project-a and Project-b, which are housed in=20
repositories Repo-a and Repo-b respectively.=A0
Project-a develops reusable libraries which are needed by Project-b=20
(otherwise Project-b will not compile).
When a new stable version of Project-a libraries has to be delivered, t=
hey=20
are "checked into" a path in Repo-a.
Now, I would like to setup Repo-b so that when someone starts working o=
n=20
Project-b, he should be able to retrieve the code from Repo-b as well a=
s the libraries from Repo-a. Is there any way to achieve that in=20
Git?

Thanks for any pointers!
