From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH/POLL] git-format-patch: the default suffix is now .patch, not .txt
Date: Thu, 18 Jan 2007 17:05:52 +0100
Message-ID: <81b0412b0701180805r276fcfaq2c1582ab8e82515b@mail.gmail.com>
References: <87ps9d7j6t.fsf@morpheus.local>
	 <625fc13d0701171218i31585558wf89374eae9485341@mail.gmail.com>
	 <7vsle9p8pg.fsf@assigned-by-dhcp.cox.net>
	 <7vd55dp5a3.fsf_-_@assigned-by-dhcp.cox.net>
	 <81b0412b0701172359y1ef4f936pcdcb2de53d6bd468@mail.gmail.com>
	 <7v64b4ohcj.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0701180135r505a75a5j172c70792d6569c0@mail.gmail.com>
	 <625fc13d0701180352m151cceb3lf9c00b6cf0ae937b@mail.gmail.com>
	 <81b0412b0701180540x15d20453s3dbc0c061fd06d50@mail.gmail.com>
	 <20070118154257.GC15428@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Josh Boyer" <jwboyer@gmail.com>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	davidk@lysator.liu.se
X-From: git-owner@vger.kernel.org Thu Jan 18 17:06:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Zm1-0004Q6-GQ
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 17:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbXARQFz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 11:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752049AbXARQFz
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 11:05:55 -0500
Received: from wr-out-0506.google.com ([64.233.184.226]:26042 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbXARQFy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 11:05:54 -0500
Received: by wr-out-0506.google.com with SMTP id i22so199579wra
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 08:05:53 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mj8PxT94GHzXoZD7u5uzj6+foO63tyVNtyFSnmzYnoy18ijow7CFOqf8pXHljsMOARbEanijRdGh4St8rwlbzeazL2QcSmxt8uK4wTx+DAICef7+ALrr0UgTaEB2QAC96iqsiNYk39Kaj8fV7gQhlLCxGgW5/uuisRYVO0B7LvI=
Received: by 10.78.160.2 with SMTP id i2mr1012441hue.1169136352705;
        Thu, 18 Jan 2007 08:05:52 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Thu, 18 Jan 2007 08:05:52 -0800 (PST)
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070118154257.GC15428@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37116>

On 1/18/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > The _real_ majority of the programmers desperately need a better
> > VCS than CVS, SVN, Perforce, SourceSafe, ClearCase, etc.
>
> Yes.  But...
>
> Yesterday I had a conversation with the software configuration
> management guy at my day-time-pays-the-bills organization.
> They are seriously looking at Perforce and ClearCase, as these are
> lightyears ahead of what we have already (PVCS Version Manager).
> They also have 1-800-my-vendor telephone numbers which you can
> call and scream at someone when the tool corrupts its internal
> database[*1*], or when you cannot figure out what the "Checkout"
> action in the context menu does[*2*].
>
> However my fellow developers and I use Git.  We export our changes
> out to PVCS Version Manager via an *ugly* Perl script that I would
> never actually wish on anyone (which is one reason why its not
> contributed as git-pvcsexport).  Configuration management guy won't
> even look at Git's real strengths as it lacks the all-important
> 1-800-git-help[*3*] phone number.

Of course, he is the who'll do the yelling. It's you who'll need support.
Standard Perforce replies: "it is not supported" (if you need branches
as in Git), or "we will probably look into it" (if you point them to a bug.
They never really do). Worst performance in the industry, too.

ClearCase had a sleep(6 /*sec*/) before writing a file in local checkouts
on linux, for whatever reason :) It at least knows about oriented graphs.
