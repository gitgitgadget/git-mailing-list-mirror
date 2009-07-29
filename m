From: Matthieu Stigler <matthieu.stigler@gmail.com>
Subject: How to push properly a la subversion
Date: Wed, 29 Jul 2009 20:32:46 +0200
Message-ID: <4A7095CE.8030307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 29 20:39:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWE3N-0004jn-JY
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 20:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891AbZG2Si5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 14:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752869AbZG2Si4
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 14:38:56 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:58914 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbZG2Si4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 14:38:56 -0400
Received: by ey-out-2122.google.com with SMTP id 9so253680eyd.37
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 11:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=JM7ao6yiBR4XCyFhD5tabR6/aO7eCtSbWVaGFVj+vJI=;
        b=ogYTklcgkcL9JNrRWekAPCLuPKq5jgfcx6whPrz5P+AhTg9ODMPEtfcBFn696ZFfBB
         mQog8wwEa9QTZCHIhFX3JAr4dN/GixzAYGP07KRB1AK7G8DawbDbQ6uNEey7s57f7+pg
         1Q1pj859glJsj3vVkiFkypP19J9QhR1CGGp0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=rYYAeFoPcixBA6EvpwfuN/iArscgVSluXCAFbZvJj6RdP6etBHaJ4H7RAxciCpjow6
         iE/5S2XBekI4WWGphgFtURmDrQd8/kFUPci9NPIcf3gDKELEX4geEx1w6Da1k0dVGOF0
         uDOJ0gHY2jZ+5bSPYj5k2F5sABKUm0S+UBYhQ=
Received: by 10.210.58.13 with SMTP id g13mr139700eba.51.1248892369052;
        Wed, 29 Jul 2009 11:32:49 -0700 (PDT)
Received: from ?192.168.123.101? (84-74-99-166.dclient.hispeed.ch [84.74.99.166])
        by mx.google.com with ESMTPS id 5sm294708eyf.44.2009.07.29.11.32.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Jul 2009 11:32:48 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124379>

Hi

I'm discovering git switchig from svn, so I'm still confused... I want 
actually to use git but keeping this idea of one common/public repo that 
different users push/pull from.

I tried just by cloning A to B, changing/commiting B and the pushing to 
A but: then on A the last log is integrated but I have this message with 
gitk "local changes checked in to index but not commited", and those 
local  changes are actually the version of A before the commit from B 
:-( What I expected with svn mentality is that A is changed and updated...

So 2 questions:
-how to remedy?
-hot to avoid?

I could remedy on A by git reset --hard, but ideally I would not need to 
remedy to that...

Should I enter a specifical push option? Or rather work on section 
"Setting up a shared repository"? in 
http://www.kernel.org/pub/software/scm/git/docs/gitcvs-migration.html ?
I tried to do it entering:

$ mkdir /pub/my-repo.git
$ cd /pub/my-repo.git
$ git --bare init --shared
$ git --bare fetch /home/alice/myproject master:master

but then I get also this message "local changes checked in to index but 
not commited" and especially there are many git files appearing that we 
would not want to see.... And furthermore it seems there are complicated 
permissions/ssh issues that I don't need (I'm doing for now only locally).

So can those new files be avoided? What is the best way to set-up git to 
have kind of central repo?

Thanks for your precious help!!

Matthieu Stigler
