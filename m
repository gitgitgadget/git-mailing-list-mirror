From: Raza Ali <rali@ebi.ac.uk>
Subject: re-ignoring a force added file
Date: Tue, 13 Aug 2013 19:31:21 +0100
Message-ID: <520A7B79.4080306@ebi.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 13 20:37:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9JSn-0008Gb-4K
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 20:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758172Ab3HMSgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 14:36:53 -0400
Received: from mx1.ebi.ac.uk ([193.62.197.214]:57570 "EHLO mx1.ebi.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758024Ab3HMSgu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 14:36:50 -0400
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Aug 2013 14:36:50 EDT
Received: from mx1.ebi.ac.uk (localhost.localdomain [127.0.0.1])
	by localhost (Email Security Appliance) with SMTP id D76A813FA1E6_20A7B6FB
	for <git@vger.kernel.org>; Tue, 13 Aug 2013 18:31:11 +0000 (GMT)
Received: from [172.22.69.207] (raza-jummp.windows.ebi.ac.uk [172.22.69.207])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(Client did not present a certificate)
	by mx1.ebi.ac.uk (Sophos Email Appliance) with ESMTPSA id BFD7513FA055_20A7B6FF
	for <git@vger.kernel.org>; Tue, 13 Aug 2013 18:31:11 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232245>

Dear Git Mailing List,

I have force added a file we usually like to ignore (but keep in the 
repository). That was a change a while ago, and cannot be undone without 
serious pain. I would like to re-ignore the file though, as we dont want 
to track changes to it. Some of the options I came across are not useful 
for me. For example

git rm --cached FILE // removes the file from the remote repository if I 
push, not desirable
git update-index --assume-unchanged //Will ignore changes to the file 
locally, but someone else clones and the file is tracked for them.

What we would like is to go back to the old state of affairs: the file 
was in the working directory when someone cloned from the remote 
repository, but changes to the file werent tracked or committed.

Any help would be appreciated.

regards

Raza
