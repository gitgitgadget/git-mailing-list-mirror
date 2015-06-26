From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: git submodule init --recursive?
Date: Thu, 25 Jun 2015 20:08:13 -0500
Message-ID: <CAHd499DN8cL0NiMkJv4==_1u+FfAi78HCw-C=4Xe+SV3-aZmng@mail.gmail.com>
References: <CAHd499BbW=yAR_4WFiuq7TvFvYKN84FkQSjGL6AqCoYffOg2LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 26 03:08:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8I7t-00056g-N0
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 03:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbbFZBIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 21:08:15 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:37694 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbbFZBIN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 21:08:13 -0400
Received: by igblr2 with SMTP id lr2so3949040igb.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 18:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type;
        bh=eLnpNQQflGjjCjJtCFaJV4PESCeFLCtvln3cIyOPiVk=;
        b=F7EJ9E/gOV8o/SAmzwviMbMQAPXpxusAk5gkGA+1S54JhDK8t7RurjXgY53hicd4sw
         2n6aHOFXnEycv8lYlx+KSqFAe+MNjtFRr9DIrePTFYAmtgglJlVZLtSRHPVz5HbZec2r
         WG2fXP0KaVF+YvEyj3kGXniV4a7oF42vu80ekkJLThIPGqELnKWwXWLHvzW7q6ZNfkWc
         6xgC39tlGh50WQGx1CnleDUrPnsQmsFXUJ0G4nTFTGaHPtFKNz6LacCDeB7GKpvXRqBR
         TjMLwt0g/Zm2RCC8FO2il5neerXkgelxbXLxLMK8Izjuhd/c2Pp4xN5a7NJbv2s5DIz0
         hJfw==
X-Received: by 10.42.205.132 with SMTP id fq4mr408951icb.33.1435280893059;
 Thu, 25 Jun 2015 18:08:13 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.86.148 with HTTP; Thu, 25 Jun 2015 18:08:13 -0700 (PDT)
In-Reply-To: <CAHd499BbW=yAR_4WFiuq7TvFvYKN84FkQSjGL6AqCoYffOg2LQ@mail.gmail.com>
X-Google-Sender-Auth: hHOw1F1jslHRqEjzva5lHtupPT0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272756>

On Thu, Jun 25, 2015 at 8:04 PM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> I have a few nested submodules, all use relative URLs such as:
>
> ../mysubmodule.git
> ../../tools/tool1.git
>
> If I change my parent repo URL, I need to recursively update all
> remotes in each submodule. There is no `--recursive` option for `git
> submodule init`. What is the recommend method for accomplishing this?
>
> Thanks in advance.

Never mind please, I'm a moron. I'm supposed to use sync for this task.

Been a long day and haven't had enough beer yet.
