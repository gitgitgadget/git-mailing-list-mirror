From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [GSoC] Designing a faster index format
Date: Tue, 20 Mar 2012 22:17:48 +0100
Message-ID: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 22:18:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA6Rc-0000xk-O7
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 22:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758022Ab2CTVSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 17:18:12 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40152 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832Ab2CTVSK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Mar 2012 17:18:10 -0400
Received: by dajr28 with SMTP id r28so529387daj.19
        for <git@vger.kernel.org>; Tue, 20 Mar 2012 14:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        bh=ZMX/jsJ7s9JZ0jc3kQFP8oXORXaA20HaFcryi87q4wo=;
        b=HAVW98VDVjDHJjPztnOTgy3oNtrhIJijBgnu2S8soPh/aGll4frljUkeL8JLNhHcUx
         4iPTf8YaXQdt6ISxEyfUwzQNr9QbIQGRJRtBoj93aN7/dEaWEXDM2M89fZN6d2PbR8rF
         SmPvElioBnkvtazKvq2SF5/RQB+zcWHu6jUDAI+O/aGVCcx8OXlwohOJvGMw3MDe+L2+
         pOW9krRYujQDyyoFnqkPer4tmhU3civAgxyQCAnjeTtydaYhN50GrulqJBL7DhA1FQ7N
         8JDHQvNnG8k2srwBt0ZvYtpIBKrqDE8xl2VkcWFFC9dAm+GjlQRxsx2eQoG3SNYY5/Op
         hqSw==
Received: by 10.68.194.39 with SMTP id ht7mr4800087pbc.31.1332278290294;
        Tue, 20 Mar 2012 14:18:10 -0700 (PDT)
Received: from [192.168.10.15] ([216.18.212.218])
        by mx.google.com with ESMTPS id h6sm2054342pbj.44.2012.03.20.14.18.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Mar 2012 14:18:09 -0700 (PDT)
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193541>

Hello,

I'm Thomas Gummerer (@tgummerer on Twitter, tgummerer on IRC), 21 years old from Italy. I'm currently a 3rd year Bachelor student in Applied Computer Science at the Free University of Bolzano. I started programming in High School about 8 years ago with Pascal and then learned C and Java. For some of my projects you can visit my homepage (http://tgummerer.com/projects), most of them are from university and some personal projects I did in my free time. My blog is also on the same homepage, but not really active. Unfortunately I couldn't yet participate in any bigger open source project, although I'm interested in it basically since I started programming. 

I would be interested in the Designing a faster index format project for Google Summer of Code. I'm using git for every project where it is possible after switching to it 2-3 years ago from svn. It would be awesome to be able to contribute to it and make it faster. I think this project could be a good fit for me, because I like trying to optimize data structures and algorithms for the best performance possible.

There are some questions I would have about the project.
Has there already been any development or thoughts in that direction?
In the description databases are mentioned, but that would probably make it harder to read for other .git-reading programs?

Thanks,
Thomas Gummerer
