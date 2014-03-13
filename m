From: Yuxuan Shui <yshuiv7@gmail.com>
Subject: Re: GSoC proposal: port pack bitmap support to libgit2.
Date: Fri, 14 Mar 2014 01:20:58 +0800
Message-ID: <CAGqt0zy=av=V--REMz2Q1VRZW9mU5Ng=NN=TAAZiUbzskUZbgQ@mail.gmail.com>
References: <CAGqt0zz1W1k92B+XRWEmMEv1=iyej+zi9QUCp2EhA=g+VnCt0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 13 18:21:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WO9Ja-0007Gx-2k
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 18:21:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608AbaCMRVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 13:21:00 -0400
Received: from mail-vc0-f177.google.com ([209.85.220.177]:33953 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754499AbaCMRU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 13:20:59 -0400
Received: by mail-vc0-f177.google.com with SMTP id if17so1436280vcb.22
        for <git@vger.kernel.org>; Thu, 13 Mar 2014 10:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=v2z4bigSzpnSCWTU9u6wNUAZsqjZQ2xAaZbmViQIxBg=;
        b=TcbIOxU+LOZpCcev4eAGF2KvwPScfcokbM9S+Rpeu9T1rbYTFKFHo+HQYVhSTn66Qw
         yPWXduuzEEfqKXCEMOjJQBlk92d9I7vEZ8OIqTeUOcv7+PurUZVj8S6E5Sdtigk6soEB
         t/G++Yg/KFEtuImFjcF8pkvSNdFDsI5XIkK9Kj8PGH/oq4u3gZIJYWE1rC4V7W7dq6lb
         NPFR0Js7vouhVfcS71vA+0V+LrBQFwefcVvM40z2fAKjN6ZD+Ukosl2w2YMVGUOxGQu1
         q6+0A2ekrNiNMjrYjOqEl1WkmxnzMsglPzKpIEY5ImtHRwahRjXVsScpxAes+xXrhiRW
         eaFQ==
X-Received: by 10.52.7.69 with SMTP id h5mr27537vda.68.1394731258970; Thu, 13
 Mar 2014 10:20:58 -0700 (PDT)
Received: by 10.220.89.209 with HTTP; Thu, 13 Mar 2014 10:20:58 -0700 (PDT)
In-Reply-To: <CAGqt0zz1W1k92B+XRWEmMEv1=iyej+zi9QUCp2EhA=g+VnCt0g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244037>

Hi,

On Wed, Mar 12, 2014 at 4:19 PM, Yuxuan Shui <yshuiv7@gmail.com> wrote:
> Hi,
>
> I'm Yuxuan Shui, a undergraduate student from China. I'm applying for
> GSoC 2014, and here is my proposal:
>
> I found this idea on the ideas page, and did some research about it.
> The pack bitmap patchset add a new .bitmap file for every pack file
> which contains the reachability information of selected commits. This
> information is used to speed up git fetching and cloning, and produce
> a very convincing results.
>
> The goal of my project is to port the pack bitmap implementation in
> core git to libgit2, so users of libgit2 could benefit from this
> optimization as well.
>
> Please let me know if my proposal makes sense, thanks.
>
> P.S. I've submitted by microproject patch[1], but haven't received any
> response yet.
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/243854
>
> --
> Regards
> Yuxuan Shui

Could anyone please review my proposal a little bit? Is this project
helpful and worth doing? Did I get anything wrong in my proposal?

Thanks.

-- 

Regards
Yuxuan Shui
