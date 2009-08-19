From: "Rob (gmail)" <robvanb@gmail.com>
Subject: New to Git / Questions about single user / multiple projects
Date: Tue, 18 Aug 2009 21:52:36 -0400
Message-ID: <a2db4dd50908181852s1e2c64fen8b883faf76b3136d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 19 03:53:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdaMJ-0000PQ-9o
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 03:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbZHSBwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 21:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbZHSBwz
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 21:52:55 -0400
Received: from mail-yw0-f173.google.com ([209.85.211.173]:50811 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbZHSBwy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 21:52:54 -0400
Received: by ywh3 with SMTP id 3so5813956ywh.22
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 18:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=ikJOsC8eBAppjZEdj8as790sOgPoRL2C1gqhi5A2C08=;
        b=F6EhdRGM1qcpAXxHdvmjZULua7+D06+fVFCpnqU+CmddDLsUnsfAZgga+FpHDdnhAk
         PD8m4NfPAPiVzbtGlmZ2CXRuN6rNXb0ZJZnFueZ88sCUj4YgviUAmh2Mx3zQorTjgI6+
         chsicMCQ6lFt64R6OO9xEisOI4U01na+lfkuo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=OYDHOV4mKHiUZhtVqCrUnWs9Kk/Xmri0I9t6MJTkCFK3+7BmQ3ve9IwN509i27bJ5h
         bhNBLzUMpBxxUqpA7GO81C2wKotlA4QKZTpIYUT6rOko07m/WpMdhL57UbLsdxC5YJnf
         344sVZrPfIHl6OLMplJVbVXL36wP5PFv9T+uQ=
Received: by 10.151.87.1 with SMTP id p1mr9278114ybl.116.1250646776045; Tue, 
	18 Aug 2009 18:52:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126496>

I'm new to git and have some (I think) basic questions that I have not
been able to find answers to in the documentation.
It's very possible that these are the result of my lack in
understanding git / version control, so feel free to point me to
documentation
that might contain the answers.

I'm doing ERP development for my job and various 'hobby' development
in my spare time.
I'd like to track/store/ version control the code that I write for
both work and play.
I am (currently) working by myself, no need to have multiple
developers working of the same code.

Q1:
Can I create a single repository (project?) for all my code, knowing
that there are multiple small, unrelated projects. Or should I create
a new repository for each project ?

Q2:
After initalizing my repository, and comitting the 1st batch of code:
When further working on the code, will the command "git add ." add all
changed and new files ? Or do I specifically need to list the new
files ?

Q3: Can I run 'git add x' in any subdirectory, or do I need to issue
if from the root of the project ?

Thanks,

Rob.

--
When in trouble or in doubt, run in circles, scream and shout
