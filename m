From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] State correct usage of backticks for options in man pages
 in the coding guidelines
Date: Wed, 13 Nov 2013 15:34:55 +0530
Message-ID: <CALkWK0nD4aYQYVdfP=Dbb+XhYOHz=Ffvb_EzdgyYU86yXcXdjg@mail.gmail.com>
References: <1384316501-27965-1-git-send-email-jstjohn@purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: "Jason St. John" <jstjohn@purdue.edu>
X-From: git-owner@vger.kernel.org Wed Nov 13 11:05:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgXKQ-0008Ja-CA
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 11:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758878Ab3KMKFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 05:05:37 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:54056 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758759Ab3KMKFg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Nov 2013 05:05:36 -0500
Received: by mail-ie0-f180.google.com with SMTP id qd12so195135ieb.11
        for <git@vger.kernel.org>; Wed, 13 Nov 2013 02:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lEskrWZ7oKSbk1hIA1QZTCwu2olsHdFhVwsG+0DtKwk=;
        b=BT5QgdLW+vNZ4gVTUuzf73rnNb5LhLawt02eYckNSUqgHpo+VU+GVt7OmF4vy+AExK
         Bf9vhRwjVDOgZ43Tl42FVETSdsEUwisj7/JrWsADlFuBNQdN6wXl8yLf0FKQTru0cPr6
         e0TvBEgfk1KhMTTWKS4fI2FPWpcfPVD0P/alY+1rnkKnPwtcb0x6eQGTDN7I1kV9o1Io
         B/HNbQk18RHjEzVKHpp/P+x47WLklnzBn6rEOHzTTLNhfsCKzBWNTdLC+2DdQVUNc52h
         LDGl9RQltxB8huoc6ny29byWCajjfEqXneXFRTbsq4Gl2VpyX3n+eH6y1BN6KA0WP/r1
         NWoQ==
X-Received: by 10.50.61.205 with SMTP id s13mr18237669igr.29.1384337135563;
 Wed, 13 Nov 2013 02:05:35 -0800 (PST)
Received: by 10.64.73.36 with HTTP; Wed, 13 Nov 2013 02:04:55 -0800 (PST)
In-Reply-To: <1384316501-27965-1-git-send-email-jstjohn@purdue.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237786>

Jason St. John wrote:
> + Backticks are used around options or commands:
> +   `--pretty=oneline`
> +   `git rev-list`

You might want to include configuration variables like
`remote.pushdefault` here.
