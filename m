From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: fatal: Unable to read current working directory: No error
Date: Tue, 17 Nov 2015 12:52:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1511171251120.1686@s15462909.onlinehome-server.info>
References: <CAPkB0GxPghR9Y7YrB9yYq3rA9XZ2HJGN-sxbQgERGsBA2iOX_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sean Krauth <spkrauth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 12:53:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zyeos-0004ZA-Mt
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 12:53:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514AbbKQLxB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 06:53:01 -0500
Received: from mout.gmx.net ([212.227.17.21]:52013 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751978AbbKQLxA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 06:53:00 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0MdFwl-1ZgIsz0FCV-00IVcb;
 Tue, 17 Nov 2015 12:52:58 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CAPkB0GxPghR9Y7YrB9yYq3rA9XZ2HJGN-sxbQgERGsBA2iOX_Q@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:aWD5CHPlNd0Y0b4MAOg5uNAGoYuWKZAuy8Lay6RGCAzRIUTEZZj
 hS574FIw+FMcOKOt9d+ihyq2K36cr4BaCRcDrVBoZEkXhm+NS84iWrt5Z37LJrK5EDEpF+S
 jj1XMGt+fTOVwIvJtX156lrCaCc+td5tg5fL24sp33ZtE8dU2DeYM9IgBGB1ck6wKY9PqYq
 mgIj9r8WCm4H8OUBv7wfQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1edXslPox6c=:hjSmmgnQCgJeSUisTkt3Xz
 QLKK2bmXv4q5RLnPILSfXRm01tcQ/UNX5nT2QQKY6LkTqGYR7ptkdBcsK41VLXjJz6qzOJlq3
 PxyhJz5lMfLLgNrV6AnrLA4wlQ2O1dekkAyf7CskiNN/SEK7Z3d1QXvZJLi9Z7Au4ZSbPGueb
 NtlK+zMZSm48fHtJUc1xhPR26elGnpyC2CMjET35SP67AIT6/3m3n9UGNKXOf8xLhYU38ibdO
 rfuzJNm+Uhk6YPXQyyQJxFgFywxF5kOUApTVEytWfp3dHhlTEFEuz9JE4L9sbUh8pWpO5ZD8c
 ujfknf24QAlDHFxYOo8SiiBm/nfILMCpYFb5rnQ4XTgf+udKnzzDAlmWzT+ktdUjmJHaN2r0q
 ztRzt3szmDSu1YLVD9NCbvggdFgz0J6FhkhH4xefrbeu50PORO3i/4IO0lUfO+Y0DRRWrtEUd
 5hIclzNU6JbRtoz0qkRPGxWDvDnz7JzYwZmrQg6f1gBZKr1PbEp94blFOZENdGUU8AdNi0boG
 rawacUDfC2fu986XeXvsHwI7jbrG0iiu9AMiFEG2c7f8WTVge+i4SGq3aoV9nk1GnKtJWyTkv
 q1DdfFurGhhOcEKmVXyH07/cEUBw4SjBS6n2C5r4ysMxtJT+xZnh0i9XrSr64TrpgkZyuI8gW
 ueD2TUkCJkzmnZlEZmZd5u5H2am9GhyFKxCnjwqEB5TNiEaWyLz0vf6bVpOUrxVqejV1qEbIY
 6o/6pOfYJ5JaSccyPNbnLn+D4AFQF0N5q19GqtlZmoYd9T75svCIloKZqZaEJaL8wka4JPgH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281403>

Hi Sean,

On Tue, 27 Oct 2015, Sean Krauth wrote:

> I've encountered a problem and I haven't had any success with my own
> troubleshooting or googling so I'd appreciate some help. I noticed the
> issue originally when I changed a file name in windows explorer. I was
> working on a website and I named my Public folder with a capital P and
> wrote my file routes as public. So being a little lazy I decided to
> open windows explorer and rename Public to public. This was after I
> had used Git Bash to create a local repository. I'm almost positive
> this action broke Git. The next time I tried to run Git Bash I got an
> error that I believe said something similar to "fatal build error" or
> "fatal load error" and Git was really broke.

If you could boil this down to a [Minimal, Complete & Verifiable
Example](http://stackoverflow.com/help/mcve), I will have a look.

Ciao,
Johannes
