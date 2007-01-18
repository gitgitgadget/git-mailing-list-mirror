From: Andy Parkins <andyparkins@gmail.com>
Subject: git-cvsserver won't add new content on update
Date: Thu, 18 Jan 2007 16:16:35 +0000
Message-ID: <200701181616.38318.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jan 18 17:17:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7ZwV-0007QE-TZ
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 17:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbXARQQn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 11:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbXARQQn
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 11:16:43 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:31472 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932423AbXARQQn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 11:16:43 -0500
Received: by ug-out-1314.google.com with SMTP id 44so215779uga
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 08:16:41 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mTwZkAp60dU2zH/o2wySoUeUWj7rSFlYYu0h2Eigb6o/POHLj0N6Z9Oe6GnDO+5AsOh4JW8qFJkVx27Ys9LL2e+mCsi6AwnzgDSTLse+s9581juvx1RMxvTXRUI4TcfcYrr6Afu0jPIete7rYsrShcl46hLADQIz4synmAtrOKs=
Received: by 10.67.97.18 with SMTP id z18mr1482637ugl.1169137001499;
        Thu, 18 Jan 2007 08:16:41 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id e1sm1211032ugf.2007.01.18.08.16.40;
        Thu, 18 Jan 2007 08:16:41 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37119>

Hello,

I am trying to use git-cvsserver to supply CVS access to my git repository.  
The checkout worked okay, but now, during normal operation, I've made changes 
and added content.  After a cvs update the changed files all seem to have 
been updated as expected, however the added files are not being added.  
However, CVS is reporting that the file is added; but it never appears.

some/sub/directory$ cvs update
A some/sub/directory/file.c

After the above the file is not created.  Repeated cvs update calls result in 
the same output everytime.  I've tried it from the root of the tree (in case 
it was a path issue) and that fails in the same way.  I've tried specifying 
the path explicitly and that doesn't help either.  cvs status reports that 
the file is "Status: Needs Checkout".

A new cvs checkout in a different directory does get the new file, so this is 
a problem with updates only.

I'm not familiar with CVS so it could easily be that I've not understood; 
however the CVS tutorials say that this should be giving "U" output instead 
of "A" output.

So: is this a bug, or is it that (as usual) I've not done something terribly 
simple.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
