From: "J.V." <jvsrvcs@gmail.com>
Subject: problem switching branches
Date: Tue, 26 Feb 2013 16:08:55 -0700
Message-ID: <512D4087.5070504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 27 00:09:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UATeJ-0005nG-5x
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 00:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759181Ab3BZXI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 18:08:58 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:37784 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758137Ab3BZXI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 18:08:57 -0500
Received: by mail-pb0-f44.google.com with SMTP id wz12so2676193pbc.3
        for <git@vger.kernel.org>; Tue, 26 Feb 2013 15:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=MsRBUsLKyfNqgpvERSxYu8AF855sKg1sQL1OiZ45gYU=;
        b=a4KZra6trfkirmdE3K/99VOaRHfqTJgjoRFzOh1+Lr3MY2CMeCrFGpC7NHMtaqJbUs
         D34+upzYrdhBXV5j3AZrgHmUrc88h3rQU6bfYViWrev9OZ0O98qdc4HA/25zJrTfjjs8
         6boaiQm/v7meoZIYg4LEvRB8+Y5pdbtWDp4iTWAa5uyhpcXFELwkxX4bXAr97DGMa0T6
         +U45v6lwx0LNbGzJ06g99R5MgK8y0KHa6PwCfrNEsg7k4zD+eW+nYYcAfQvaBQXUS68W
         EIetO8g0qPxYXw3SuinHe/1Uhr1EBqE4wCa1E2NhQ3fi4XxYj15mbjio4i3MtTN2OQhU
         T5MQ==
X-Received: by 10.68.197.4 with SMTP id iq4mr81631pbc.96.1361920136995;
        Tue, 26 Feb 2013 15:08:56 -0800 (PST)
Received: from [10.16.242.114] ([192.206.100.4])
        by mx.google.com with ESMTPS id dk1sm2316756pbc.15.2013.02.26.15.08.55
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 26 Feb 2013 15:08:56 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217190>

I was on my master branch, I then checked out a branch ( 
origin/somebranch ), made no updates
but did a few git pulls on the branch over about a week; then made a 
small change to only a single file & committed & pushed.

Now am trying to go back to my master branch and get:

error: The following untracked working tree files would be overwritten 
by checkout:
         lib/derbyclient.jar
Please move or remove them before you can switch branches.
Aborting


I did not put that jar file there (I edited a single config file), how 
do I now get back to my master branch?

I do not want to muck up the branch that I am now on by deleting anything.
Any ideas how this happened?

Obviously someone put derbyclient.jar there, not sure, but it is
supposed to be there so do not want to remove as advised.

any ideas on how I can get back to my master branch and get out of this?
