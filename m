From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: macblame - al alterntive to 'git blame'
Date: Tue, 24 Mar 2015 15:18:11 +0700
Message-ID: <CACsJy8ARVhgCOcM=XbELV-x_cNa8iGqMX6O2ouUp8UPq7xzcXw@mail.gmail.com>
References: <CAFKdeLPb4HPJ4a5tvYXa2GEr-WK-Wra56m2vrU7-LheNDWp7iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Shenbaga Prasanna S <prasanna.s@freshdesk.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 09:18:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaK2z-0007ZG-J0
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 09:18:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbbCXISp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 04:18:45 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:38833 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbbCXISm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 04:18:42 -0400
Received: by igbqf9 with SMTP id qf9so60185876igb.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 01:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=niJ7tfV7cpjLJUOBgSmySZ/6GLp4O7RvZeOQ/c425M0=;
        b=V/OtSLfRetSRE/rwk3kf1ulUtl3q6inqth6Bu5RqYb2TUpJZ366LW0mGR38XJO8syd
         uYorBCtaeu4GSBCwW/90qlmrsBMG+9hWTnUjahLP+VaIw2o1KKLICO6xfG5uOv6thA/a
         f0zwXcNo3QWOIgIF09Y/MoZpYDt53vNc0OLABu8G6CSJhZFylRPIX4PliJt2zjFX8703
         g/dZU+iW2ioQd2zKAfJMFzPTnPQnQ+/zZl7GE2/+vgxTNWGbiZ8XIWZMvsS5WN5zLfwx
         Q7qK5egZ5NYZWlvMj6XR0tcvqKy083EI6AVqU1cq0T1dPUx1PW0uBmeR+9Z1LN6KkTa1
         w05g==
X-Received: by 10.42.87.131 with SMTP id y3mr24411922icl.45.1427185121983;
 Tue, 24 Mar 2015 01:18:41 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Tue, 24 Mar 2015 01:18:11 -0700 (PDT)
In-Reply-To: <CAFKdeLPb4HPJ4a5tvYXa2GEr-WK-Wra56m2vrU7-LheNDWp7iA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266179>

On Tue, Mar 24, 2015 at 2:07 PM, Shenbaga Prasanna S
<prasanna.s@freshdesk.com> wrote:
> https://rubygems.org/gems/macblame/
>
> check this out.. and you can also contribute to the developement at,
>
> https://github.com/praserocking/macblame-gem
> or
> https://github.com/praserocking/macblame
> ..
> hope this tool will be helpful to you all!

It would help if you pasted a sample output to see what it looks like.
Although macblame script says "macblame shows stats about the files
tracked by git. It uses the output of 'git blame' and summarize it in
a cleaner and intuitive format" so it's not really an alternative to
git-blame (you can't "blame" anybody by line with this). This is more
like "git blame --stat" (if that option existed)
-- 
Duy
