From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] git-svn - bidirection operations between svn and git
Date: Thu, 16 Feb 2006 00:19:10 -0800
Message-ID: <7vr763emwx.fsf@assigned-by-dhcp.cox.net>
References: <20060216073826.GA12055@hand.yhbt.net>
	<7v4q2zg2an.fsf@assigned-by-dhcp.cox.net>
	<cc723f590602160008v5fcc0e35h6d9296bd0572fac2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 09:19:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9eMM-0000s2-Vw
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 09:19:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbWBPITO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 03:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWBPITO
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 03:19:14 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:58573 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932516AbWBPITM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 03:19:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060216081740.QGBH6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 16 Feb 2006 03:17:40 -0500
To: Aneesh Kumar <aneesh.kumar@gmail.com>
In-Reply-To: <cc723f590602160008v5fcc0e35h6d9296bd0572fac2@mail.gmail.com>
	(Aneesh Kumar's message of "Thu, 16 Feb 2006 13:38:56 +0530")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16282>

Aneesh Kumar <aneesh.kumar@gmail.com> writes:

> On 2/16/06, Junio C Hamano <junkio@cox.net> wrote:
>>
>> How about first adding a contrib/ directory and see how it goes?
>
> I am all for it. Attaching the latest gitview. This include branch and
> tag display support and also the  option to save diffs in file.

Now how do you want to proceed?  I could just dump the thing in
say contrib/gitview subdirectory, and then afterwards you could
either keep feeding me patches or sending me pull requests.

There are two downsides doing things that way:

 (1) you would lose the development history so far;

 (2) if gitview script is the only thing you care about, I
     suspect you would want to have that at the project
     toplevel, like the "coolest merge ever" gitk merge did, but
     that is not what you will be getting.

Ideally, if we had a proper "subproject" support, I would merge
your project with full development history so far as a
subproject, with your toplevel grafted at contrib/gitview
subdirectory.  That would not have neither of the above two
downsides.  But that hasn't happened yet (and that was one of
the reasons that I was reluctant initially -- I was hoping that
subproject stuff would materialize sooner).

For now, I'd do the easy approach (easy for me, that is) with
both of the two downsides.  If we end up doing "subproject"
thing, we could rectify things later, if this is OK with you.
