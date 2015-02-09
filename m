From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Is there some way to suppress Cc email only to stable?
Date: Mon, 9 Feb 2015 14:01:59 -0800
Message-ID: <20150209220159.GF4166@linux.vnet.ibm.com>
References: <20150209194224.GA27482@linux.vnet.ibm.com>
 <xmqq386eby6w.fsf@gitster.dls.corp.google.com>
 <20150209211021.GB4166@linux.vnet.ibm.com>
 <xmqqtwyuaipa.fsf@gitster.dls.corp.google.com>
 <20150209214312.GC4166@linux.vnet.ibm.com>
 <xmqqpp9iahct.fsf@gitster.dls.corp.google.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mingo@kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 23:02:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKwPD-000753-Ec
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 23:02:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475AbbBIWCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 17:02:06 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:52829 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761222AbbBIWCF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 17:02:05 -0500
Received: from /spool/local
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <git@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Mon, 9 Feb 2015 15:02:05 -0700
Received: from d03dlp01.boulder.ibm.com (9.17.202.177)
	by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	Mon, 9 Feb 2015 15:02:03 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 811081FF0045
	for <git@vger.kernel.org>; Mon,  9 Feb 2015 14:53:14 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t19M0biK9437336
	for <git@vger.kernel.org>; Mon, 9 Feb 2015 15:00:37 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t19M21YS022771
	for <git@vger.kernel.org>; Mon, 9 Feb 2015 15:02:02 -0700
Received: from paulmck-ThinkPad-W500 (sig-9-65-236-19.ibm.com [9.65.236.19])
	by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id t19M208M022487;
	Mon, 9 Feb 2015 15:02:00 -0700
Received: by paulmck-ThinkPad-W500 (Postfix, from userid 1000)
	id 9329638BAA2; Mon,  9 Feb 2015 14:01:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqpp9iahct.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 15020922-0005-0000-0000-000008AB96DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263611>

On Mon, Feb 09, 2015 at 01:46:10PM -0800, Junio C Hamano wrote:
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:
> 
> >> > Hence the desire to have a Cc that doesn't actually send any email,
> >> > but that is visible in mainline for the benefit of the scripts that
> >> > handle the stable workflow.
> >> 
> >> So a configuration variable that you can set once and forget, e.g.
> >> 
> >>     [sendemail]
> >> 	blacklistedRecipients = stable@vger.kernel.org
> >> 
> >> would not cut it, as you would _later_ want to send the e-mail once
> >> the commit hits the mainline.  Am I reading you correctly?
> >
> > This would actually work for me.  Once the patch is accepted into
> > mainline, I am done with it.  So I should -never- send email to
> > stable@vger.kernel.org, unless I am doing so manually, for example because
> > I forgot to add the stable tag to a given commit.  But in that case,
> > I would just use mutt to forward the patch to stable@vger.kernel.org,
> > and git would not be involved.
> 
> OK, thanks, we have a workable design to let us move forward, then.
> 
> Gits, any takers?

Would it help if I offered a beer?  ;-)

							Thanx, Paul
