From: Johan Herland <johan@herland.net>
Subject: Re: A better git log --graph?
Date: Wed, 7 Jan 2015 16:47:13 +0100
Message-ID: <CALKQrgdrS0RkKe-5UN_HabkLYsZ+GGL=3SNqb_ij3W5z1R6ZTg@mail.gmail.com>
References: <m8jfg5$dsp$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: "Yuri D'Elia" <wavexx@thregr.org>
X-From: git-owner@vger.kernel.org Wed Jan 07 16:48:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8spU-0002Ss-16
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 16:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566AbbAGPrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 10:47:24 -0500
Received: from mail13.copyleft.no ([91.220.196.227]:39680 "EHLO
	mail13.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbbAGPrX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 10:47:23 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail13.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1Y8spM-0004ZD-Io
	for git@vger.kernel.org; Wed, 07 Jan 2015 16:47:20 +0100
Received: from mail-pa0-f51.google.com ([209.85.220.51])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Y8spM-000Pkf-AZ
	for git@vger.kernel.org; Wed, 07 Jan 2015 16:47:20 +0100
Received: by mail-pa0-f51.google.com with SMTP id ey11so5530290pad.10
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 07:47:13 -0800 (PST)
X-Received: by 10.68.57.174 with SMTP id j14mr6292984pbq.91.1420645633961;
 Wed, 07 Jan 2015 07:47:13 -0800 (PST)
Received: by 10.70.105.4 with HTTP; Wed, 7 Jan 2015 07:47:13 -0800 (PST)
In-Reply-To: <m8jfg5$dsp$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262133>

Have you looked at git show-branch --all?

...Johan

On Wed, Jan 7, 2015 at 3:23 PM, Yuri D'Elia <wavexx@thregr.org> wrote:
> Hi everyone,
>
> git log --graph is hard for me to parse mentally when developing a
> project which has a lot of branches.
>
> All the tools I've been using seem to just parse log --graph's output,
> and thus are no better at showing history.
>
> I would love to have a graph mode where each branch is assigned a
> column, and stays there. If my log section shows the history of 3
> branches, column 1 should always refer to master, 2 to the hypothetical
> "development" branch and 3 to "feature".
>
> Of course the mode will waste more horizontal space, but it would be
> immediately more apparent which branch is merging into which.
>
> I saw this idea proposed a couple of times in the mailing list, but I
> saw no "action" behind the proposal. Since I don't have time to work on
> it, has anyone already started some work that he would like to share as
> a starting point? Even just to have a felling if it's worth the effort.
>
> Does anybody know of another tool to graph the history using something
> that is not based on git log --graph?
>
> I've seen a couple of graphviz-based ones, but both failed to work out
> of the box for me.
>
> Thanks a lot for any pointer.
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Johan Herland, <johan@herland.net>
www.herland.net
