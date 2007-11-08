From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: Inconsistencies with git log
Date: Thu, 8 Nov 2007 11:14:17 +1100
Message-ID: <ee77f5c20711071614g7f0b9f84oc419590a586e16b7@mail.gmail.com>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com>
	 <Pine.LNX.4.64.0711072242230.4362@racer.site>
	 <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com>
	 <Pine.LNX.4.64.0711072255420.4362@racer.site>
	 <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com>
	 <243E1E6E-4723-42D3-933C-D2A0D1ACE287@silverinsanity.com>
	 <ee77f5c20711071531q5acc4d06u264f5daad7c04cc4@mail.gmail.com>
	 <Pine.LNX.4.64.0711080009270.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Brian Gernhardt" <benji@silverinsanity.com>,
	"Jon Smirl" <jonsmirl@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 01:14:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipv2Z-0004ah-E1
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 01:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758929AbXKHAOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 19:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758686AbXKHAOU
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 19:14:20 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:42389 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757769AbXKHAOT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 19:14:19 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2207109rvb
        for <git@vger.kernel.org>; Wed, 07 Nov 2007 16:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=BdMZDnWn8YsQL4rZo8P3KvmWTfF3C7vYiqT80ghne3E=;
        b=Nsl1TZ42LTCLnAZ5Iu49zXhp4lan2+zVHgANuT0RGRPaBRyIQs+HrUF1s6zxbZpao6BJn+SubKoSEUF4Pj7t4I0FflbfFE1VC5h4Vcmho7xxB3aAm3tRidT4/P9C+KA+bGgkK328Bh8FAUZX28AEhvkXwJXHSkHUBNeOdQ1np6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uDZUMy0Eaj95zEbiJKMAraCXN/xmZl9aUVYILebFel72yaZ6uWLAupI75lMUQ/gST+hI7uvqyZ08rJ7mG5hpvm36YPZIQHjMb31as/q5ke7d+MH+oQYd2bu+3StKmfqNgrj/t25BMzjP6VgZNxFq8yNiXn8SsEM7gioa5D8xEIM=
Received: by 10.140.225.19 with SMTP id x19mr3925118rvg.1194480857654;
        Wed, 07 Nov 2007 16:14:17 -0800 (PST)
Received: by 10.141.115.4 with HTTP; Wed, 7 Nov 2007 16:14:17 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711080009270.4362@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63906>

On Nov 8, 2007 11:09 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>
> On Thu, 8 Nov 2007, David Symonds wrote:
>
> > On Nov 8, 2007 10:19 AM, Brian Gernhardt <benji@silverinsanity.com> wrote:
> > >
> > > However, Dave's suggestion of altering git-status output to be
> > > relative to (but not limited by) CWD has merit.  Too bad I don't have
> > > time to work on it right now.
> >
> > I am happy to hack on this if there's not widespread revolt against the
> > concept.
>
> Too late ;-)

I see that you're revolting against relative paths in git-log; I agree
with you on that. I'm proposing changing the output to git-status so
that it produces relative paths, which are suitable for
git-add/git-rm/git-diff/...


Dave.
