From: Marius Seritan <mseritan@decodeideas.com>
Subject: hot to fix git svn import or just discard 'branches' folder
Date: Wed, 4 Feb 2009 09:03:07 -0800
Message-ID: <7E976223-6794-4E87-94A5-DEA224759700@decodeideas.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 18:04:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUlB2-00082r-JI
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 18:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666AbZBDRDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 12:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752728AbZBDRDN
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 12:03:13 -0500
Received: from el-out-1112.google.com ([209.85.162.182]:44584 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363AbZBDRDM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 12:03:12 -0500
Received: by el-out-1112.google.com with SMTP id b25so1111004elf.1
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 09:03:10 -0800 (PST)
Received: by 10.142.162.9 with SMTP id k9mr686309wfe.159.1233766988996;
        Wed, 04 Feb 2009 09:03:08 -0800 (PST)
Received: from ?192.168.12.2? (adsl-69-108-12-168.dsl.scrm01.pacbell.net [69.108.12.168])
        by mx.google.com with ESMTPS id 30sm11801523wfa.41.2009.02.04.09.03.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 09:03:08 -0800 (PST)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108394>

I imported over night an svn repository with the command:

git svn clone --prefix svn/ -r 860  http://svn.some.com/svn/someproject

The svn repository uses the usual trunk, branches, tag so I (wrongly?)  
assumed I do not need to pass any command switches regarding the  
structure of the repo.

I obviously did something wrong because now I have a git repository  
with just one remote branch and it contains the folders trunk,  
branches and tag. I do not want to reimport because it is taking lots  
of time and bandwidth.

How can I fix this? I do not really need the old branches and tags, I  
want to be able to track new branches and I just want to have the  
trunk history.


Thanks for any pointers.

Marius
