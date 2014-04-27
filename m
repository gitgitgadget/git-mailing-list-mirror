From: James Denholm <nod.helm@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 07:40:27 +1000
Message-ID: <53a594dd-cd3d-4b33-ada8-3d7e08b86ee2@email.android.com>
References: <535C47BF.2070805@game-point.net> <1748955386.11457068.1398588660139.JavaMail.zimbra@dewire.com> <535D3DF8.4020904@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Jeremy Morton <admin@game-point.net>
X-From: git-owner@vger.kernel.org Sun Apr 27 23:40:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeWoS-0007ve-7M
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 23:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbaD0Vkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 17:40:36 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:63326 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbaD0Vkf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2014 17:40:35 -0400
Received: by mail-pa0-f47.google.com with SMTP id lj1so5054965pab.20
        for <git@vger.kernel.org>; Sun, 27 Apr 2014 14:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=Izc8m02JnWOR7i/hpN4WoZ5j7xE/npDP1u910CReuio=;
        b=FAwfbxHUhLZa2oSBJwI1zPV2e1R8BvksvQk4f4WhiurMrBKBY6YyssD2UZaXlqP3p3
         ELnO7OxCjkwku+OhpV07vtX5ap7PRn0zDH+Xt9giqHWZ9LNWtWpg89DqAHyNY+Bxh3BM
         stR2Srh6ATQuNPF4GpDnS7Q25TuD3M/Ih2l52wOpSrGuWO739B1wAdONFYWOYSL+r28f
         oYgZkXZIpA2CsRd4nE0VRGiJ7ljtGNLSCY7cQc2GAcbKGmF8UWnhCA9LMfV4c+i/eQcM
         QceZvXkZBmPJLcgHbziO2KNmti9eW15timQqhb7GUjxjsTH6ghZf2LWoucySq9Z6JENc
         /osQ==
X-Received: by 10.66.119.172 with SMTP id kv12mr21544261pab.34.1398634834595;
        Sun, 27 Apr 2014 14:40:34 -0700 (PDT)
Received: from [10.86.148.158] ([101.119.28.164])
        by mx.google.com with ESMTPSA id vf7sm30385824pbc.5.2014.04.27.14.40.32
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Apr 2014 14:40:34 -0700 (PDT)
User-Agent: Kaiten Mail
In-Reply-To: <535D3DF8.4020904@game-point.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247228>

I'm skipping a lot of the discussion here, sorry about that, but
on one particular note:

Jeremy Morton <admin@game-point.net> wrote:
> (...) and besides it takes up space that could be 
>used for a commit message.  As short commit messages are valued in Git,
>it's particularly bad to waste space this way.

Not really. While different groups will have different values, the
"greater git community" seems to prefer short _first lines_,
of fifty chars or less, while the _body_ should be as verbose as
it needs to be (but not more than). Ergo, while the first
line shouldn't contain a swath of metadata, the body can
easily.

A particularly good example of this is almost every commit to
the git project itself - there are"Signed-of-by" lines and such
everywhere in the logs.

>Also, you don't always have something you can link a commit to in an 
>issue tracker.  You may just be implementing a feature that has been 
>agreed upon, independently of any such tracker.  In that case, there's 
>no bug# to link to.

In which case, refer to whatever system you use. If you aren't
using a ticketing system, have the line "Relates-to: Water
cooler conversation with Bob on July 28th" or whatever the
patches relate to.

(Arguably, though, the better solution is to use a ticketing
system, or anything that allows discussion to be easily
referenced.)

Regards,
James Denholm.
