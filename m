From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Fix typesetting in Bugs section of 'git-rebase' man page
 (web version)
Date: Tue, 19 Nov 2013 16:31:30 -0800
Message-ID: <20131120003130.GC4212@google.com>
References: <1384906483-15260-1-git-send-email-jstjohn@purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jason St. John" <jstjohn@purdue.edu>
X-From: git-owner@vger.kernel.org Wed Nov 20 01:31:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vivhj-0007IG-3S
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 01:31:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503Ab3KTAbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 19:31:35 -0500
Received: from mail-yh0-f43.google.com ([209.85.213.43]:35115 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166Ab3KTAbe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 19:31:34 -0500
Received: by mail-yh0-f43.google.com with SMTP id v1so4782885yhn.2
        for <git@vger.kernel.org>; Tue, 19 Nov 2013 16:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OzDwERM1qZVR7UQeH4kSb4b3/hBB6R0+PUGYY2EERpo=;
        b=xDueBqLOr2M06mXpAsNgqPlAcYtnC0jXdsrLBVxy2jlUqUy+ULK01pQcqKh9QpzJcY
         8dbOQ2sefqi9Tg6hIE+s7pZPxstdqmSIo5Egou1s/8l1sJETwColMetYru7XksTYIo5c
         JlGQ4XCG4958ByrwTvsnxSvcFHFHoRnP6uW8G76wtITJppjqY65eO5s6oGRV4b8Rwm+H
         5bJwdoOidkCqIO9abgayBTDjjmtKkYm+w/ZrU+aHVOkWq7zGZToF7QiecBlXnv/Of9Pb
         5P49R2SNA5/TfiQX241MVN95l0rydsFAsNMgW9I9cOvvbTJjgFaR8nIk0/Jea+zZDnj0
         P79A==
X-Received: by 10.236.231.84 with SMTP id k80mr25759191yhq.33.1384907493964;
        Tue, 19 Nov 2013 16:31:33 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id o27sm39036627yhb.19.2013.11.19.16.31.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 Nov 2013 16:31:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1384906483-15260-1-git-send-email-jstjohn@purdue.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238057>

Hi,

Jason St. John wrote:

> Documentation/git-rebase.txt: add a blank line after the two AsciiDoc
>     listing blocks

I'd leave out the above two description lines, since they're redundant
next to the patch text.

> Without these blank lines, AsciiDoc thinks the opening "-----" is a
> section heading and typesets the word "to" as such, which causes
> cascading formatting/typesetting issues until the end of the document.

Interesting.  Alas, I can't reproduce this.

Are you sure it is AsciiDoc that misinterprets the document, and not,
e.g., the predecessor of asciidoctor in gitscm-next?

Do

  Documentation/git-check-attr.txt
  Documentation/git-commit.txt
  Documentation/git-cvsserver.txt
  Documentation/git-p4.txt
  Documentation/git-svn.txt
  Documentation/gitcli.txt
  Documentation/gitweb.txt
  Documentation/mailmap.txt
  
avoid this problem?

Thanks and hope that helps,
Jonathan
