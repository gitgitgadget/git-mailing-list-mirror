From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 00/20] refs backend rebase on pu
Date: Thu, 04 Feb 2016 16:39:29 -0500
Organization: Twitter
Message-ID: <1454621969.5545.14.camel@twopensource.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
	 <1454443734.5545.1.camel@twopensource.com>
	 <CACsJy8Cw9CM+EBw85KM1RcDAsRY8LbTFWFUq0dLSHWY0NLPZMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 22:39:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRRcq-0002Nl-0k
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 22:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965606AbcBDVjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 16:39:33 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35665 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406AbcBDVjc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 16:39:32 -0500
Received: by mail-qk0-f176.google.com with SMTP id o6so26977344qkc.2
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 13:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=QwmTXjK/vL6LefqVlJTo4yXjLjGCA6fEjW3KVVhuheM=;
        b=mXqPNu3pLgX37MC6e+ONTq6MRrfxFpxyV9nTdMrLVh6cfRoFmHSZlfC1JxPzmLTotr
         T2axuXUk0OksdINTgeC45LLIhv6lDapjK3lwo6caGhYYIWafDmYA6WzzmJbUa9n3UtK/
         yJcgOz3GP3i44rknxTElpfp8+pr8PtFyrh6GEywYJ4/Doqclde5xrYWEUIB19FpP/xrq
         8hTqGZ5DeiWA7RsVGp9k9cZ9QKhky54MBCDlFPhuFJyMkmn/ALu/p0gniTnHmWbBvaf3
         4N71FCjVbTSDiAOeb3YfqpY8VHbiqvRr96dQE3gLzueUmVjQpc0IxScGfRUhnjyWoAij
         8sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=QwmTXjK/vL6LefqVlJTo4yXjLjGCA6fEjW3KVVhuheM=;
        b=kiXCvTRXHJEQi6CpHNJGefwJrr2wyRkOORN38iIinhB4RjfYnFqtbZtKQbl7bm6b+n
         UZfbb6Sh22O0Nsb4+vjeuIQHEdETw13rFfPAg/uxdrSCzAL/BVaz1/9KcaFtOOq6lzbp
         5+NstRUcG3aicyFPWML38LraoTfJfpeIJYBfsGC8YQ4akEVx6jSeGDXbsF8QJ5PgLbOk
         y7ccMP6oKdIgV72MPNSAt2t8Apkk4FLAIY2ndrZdEchj0PMCJs1dOIJcSSm6IU6DcRiq
         dalBGOiHjbq3lEtOi1+5/0stABBu5aLbgP85HIcnoSF3i+bqOopgIUgzp/VHUeMFEpp9
         +EkQ==
X-Gm-Message-State: AG10YORAL7rhNzKgYvy59x0yjrb3WITqeQu3/5UbBWENZbJhxtUwIXbUDlPchM/HqNt/Hg==
X-Received: by 10.55.23.212 with SMTP id 81mr11944393qkx.64.1454621970852;
        Thu, 04 Feb 2016 13:39:30 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e105sm6161125qgd.22.2016.02.04.13.39.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Feb 2016 13:39:29 -0800 (PST)
In-Reply-To: <CACsJy8Cw9CM+EBw85KM1RcDAsRY8LbTFWFUq0dLSHWY0NLPZMA@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285496>

On Thu, 2016-02-04 at 17:09 +0700, Duy Nguyen wrote:
> On Wed, Feb 3, 2016 at 3:08 AM, David Turner <
> dturner@twopensource.com> wrote:
> > Are there any more reviews on this?  I do have some changes from
> > this
> > set, but they're pretty minor so I don't want to post a new one
> > (unless
> > folks would rather see those changes before reviewing).  Let me
> > know.
> 
> I think you need to keep "refs" directory back somehow. Without it
> (e.g. "git init --ref-storage=lmdb" does not create "refs"),
> is_git_directory() from _old_ git versions fails to recognize this is
> a good repository. So instead of dying on finding an unsupported
> repository, setup code keeps on looking for another repository in
> parent directories. If I accidentally run "git add something" with an
> old binary, "something" could be added to a wrong repository. Very
> confusing.

I went ahead and changed this.  Doing so seems to cause old versions of
git to recognize this as a git repo with an unknown version, which is
what we want.  Thanks.
