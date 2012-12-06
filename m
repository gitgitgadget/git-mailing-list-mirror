From: Aleks <oles.slosko@gmail.com>
Subject: Git repository and Maven project
Date: Thu, 06 Dec 2012 23:00:14 +0200
Message-ID: <50C1075E.1060407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 06 22:00:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgiYw-0003ZR-AF
	for gcvg-git-2@plane.gmane.org; Thu, 06 Dec 2012 22:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755515Ab2LFVAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2012 16:00:18 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:64124 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755507Ab2LFVAO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2012 16:00:14 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so3879457eek.19
        for <git@vger.kernel.org>; Thu, 06 Dec 2012 13:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=YoPvAmpZTgyhyCwAq6fo+QChQLw1+LoHFtaeok4EOKM=;
        b=KdqSIwyOmXaebEMYr5mte1+bChXL1ab+tcBbNrNq8TFEbrhO8dNzHm5IU2mUN0DVqh
         D1my9Oe+ZLIZibuwTTiSfjzFEdS9jMv67ovSCpKSIs7xhwLb/6hv5WqTFKH0AWJg0dfG
         trXzLpXFHMbsZSpu3cDIZ9A7T7N5PrTwyNuAybEWW1A7UF99kZ/d4fbxHHyaA+3ZZb1K
         ChJmUCqLbDc15AtugUaC3PVgVPAz3FIse0EqUZ4PuDbSlCDMm3cyWJ2x+8EUnGMYOzu8
         jXDdDcDnA4ZYNilssfybW5FmEzUuBIje60FO44RHKYVE4wS9eSDvExWOnyBuW57EGLk7
         z0iQ==
Received: by 10.14.194.195 with SMTP id m43mr8939137een.44.1354827613484;
        Thu, 06 Dec 2012 13:00:13 -0800 (PST)
Received: from [192.168.1.100] ([195.28.30.95])
        by mx.google.com with ESMTPS id 44sm18259278eek.0.2012.12.06.13.00.11
        (version=SSLv3 cipher=OTHER);
        Thu, 06 Dec 2012 13:00:12 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211169>

Can you help to clarify such question.
We have 2 different projects.
Name of first project say "server".
Second - "client".
Every project has own maven build structure.
Server produces the war archive for deployment.
The Client project produces the client jar for testing Server application.
Aside from these projects we should store different artefacts like 
prototypes for developing pages for server project.
There are two opinions about approach to arrangement git repository.

1) Create one repository https://git.org/my-project/src
Create 3 separate folders inside of src directory. So we will have such 
structure :
root of repository https://git.org/my-project/src/
contains 2 different maven projects and folder for prototypes files
https://git.org/my-project/src/server
https://git.org/my-project/src/client
https://git.org/my-project/src/prototypes

2)Create for every maven project and prototypes separate repository.
https://git.org/my-server/src
https://git.org/my-client/src
https://git.org/prototypes/src

The root of maven project begins from src folder in every repository ( 
https://git.org/my-server/src and https://git.org/my-client/src)
The xml files and images of prototypes will be inside of 
https://git.org/prototypes/src
I believe the second approach more proper git-approach.
Such approach allows team to use such advanced git features like 
branging, merging, stash etc.

What approach is proper?


-- 

Best regards
Aleks
