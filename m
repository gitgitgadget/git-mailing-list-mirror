From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: push branch descriptions
Date: Wed, 14 Nov 2012 16:03:54 +0530
Message-ID: <CALkWK0meYVEe8OezEU2Oe-dQSZuo0ETwxXq3qWXzopH7x3msJA@mail.gmail.com>
References: <CAB9Jk9ABenaj=R0a6OW2GCsin8PdDCW3ZbuQbu6G0jnGG3s+sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 11:34:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYaIf-00019S-3W
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 11:34:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755113Ab2KNKeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 05:34:15 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:56422 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754819Ab2KNKeO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 05:34:14 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so235676obb.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 02:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ove/rzcY/3SOqV6YF5YfuFNh85F3P8rjcEuj3Dwb9gU=;
        b=XXUUeHidmltnNUfZkbIk0L3Rl+/Ee1jWXrmAxNk/LhHdNCWd1A8/3DX7Rnin9nkd6w
         kM8zB3j/0UaOFt5XH7XvHoItmwTJjpwbA0c9/VkRoJPIOYKBjlmcKL8s0kTeSbpVXTE3
         IxqyteDvwbqp9lphOVyM9m//uhqDKc9XjEgEdtvJXTKyHlMU2B64aZtDj6Eyj473x3yx
         WuQCexRlZjJgw54tMcokhtYNg6DL/13Z5h4O6Y745smyH0Y2mDqCMUeSvsE/9jgg7Yj+
         hOX/JzsvgO3zvFsN9ook7jjGvgnd1y1i4ZvJSkNoAfYs6qCI0VJrXi/HQGyxIq+wtaNI
         Wu8A==
Received: by 10.60.28.36 with SMTP id y4mr19549046oeg.13.1352889254150; Wed,
 14 Nov 2012 02:34:14 -0800 (PST)
Received: by 10.76.168.40 with HTTP; Wed, 14 Nov 2012 02:33:54 -0800 (PST)
In-Reply-To: <CAB9Jk9ABenaj=R0a6OW2GCsin8PdDCW3ZbuQbu6G0jnGG3s+sA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209709>

Hi,

Angelo Borsotti wrote:
> currently, there is no means to push a branch description to a remote
> repository. It is possible to create a branch, but not to set its
> description.
> Would not be more correct to push also branch descriptions when
> branches are pushed?

Branch descriptions are currently stored in .git/config (see
branch.<branchname>.description), and are hence intended to be local.
But yes, it would be nice to have it synced with the remote- I have no
clue how to make that possible though.

Ram
