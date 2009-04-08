From: John Bito <jwbito@gmail.com>
Subject: Egit: how to merge after fetch (or pull)
Date: Wed, 8 Apr 2009 14:56:23 -0700
Message-ID: <3ae83b000904081456i37ad65ate133469fa9a8f23c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 23:58:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrfmT-0000NP-6Z
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 23:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910AbZDHV42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 17:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753061AbZDHV41
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 17:56:27 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:6700 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837AbZDHV4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 17:56:25 -0400
Received: by yw-out-2324.google.com with SMTP id 5so347621ywb.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 14:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=texWfP6VcdOofAT1ErTstHQV4YDYh7X548sj1jmkYQQ=;
        b=sVwDbHBJVvtwgdd+lAiVzUAg9oRFYfl7GJRDNc8emb3DfO+3NmDmi3E6WUIInoMPXV
         6NhdCdhWP+pxamf/mtox+ojMfRl9nLPeIfOErO1ZalSWoOP5/7MXYJfplZDJOegEC0UR
         TBpPaegirHTkO7pvDDaj5uXm8UJqcB+gmhpgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=d2FbF50P48PKytOqUb0/DUuYEDR7LFdhMPpyy14dJ9v//Zp7vx8UGQI1zvYPA3xRZS
         4Y46KDKYuO7mJRq+3FcyJKoU+YSiCEPb7e4YWGzt0lWE2M0nCLmZLOxJANhKOTAT4JRR
         aJAHO71NDIK/VBjjzCtRL6m5+LKSWLspCEv+o=
Received: by 10.100.10.15 with SMTP id 15mr1163975anj.107.1239227783101; Wed, 
	08 Apr 2009 14:56:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116127>

I'd like to pull a branch before I do more work on it.  After fetch,
git status says the branch is behind origin by N commits.

Can you tell me if there is an operation I can do via egit to get the
origin changes onto my branch? (Most of the documentation I found for
Egit appears to be before the fetch command was implemented.)

In the mean time, I've been using 'git pull'. Unfortunately, I found
that it's important to shut down Eclipse while doing a git operation
using Cygwin - a GC run when Egit had a file open caused a problem in
the repository that subsequent pushes propagated to my GitHub
repository.  It would be nice to work entirely within Eclipse.

Thanks!
John
