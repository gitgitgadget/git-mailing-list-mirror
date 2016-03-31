From: Zachary Turner <zturner@google.com>
Subject: Re: Problem with Integrated Vim Editor on Win 10
Date: Thu, 31 Mar 2016 10:20:28 -0700
Message-ID: <CAAErz9jeLPU+QocSKNssknoJdZoi4Sq0YfZiNnpf4wD70JKQUQ@mail.gmail.com>
References: <CAAErz9i1=EOemq2qNijRwgY6MNmPJRhV+mFfeD1FZa5uPwvCJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 31 19:20:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1algGt-000797-2k
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 19:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756882AbcCaRUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 13:20:30 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:34858 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118AbcCaRU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 13:20:29 -0400
Received: by mail-yw0-f173.google.com with SMTP id g127so105910580ywf.2
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 10:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to;
        bh=YzgIw7duGmSFK2bzp2vuC2wad4z8WbiTvvVTK2/7n/Q=;
        b=F81bY8qGdgRJ+Pnc6GCcuQzUJUHjsl9e9KoFvsvaDKkJptAfqilkHtPRlZVhjC0E8J
         UXtCkEbQCJj6V9YVB7Fl/4ePxgDjqKQGaLVoCaYmSbZMUcCn0YyW0T88hjQk7NzBMv9r
         8a5+dV0clChz6YfF3pdvBLMFktdMc1QjaLvSSCzAcAgJt1J88FklkY3o2EfmECdRJ9WF
         0HUwiiUOMWDZUu/+4VQF5Id1Jp7+gMAr3bcFsVCu+y9JkpQ9FvM05YPdLsWks+kej7Tn
         zYH+eUyMJsozmDrtsC6d1nm/0bBui0jcuuVgk62kb+FLLSPkVnMpUoI987pQzhDCmhxX
         Jv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to;
        bh=YzgIw7duGmSFK2bzp2vuC2wad4z8WbiTvvVTK2/7n/Q=;
        b=JEZ1+nwEHRWifI9SIF0CX2wfrNF4BB0xNveoc+o9+mlw6gX0gvVmqGhYYx3TNC+9Hh
         VyoS4UJ39g++GHJK4TmFBDoohuIOeH798/52n05ViPs0IGWbtjqjTMswJc3Mij8XTDo3
         6644xYNsosEe+mlS9ARK62Tn+rmrX5GWR1RnM7EAFYi/8ae6Fp650/gRV5kM6osmC2WC
         Ewc7k2tHyXv0ZepvN637AaMeDStzsHt0/PHkwUYvTSmW7QANELFNkKmPCN6TKbPY6ouS
         KcXajJXkCmpK25WceQ1MJyVvRK9fR3wAyoHSBsANY3xBQY58GTEW9vMuhmIPGJWk32Dk
         eV4w==
X-Gm-Message-State: AD7BkJJsB4BiszqUgndDQu7pQQVarl94e1/AOO7OccvnnGKa+2hDYTOqiJ4OX+JW/O6BTycfxhgES42+b9Jf5dTV
X-Received: by 10.129.42.69 with SMTP id q66mr8154724ywq.26.1459444828525;
 Thu, 31 Mar 2016 10:20:28 -0700 (PDT)
Received: by 10.37.113.133 with HTTP; Thu, 31 Mar 2016 10:20:28 -0700 (PDT)
In-Reply-To: <CAAErz9i1=EOemq2qNijRwgY6MNmPJRhV+mFfeD1FZa5uPwvCJw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290425>

I dug into this some more, and as surprising as it is, I believe the
release of Git 2.8.0 is just busted.  I had an installer for 2.7.0
lying around, so after uninstalling 2.8.0 and re-installing 2.7.0,
everything works fine.

I'm not terribly active in the Git community so I don't know what the
procedure is for things like this, but this seems like a fairly
serious regression.  Suggestions on how to proceed?

On Wed, Mar 30, 2016 at 5:07 PM, Zachary Turner <zturner@google.com> wrote:
> Hi, just recently I installed the latest build of Windows 10 of my
> machine. This is my second Win10 machine. On the other I am using git
> 2.7.0.windows.1 and everything is working just fine.
>
> On the second machine I am using git 2.8.0.windows.1 and vim does not
> work. I sent a bug report to bugs@vim.org, but frankly I don't know whose
> bug this is, so I'm including it here as well.
>
> The problem is that vim is just a black screen when git launches it. If I
> mash enough keys eventually I see something that resembles vim output at
> the bottom, but I can't actually use it.
>
> I tried going into program files\git\usr\bin and just running vim.exe.
> Again, black screen. If I press enter about 10 times I can see the
> introduction screen. Then if I press : about 10-20 times it will go into
> command mode and a single : appears. after pressing a few more keys all
> the rest of the :s appear. Basically, everything is completely unusable.
>
> I tried downloading vim 7.4 from www.vim.org, and low and behold, it
> works. For now I've replaced the copy of vim.exe that ships with git with
> the copy from www.vim.org. But this leaves me nervous that something is
> seriously wrong.
>
> Has anyone seen anything like this before, or have any ideas how I might
> better diagnose this?
