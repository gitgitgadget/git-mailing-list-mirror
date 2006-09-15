From: "Rajkumar S" <rajkumars@gmail.com>
Subject: Re: Tracking a branch using StGIT
Date: Fri, 15 Sep 2006 17:29:38 +0530
Message-ID: <64de5c8b0609150459i2e678a02r86bb678ea420054f@mail.gmail.com>
References: <64de5c8b0609150120h3aeee6dcv976da13134396654@mail.gmail.com>
	 <b0943d9e0609150342y6105d8d1o61abb1934da9f51b@mail.gmail.com>
	 <64de5c8b0609150432o5d6835a8pb578082746576864@mail.gmail.com>
	 <eee3i5$ib6$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 15 14:00:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOCMO-0000Gv-NB
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 13:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWIOL7k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 07:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWIOL7k
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 07:59:40 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:30789 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751302AbWIOL7j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Sep 2006 07:59:39 -0400
Received: by nz-out-0102.google.com with SMTP id n1so1348373nzf
        for <git@vger.kernel.org>; Fri, 15 Sep 2006 04:59:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UvZWlBe3h6b0FX3aoWn31e5eiMpyIv1O7iR4BeUf73po4INxdP89m7u2jGFZEzzO58d7JzblDRY7/dloSDtCPKDZbjG/o6wQPyYSQzd260yq8Bv03Hic8xIcxLYOJv8vapzFbWevuGJ8usSL+lgapcio96my7+z1xtckNBFQ8E4=
Received: by 10.65.59.20 with SMTP id m20mr8810762qbk;
        Fri, 15 Sep 2006 04:59:38 -0700 (PDT)
Received: by 10.65.248.1 with HTTP; Fri, 15 Sep 2006 04:59:38 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <eee3i5$ib6$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27081>

On 9/15/06, Jakub Narebski <jnareb@gmail.com> wrote:

> git pull is git fetch + merge of first head in remotes file with _current_
> branch.

I was under the impression that git pull is git pull + merge of
corresponding branches in remotes files. ie master -> origin and
RELENG_1 -> RELENG_1. Is such a pull possible, for all lines in
remotes file?

In my case I am only interested in RELENG_1 branch, so would it be
fine if I just put the
"Pull: refs/heads/RELENG_1:refs/heads/RELENG_1" line in my remotes
file? Since I use StGIT I do not intend  to modify my local RELENG_1
branch except by StGIT patches, so all pulls from remote should be
fast forward merged. Thus if the stg pull can pull in the remote
RELENG_1 to local RELENG_1 with patched popped, and fastforward merge
it, it would be great.

raj
