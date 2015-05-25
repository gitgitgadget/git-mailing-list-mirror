From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule documentation: Reorder introductory paragraphs
Date: Mon, 25 May 2015 15:00:42 -0700
Message-ID: <xmqqfv6k9v1x.fsf@gitster.dls.corp.google.com>
References: <1432323527-26868-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: philipoakley@iee.org, jrnieder@gmail.com, git@vger.kernel.org,
	hvoigt@hvoigt.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 26 00:00:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yx0QT-0000Z0-7S
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 00:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbbEYWAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 18:00:45 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:36728 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbbEYWAo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 18:00:44 -0400
Received: by igbpi8 with SMTP id pi8so44258611igb.1
        for <git@vger.kernel.org>; Mon, 25 May 2015 15:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=rhMx1PqdseQUsr6DqDJA/vnCqqeAvCMQhdCyGhx7+xg=;
        b=Qzqw3HyQtYqdcqHIkxX073oeYIFv9kicgbkIqZ1HXyhhDr/oMbboH6pwYYLLbedr0j
         B3yHtxjIyLse2/OjbKq796S+NAo9NeVyU6fq0RDfopdY9JWZiwSVaZ4t14HWTL3CJ5YK
         TDYG4llcpSkHWswByvVRwo5k+h1wlcx0Z6MtXlbw1anBXDHQO/Bh0Xcctu5VDTp1oKpV
         el2I2mrBN1rCQ0aB8hdlMtLgY8tw7SXHEDGdNk/mYZVF9oWohZzBoFIwDsS7MUyiWZpK
         ac8jz4pw9G3i4l0UyzhrCfR109zGPQJdpW9ZJC9yaqZSrDo9IeA+dsjxTjC+4qRIWsWk
         YdEA==
X-Received: by 10.107.133.154 with SMTP id p26mr30755833ioi.7.1432591243876;
        Mon, 25 May 2015 15:00:43 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f93e:abc0:fe54:4a5a])
        by mx.google.com with ESMTPSA id g12sm9602103ioe.28.2015.05.25.15.00.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 May 2015 15:00:43 -0700 (PDT)
In-Reply-To: <1432323527-26868-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 22 May 2015 12:38:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269913>

Stefan Beller <sbeller@google.com> writes:

>  DESCRIPTION
>  -----------
> +This command will inspect, update and manage submodules.
>  
> +Submodules allow you to keep another Git repository in a subdirectory
> +of your repository. The other repository has its own history,...

The first line somehow bothered me, so I took a random sample of
commands I often use:

    git log
       Shows the commit logs.

    git show
       Shows one or more objects (blobs, trees, tags and commits).

    git commit
       Stores the current contents of the index in a new commit along with a
       log message from the user describing the changes.

    git diff
       Show changes between the working tree and the index or a tree, changes
       between the index and a tree, changes between two trees, changes
       between two blob objects, or changes between two files on disk.

    git push
       Updates remote refs using local refs, while sending objects necessary
       to complete the given refs.

I _think_ what bothered me was "This command" (drawing the reaction
"eh, what other command are you going to talk about in the help page
for this command?").  Perhaps

    Inspects, updates and manages submodules.

may match the style of other help pages better.

On the other hand, I probably would not have felt such a strong
"strangeness" if it were described like this:

    This command can help you inspect, update, and manage
    submodules.

I haven't analized it enough to say why it is, but I suspect it has
something to do with (my own) perception that "git submodule" is not
very essential to do any of these things (i.e. .gitmodules is a very
simple text file), but is primarily a helpful wrapper.

The description of "git config", on which I have a similar
perception, seem to match ;-)

    git config
       You can query/set/replace/unset options with this command.
