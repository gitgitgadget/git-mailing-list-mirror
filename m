From: Yang Zhang <yanghatespam@gmail.com>
Subject: git svn woes
Date: Wed, 05 Nov 2008 13:52:41 -0500
Message-ID: <4911EB79.5070803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 05 19:54:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxnWD-00082j-Tc
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 19:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756724AbYKESwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 13:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753320AbYKESwl
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 13:52:41 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:55245 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756721AbYKESwk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 13:52:40 -0500
Received: by yx-out-2324.google.com with SMTP id 8so85958yxm.1
        for <git@vger.kernel.org>; Wed, 05 Nov 2008 10:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=JNFz9tll+XT0QlEJs7QMYGF3wiNb3+WwO9vyWD8Gqpg=;
        b=nPBTlfw42gmbcC7onf71N+xxczU1BbG42eZFGIGdERxm3pLDAlGyGpqyAnYI2tRawO
         aAVLss4DeUjmZEKKqnfeTYBGknUsA/Anbe8+Rgi0B+aKBu7iEZ516r8BZXx6KWhyi72x
         sb15PM2AVJGYW0ZC0yPWYu0ZTmFsHv4I02UG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=C/KZ7bT9MeuAfgaXs4m11rfPMDaN1B2kcV66YN56Msg6HU/1gm2EvrHFStO2yoI2EW
         O9Fcm/WnBGrOLOttRVbnQ0iPdC5tpl5Q3R316NJBSJ3uMEWEJw6GHZnCrr3OKaCWsSsq
         8cMPG8kMsoF+2YIRwOBIT4UZ+FFtIKmPswP0Y=
Received: by 10.231.15.74 with SMTP id j10mr448393iba.10.1225911157902;
        Wed, 05 Nov 2008 10:52:37 -0800 (PST)
Received: from harvard.csail.mit.edu ( [18.26.1.77])
        by mx.google.com with ESMTPS id 5sm556288yxt.1.2008.11.05.10.52.36
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 05 Nov 2008 10:52:37 -0800 (PST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100173>

For some reason, I'm getting this error when trying to git svn rebase 
things from an svn repository to a git repository:

   error: patch failed: myfile:1
   error: myfile: patch does not apply

I have a simple bash script (and transcript of its output) demonstrating 
exactly what I mean:

http://assorted.svn.sourceforge.net/viewvc/assorted/sandbox/trunk/src/git/gitsvn.bash?revision=1056&view=markup

Any hints?  Thanks in advance!
-- 
Yang Zhang
http://www.mit.edu/~y_z/
