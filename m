From: Nick Colgan <nick.colgan@gmail.com>
Subject: Projects within projects
Date: Thu, 29 Oct 2009 14:40:36 -0400
Message-ID: <ab1d51700910291140ncd80027j4ee9a30637d7bc40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 19:40:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ZvQ-0005QD-0e
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 19:40:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755041AbZJ2Ske (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 14:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755009AbZJ2Skd
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 14:40:33 -0400
Received: from mail-bw0-f227.google.com ([209.85.218.227]:41896 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753620AbZJ2Skd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 14:40:33 -0400
Received: by bwz27 with SMTP id 27so2653541bwz.21
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=h8XXlwi25JZlyLcoqwuzDTXljTDe2YNwVHcJKnr+y9Y=;
        b=nIn5+ABEIuHF9vCYjDGpxfWtuWb3XnOLmNQSYCBz3Ok1RQaobDEg3EVqUvLjoZ08c1
         6i+1ILMT9iLpSx/QBFHhaG1E0k1w1a2iQ4bT3QWGncyESOEHq4lO3elsN6RPOGQWFTh0
         /iIoOXGai19hQxCs17BN6BWOizo+XQWJnaJVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=d+uonu6ZRIb7JMHVxhwO+VZlKUvl50u6ddHqjpd5vtQCWQmS3FLPzUTXadnJsMFEif
         yicBv2Crgysl8tD0nMUb6ALKFw3nvPzM5PfSPU/uFHVSNqGURCJowdoX8WpZkUEsVNDN
         vRSWCH2kfC4rx7NwJqsoYFmcma35k3i7KcRWs=
Received: by 10.103.84.30 with SMTP id m30mr186819mul.23.1256841636771; Thu, 
	29 Oct 2009 11:40:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131643>

I'm currently working on a project made up of parts that could each be
considered a project in itself. I plan on using redmine or trac to
manage the project. Now I'm trying to figure out how to manage the
repo(s) for the project.

These are the current options I have in mind:

1. Create a separate repository for each sub-project and manage each
separately in redmine (separate bug tracker, wiki, etc.)

2. Create a single repository with a subdirectory for each sub-project.

3. Use git submodules or subversion externals to combine options 1 and 2
by creating a separate repo for each sub-project, then creating a master
repo with subdirectory for each sub-project that imports from their
respective repositories.

What's the best way to handle this situation? Are git submodules and/or
svn externals sufficiently capable of dealing with this?

Thanks,
nic.
