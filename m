From: Andy Parkins <andyparkins@gmail.com>
Subject: Question about bare repositories
Date: Fri, 16 Mar 2007 09:47:02 +0000
Message-ID: <200703160947.03833.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 16 10:47:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS91t-000238-Vv
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 10:47:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933278AbXCPJrK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 05:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933284AbXCPJrK
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 05:47:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:49152 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933278AbXCPJrI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 05:47:08 -0400
Received: by nf-out-0910.google.com with SMTP id o25so181803nfa
        for <git@vger.kernel.org>; Fri, 16 Mar 2007 02:47:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qXXXyLizcYSlYg0VZzYd7Yswh9hozFcBVkkLUcqS+mQKPFnqSeN/dbERbVNTFjMXKNwKuKzMUbzN68rDi2NEZIKWqKty9raABVFh+0dqM0iHZzfzTNfmNyGpI0Z2AUUlORoSXEJAgG+ict7cyarkL859GI+Kp/eiZeAZugdaJ68=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Q1xaRgyPuT32KxTvUMxXgg2jN2aIj9zMDiSAR4ddnhMprCxze9R4+Mf8uX0ghX0QJ/XRt2ViOEw1EIpWmWMCpHAh/eBgwJ9iCSvLvIXu5RoL8M87O3XoReYP3m+vYdrh5DwkXcqd+LHXJUx///1qg0mavE0bTUT82XZHdqjIlKs=
Received: by 10.78.203.13 with SMTP id a13mr850761hug.1174038426938;
        Fri, 16 Mar 2007 02:47:06 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id l21sm3717075nfc.2007.03.16.02.47.06;
        Fri, 16 Mar 2007 02:47:06 -0700 (PDT)
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42342>

Hello,

I'm having an understanding problem, rather than a git problem.  It came about 
because I was looking at a repository using gitweb.  The repository was bare, 
and happened to have HEAD pointing at an old branch that hadn't been updated 
for a long time.  I was confused because I wasn't seeing new commits.  Once I 
set HEAD to master in the bare repository, gitweb showed the new commits.

All that led me to this question, which isn't a criticism, but has exposed a 
hole in my understanding of git.

Why does a bare repository have/need a HEAD?



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
