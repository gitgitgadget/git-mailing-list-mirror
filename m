From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git commit -a -m is not working
Date: Mon, 28 Sep 2015 10:11:32 -0700
Message-ID: <20150928171132.GA11993@google.com>
References: <CAMWrOy7YoAofbzfW+dy=v1TRgWGe5OuZ8U2x+Q-XCKc1y_agRA@mail.gmail.com>
 <20150926185416.GA233088@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Alex Radulescu <mydesweb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 19:12:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgbyJ-0000Yf-KT
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 19:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934314AbbI1RML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 13:12:11 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33969 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933063AbbI1RMK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 13:12:10 -0400
Received: by padhy16 with SMTP id hy16so179562290pad.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 10:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=000iR+oI4894xVZm0QtWFIykYpIe8M22/xC4YmzsSTk=;
        b=ZVBbynPU6lO8wVyv2yRUKj1B9IB8l/vHYORQMJ0bKLQgghuWV4SXhZuQaVOUCYb7sb
         1IGpkbMvXMOvVn1PJZCRq6DBohMgr/CefcQr0UWaKLiexHWDwJHZd2dK7ovonHB3v+HT
         O4JGUmrs54w4WaCoZoBCCRCMy5/0aQVYOjvXaDCgUpWRtSGI2BAmAHuHOB+P2IpHaUT9
         +DhGhrrQ/xzHTl42tT4xWa6J81RbX+hivlAWZy1tBXUnU+hHG113rdAtqJXN+x6UAU7e
         OLNPDZ5JuaS8/2eXrFX3KBpnYJuRjc7qVbYVChZxsQOrDTRwuMhm/KqOEDe2rjaT/m5B
         EXUA==
X-Received: by 10.68.245.164 with SMTP id xp4mr27534471pbc.100.1443460329517;
        Mon, 28 Sep 2015 10:12:09 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:50a5:21f5:8b0:5057])
        by smtp.gmail.com with ESMTPSA id qy5sm20469829pbb.16.2015.09.28.10.12.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Sep 2015 10:12:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150926185416.GA233088@vauxhall.crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278730>

Hi,

brian m. carlson wrote:
> On Sat, Sep 26, 2015 at 09:51:12PM +0300, Alex Radulescu wrote:

>> Alex:testGit Alex$ git commit -a -m 'made a change'
>>
>> On branch v1.0
>>
>> Untracked files:
>>
>> new_branch.txt
>>
>> nothing added to commit but untracked files present
>
> git commit -a does not add untracked files.  Such files might be build
> by-products or such and you haven't told Git to track them, so it
> doesn't.

You can run "git add -N <files>" to tell Git to start caring about
some new files (e.g., "git add -N ." to track them all).

Alternatively, you can run "git add <files>" to tell Git that the
current content of those files is ready for commit (e.g., "git add ."
before "git status" and "git commit" to commit everything).

More details are at http://jk.gs/gittutorial.html#_making_changes
(also available by running "git help tutorial").

Thanks and hope that helps,
Jonathan
