From: "Martin Langhoff" <martin@laptop.org>
Subject: Teach git status to do "git diff --name-status HEAD"
Date: Wed, 17 Sep 2008 18:40:10 +1200
Message-ID: <aba84270809162340n4ea3f5feqc71d01fa6e035b79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 17 08:41:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfqj3-000148-Io
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 08:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbYIQGkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 02:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbYIQGkM
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 02:40:12 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:3272 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbYIQGkL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 02:40:11 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3045821rvb.1
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 23:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=01VeIjvsohCJotmIOC0KabAFsuot6qmZ39fB0wQ7vpM=;
        b=SNBUjBa1yUe9/exwI20hLBK5WkgFZ2xk8yEfTCUNJLI7kyU4A8zi4U/0K7K5pY9gCe
         wzzBwoW5oZBRU9mjxaumvpjQzzn91GrYcyOvZH1ZfgDdNBKrV3+9Ibuf/QVxKkiX/g+O
         E0r4oW+rDFIUxtdR1IeRaNP2WTnZRL7A5CQII=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=HfgV/jEg5TKmVeKSoTL3TLNqSYGxLJJMIq/XkZ+a3/ViylgFShGTgaO4zogcuojk0o
         Htfszb2AJWFonij44C6IIWWIBlPjVJ2e4psS2q1iiD04RbsdmDN2bTs+g/yNkVQPxCYz
         rRB4EKpR4fzps9pznT0P4Jc04V+I0ju/kE4nY=
Received: by 10.141.169.11 with SMTP id w11mr6278722rvo.104.1221633610461;
        Tue, 16 Sep 2008 23:40:10 -0700 (PDT)
Received: by 10.141.129.3 with HTTP; Tue, 16 Sep 2008 23:40:10 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 56160df5f300a738
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96068>

I just did

$ git checkout -b mdl19-offlinetony
A       README.offline
M       lib/javascript.php
    (...)
A       lib/offline/offlinemoodle.user.js

I *like* this "brief status" style - takes me back to my cvs days :-).
Perusing the source I found show_local_changes() which in turn led me
to trying `git diff --name-status HEAD`. Now, including 'HEAD' in an
alias defined in git config is going to lead to trouble... :-/

I might still make an alias to `git diff --name-status`. This would be
a great thing to have as git status "--brief" IMHO... :-)

cheers,



m
-- 
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
