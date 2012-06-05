From: "J.V." <jvsrvcs@gmail.com>
Subject: How to pull force just one folder in dev tree?
Date: Tue, 05 Jun 2012 11:41:40 -0600
Message-ID: <4FCE44D4.6050805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 19:41:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbxlP-0006Kr-HF
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 19:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755499Ab2FERlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 13:41:46 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53996 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755457Ab2FERlp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 13:41:45 -0400
Received: by pbbrp8 with SMTP id rp8so7752844pbb.19
        for <git@vger.kernel.org>; Tue, 05 Jun 2012 10:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=/jx8rlNbVcq6xNEENgdJpxZmlI9M+R6H2BVgek3FodY=;
        b=JtzLsUBOhZ6cyTr2SoUnMZEJ0Ywmv/7RRq2ic1h5IijFSYa6MJ9+ODpp7aA5GvgeKN
         cB3kBThqFHomumeVcKQ27muK2owiasswWEPUYfECV2dYO65UsaocEo4r+7HyoHF2dasR
         uxwQFjd0KiZi0IDiW5jX2ZBzBb5/dVLAx3D3KfgPqTLQht+I1t1OWh77M4lW/iq8wJb2
         VQPk9MGUs8dyBjFtHgGGT3SLencaXaDmr3cpoGj3iTaTBqQzLo7btzXIQlW476AzafbU
         E4lZxM6IhQOOZUnY8NzCcTdy4xWiNIfDyENLOcGA5kLIgRhmfG6p3gBN4D0JOn2NIKdK
         T1nw==
Received: by 10.68.203.73 with SMTP id ko9mr50895173pbc.66.1338918104637;
        Tue, 05 Jun 2012 10:41:44 -0700 (PDT)
Received: from [10.21.1.60] ([64.55.39.36])
        by mx.google.com with ESMTPS id or8sm3062919pbb.12.2012.06.05.10.41.43
        (version=SSLv3 cipher=OTHER);
        Tue, 05 Jun 2012 10:41:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199272>

If I am in my source code tree down deep in a directory at the command 
line, how do I pull from a repo and force overwrite all files locally 
(and also get files that I deleted locally, just in the folder I am in?)

I do not want to do this for the entire repo, just the directory that I 
am in and also on the branch I am in.  I am not in the 'master' branch, 
but another branch.

so

  $git reset --hard HEAD

  Would probably do my entire local repo and from 'master' (even if I am 
not on master)?

---
I want to git force pull from the branch I am on locally (tracked to a 
branch on a remote bare repo) and force overwrite of all files locally & 
also get the files I may have deleted locally from the file system (not 
files deleted through git).

How do I practice this to see what would happen (or revert) your 
solution if there are problems?
