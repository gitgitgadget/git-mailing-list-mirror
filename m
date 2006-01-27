From: Aneesh Kumar <aneesh.kumar@gmail.com>
Subject: git rev-list
Date: Fri, 27 Jan 2006 09:16:58 +0530
Message-ID: <cc723f590601261946h101d7000oa1990c31c5b642fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Jan 27 04:47:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F2KZl-0003Q4-Ap
	for gcvg-git@gmane.org; Fri, 27 Jan 2006 04:47:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbWA0DrB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jan 2006 22:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbWA0DrB
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jan 2006 22:47:01 -0500
Received: from uproxy.gmail.com ([66.249.92.195]:32537 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030286AbWA0DrA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2006 22:47:00 -0500
Received: by uproxy.gmail.com with SMTP id s2so96905uge
        for <git@vger.kernel.org>; Thu, 26 Jan 2006 19:46:58 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kz4DbOJrTvsGFd9VMTBC+bfLQXzZdNKd++qxY3z2r8411mxU8bCbGQVhDeC3GwQ7L3xdOuGbkdJEFFs2OynQiPHofxZPNNaEsvBSyFLFIQL4yiudj769wpK3mZWuQ4/JEfmSoiPwsPDfiLH0UdyK6f+dQLGM+8QPiEodI/Gnh4k=
Received: by 10.66.250.9 with SMTP id x9mr135926ugh;
        Thu, 26 Jan 2006 19:46:58 -0800 (PST)
Received: by 10.66.254.16 with HTTP; Thu, 26 Jan 2006 19:46:58 -0800 (PST)
To: junkio@cox.net, git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15175>

I am right now making a gnome based git repository browser [1] . I use
git-rev-list to get the revision list. What i found is  that from the
second commit on wards i am finding some control character at the
beginning of the first line with respect to each commit. You can
reproduce it easily by redirecting the output to a file and reading
the file using vi. I am using the latest git built from git repository

[1] http://www.flickr.com/photos/17388011@N00/91636482/
This is based on bzrk GUI frontend to bazaar and written in python

-aneesh
