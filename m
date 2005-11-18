From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH rev-list.c] max-count in terms of intersection
Date: Fri, 18 Nov 2005 14:42:33 -0800 (PST)
Message-ID: <20051118224233.50766.qmail@web31805.mail.mud.yahoo.com>
References: <7v1x1dha6x.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 00:53:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdEwW-0000pv-2I
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 23:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161009AbVKRWmf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 17:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161047AbVKRWmf
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 17:42:35 -0500
Received: from web31805.mail.mud.yahoo.com ([68.142.207.68]:40602 "HELO
	web31805.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161009AbVKRWme (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 17:42:34 -0500
Received: (qmail 50768 invoked by uid 60001); 18 Nov 2005 22:42:33 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=v62L3YgThuMMwDrHh7gO6CK5BW45ai0HPnlz5kMQv456EOLb9MIvh1p8Jiaoz3hLeePn7Srf9c4vF9RsP8SdY6W37V9CZAq76TXLFwzrV/Bwz8XDHEygeGxGnS6OLBB00ZEqA1lhnjvkQhQAkp1YoA18mljyrLJs3fv1REs74rA=  ;
Received: from [68.221.46.29] by web31805.mail.mud.yahoo.com via HTTP; Fri, 18 Nov 2005 14:42:33 PST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x1dha6x.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12293>


--- Junio C Hamano <junkio@cox.net> wrote:

> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > diff-tree 768b79de9eadc38a839332df0fcce021f7174d6d (from
> 2e67a5f449f4026097494569f871d79bf263ab28)
> > tree 6403fc730f8d5843043788f4c2f466727ba94bc0
> > parent 2e67a5f449f4026097494569f871d79bf263ab28
> > author Luben Tuikov <ltuikov@yahoo.com> 1132349344 -0500
> > committer Luben Tuikov <ltuikov@yahoo.com> 1132349344 -0500
> >
> >     [PATCH rev-list.c] max-count in terms of intersection
> >     
> 
> Documentation/SubmittingPatches, perhaps?

Sorry, I just saw this document existed for GIT too.
Would you like me to resubmit?

> >     When a path designation is given, max-count counts the number
> >     of commits therein (intersection), not globally.
> 
> This makes sense, but I wonder if the same logic applies to
> max_age as well.  If we have clock-skewed commits that are
> skipped by the DENSE processing, we probably do not want them to
> be affecting what to do on the commits that matter.

As far as I understand it, I think max-age is fine the way
it is.  After all, max-age depends on date/time which is
absolute (i.e. applies to commits in the whole set and in
the intersection just the same).

    Luben
