From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Is there some way to suppress Cc email only to stable?
Date: Mon, 9 Feb 2015 16:35:01 -0800
Message-ID: <20150210003501.GI4166@linux.vnet.ibm.com>
References: <20150209194224.GA27482@linux.vnet.ibm.com>
 <20150209215350.GU29365@google.com>
 <20150209233537.GG4166@linux.vnet.ibm.com>
 <20150210000319.GD15111@kroah.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	mingo@kernel.org, stable@vger.kernel.org
To: Greg KH <greg@kroah.com>
X-From: stable-owner@vger.kernel.org Tue Feb 10 01:35:18 2015
Return-path: <stable-owner@vger.kernel.org>
Envelope-to: glks-stable3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <stable-owner@vger.kernel.org>)
	id 1YKynI-0005P4-FP
	for glks-stable3@plane.gmane.org; Tue, 10 Feb 2015 01:35:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933272AbbBJAfI (ORCPT <rfc822;glks-stable3@m.gmane.org>);
	Mon, 9 Feb 2015 19:35:08 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:42170 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933184AbbBJAfG (ORCPT
	<rfc822;stable@vger.kernel.org>); Mon, 9 Feb 2015 19:35:06 -0500
Received: from /spool/local
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <stable@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Mon, 9 Feb 2015 17:35:05 -0700
Received: from d03dlp03.boulder.ibm.com (9.17.202.179)
	by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	Mon, 9 Feb 2015 17:35:04 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 2E49B19D803F;
	Mon,  9 Feb 2015 17:26:13 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t1A0Z8uw42533114;
	Mon, 9 Feb 2015 17:35:08 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t1A0Z2ut020227;
	Mon, 9 Feb 2015 17:35:03 -0700
Received: from paulmck-ThinkPad-W500 (sig-9-65-236-19.ibm.com [9.65.236.19])
	by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id t1A0Z10t020189;
	Mon, 9 Feb 2015 17:35:02 -0700
Received: by paulmck-ThinkPad-W500 (Postfix, from userid 1000)
	id 477D238BAA2; Mon,  9 Feb 2015 16:35:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150210000319.GD15111@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 15021000-0017-0000-0000-00000899B00C
Sender: stable-owner@vger.kernel.org
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263621>

On Tue, Feb 10, 2015 at 08:03:19AM +0800, Greg KH wrote:
> On Mon, Feb 09, 2015 at 03:35:37PM -0800, Paul E. McKenney wrote:
> > On Mon, Feb 09, 2015 at 01:53:50PM -0800, Jonathan Nieder wrote:
> > > Hi,
> > > 
> > > Paul E. McKenney wrote:
> > > 
> > > > Cc: <stable@vger.kernel.org>
> > > >
> > > > Yet I cannot allow git-send-email to actually send email to that address,
> > > > lest I get an automated nastygram in response.
> > > 
> > > Interesting.  Last time this came up, the result seemed to be
> > > different[*].
> > 
> > Hmmm...  Greg KH didn't say there were no automated nastygrams, just
> > that he wasn't worried about it.
> > 
> > I can try it on the next to-be-backported commit and see what happens.
> 
> There are no "automated" nastygrams, it's a "hit this key to send out
> this form message" I have in my email client.
> 
> The only time it triggers a false-positive is when I haven't had enough
> coffee in the morning, which is what happened recently with a patch from
> John Stultz.  If I've sent you that message incorrectly, I'm sorry,
> please let me know.

If that happened, it would have been a while back.

> Again, any patch cc:ed to stable that has a stable mark on it in the
> signed-off-by area is fine, and it helps me to know to watch out for
> things when they hit Linus's tree, or most importantly, to notice if
> they somehow _don't_ hit his tree.  Again, some recent patches from John
> fall in to that category, they didn't make it into Linus's tree when
> they probably should have for 3.19, and now I need to scoop them up
> quickly when they finally do.  If I hadn't been cc:ed on them, I would
> not have noticed that.
> 
> Hope this helps explain things,

Yep, thank you!  I will add the Cc stable lines as appropriate and stop
bothering the git guys.  ;-)

							Thanx, Paul
