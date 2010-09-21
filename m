From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: staging specific lines out of a hunk for a commit
Date: Tue, 21 Sep 2010 12:09:09 +0100
Message-ID: <AANLkTimOPSbG=VqqReMqbQicYygxbHQsniwS5WDvA1z4@mail.gmail.com>
References: <AANLkTin4U78N_8LV8fCWuinNH9AFeOsRBjnvHM0qt2ZH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Graeme Geldenhuys <graemeg.lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 14:02:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy1Yi-0007lX-DL
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 14:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229Ab0IUMCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 08:02:47 -0400
Received: from juliet.asmallorange.com ([207.210.105.70]:53903 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972Ab0IUMCr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 08:02:47 -0400
X-Greylist: delayed 3192 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Sep 2010 08:02:47 EDT
Received: from mail-qy0-f181.google.com ([209.85.216.181]:59265)
	by juliet.asmallorange.com with esmtpsa (TLSv1:RC4-MD5:128)
	(Exim 4.69)
	(envelope-from <maillist@steelskies.com>)
	id 1Oy0j5-0001a4-Pk
	for git@vger.kernel.org; Tue, 21 Sep 2010 07:09:32 -0400
Received: by qyk33 with SMTP id 33so5317016qyk.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 04:09:29 -0700 (PDT)
Received: by 10.224.115.17 with SMTP id g17mr6746087qaq.245.1285067369226;
 Tue, 21 Sep 2010 04:09:29 -0700 (PDT)
Received: by 10.229.50.144 with HTTP; Tue, 21 Sep 2010 04:09:09 -0700 (PDT)
In-Reply-To: <AANLkTin4U78N_8LV8fCWuinNH9AFeOsRBjnvHM0qt2ZH@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - juliet.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156716>

On 21 September 2010 11:40, Graeme Geldenhuys <graemeg.lists@gmail.com> wrote:
> Hi,
>
> I know 'git gui' has this cool feature where you can stage one line at
> a time. This is really handy, but also very annoying, if you have a
> large piece of code you want to commit.
>
> eg: I have a single hunk, which can't be split into smaller hunks
> because it is all new code. But that hunk fixes a few bugs, or
> introduces a few new features.
>
> Is there a way to use 'git add -i' or 'git add -p' or 'git gui' and
> tell it to add for example lines 5-20 of the hunk to the index?
> Currently with 'git gui', I have to right click and select 'Stage line
> for commit' 15+ times! :-(
>

If you happen to be on a Mac, gitx allows you to select the lines
you're interested in with the mouse and stage them.
