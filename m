From: "Alex Bennee" <kernel-hacker@bennee.com>
Subject: Re: [RFC PATCH] Implement vc-git-annotate-show-diff-revision-at-line for emacs vc-git
Date: Sat, 23 Feb 2008 09:09:24 +0000
Message-ID: <b2cdc9f30802230109x27af2b90qf27cd6f92dd767e@mail.gmail.com>
References: <1203706693.7552.56.camel@alexjb-desktop.transitives.com>
	 <87ejb4kaob.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alexandre Julliard" <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Sat Feb 23 10:10:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSqOV-0006wU-85
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 10:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755363AbYBWJJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 04:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755324AbYBWJJa
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 04:09:30 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:6673 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753508AbYBWJJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 04:09:27 -0500
Received: by py-out-1112.google.com with SMTP id u52so1231731pyb.10
        for <git@vger.kernel.org>; Sat, 23 Feb 2008 01:09:25 -0800 (PST)
Received: by 10.141.89.13 with SMTP id r13mr113934rvl.88.1203757764686;
        Sat, 23 Feb 2008 01:09:24 -0800 (PST)
Received: by 10.140.161.13 with HTTP; Sat, 23 Feb 2008 01:09:24 -0800 (PST)
In-Reply-To: <87ejb4kaob.fsf@wine.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: d788f923c5222812
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74807>

On 2/22/08, Alexandre Julliard <julliard@winehq.org> wrote:
> Alex Bennee <kernel-hacker@bennee.com> writes:
>
>  > I've had an initial stab at doing this for jumping to the commit in
>  > annotate mode.
<snip>
> vc-git is now maintained in the main Emacs repository, so that's the
>  version you should look at; it does have a vc-git-previous-version
>  implementation. The vc-git.el in the git repository is an older version
>  that is not being updated anymore.

Perhaps it would be worth mirroring the updates to vc-git.el in the
git repo for people that don't
run bleeding edge emacs but do track git development? Or does it need
changes that have been made to vc.el in the mainline?

--
Alex, homepage: http://www.bennee.com/~alex/
