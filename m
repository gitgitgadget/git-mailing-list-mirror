From: Greg KH <greg@kroah.com>
Subject: Re: Is there some way to suppress Cc email only to stable?
Date: Tue, 10 Feb 2015 08:03:19 +0800
Message-ID: <20150210000319.GD15111@kroah.com>
References: <20150209194224.GA27482@linux.vnet.ibm.com>
 <20150209215350.GU29365@google.com>
 <20150209233537.GG4166@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	mingo@kernel.org, stable@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 01:03:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKyIa-0002zt-FS
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 01:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760226AbbBJAD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 19:03:26 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58333 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760022AbbBJADZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Feb 2015 19:03:25 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 533F320C98
	for <git@vger.kernel.org>; Mon,  9 Feb 2015 19:03:24 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Mon, 09 Feb 2015 19:03:24 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:date:from:to:cc:subject
	:message-id:references:mime-version:content-type:in-reply-to; s=
	smtpout; bh=b3zvwKNR0fjVE3ghAR42r6TUDhs=; b=EmLnalbvRx57yMS1lI0u
	P+N8utvk9CjyuA3ID+FEjlysC8lUsxeBgVuH9RFmAuKshslcL0dvAKKzQKQh713I
	lLTzu9YbWTDo8U3ce12T5raXfvmLD2sbjjdnHhdvv/Thmd8g120jZ+kefn1OlD9/
	RLhULsIZZPfpLWB+AjV1+TE=
X-Sasl-enc: 1PdITq8G0mjMI28CsrQyrBYBEUQN2j9faCfAVfJOIgnE 1423526603
Received: from localhost (unknown [210.177.145.245])
	by mail.messagingengine.com (Postfix) with ESMTPA id 72395C00295;
	Mon,  9 Feb 2015 19:03:23 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20150209233537.GG4166@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263619>

On Mon, Feb 09, 2015 at 03:35:37PM -0800, Paul E. McKenney wrote:
> On Mon, Feb 09, 2015 at 01:53:50PM -0800, Jonathan Nieder wrote:
> > Hi,
> > 
> > Paul E. McKenney wrote:
> > 
> > > Cc: <stable@vger.kernel.org>
> > >
> > > Yet I cannot allow git-send-email to actually send email to that address,
> > > lest I get an automated nastygram in response.
> > 
> > Interesting.  Last time this came up, the result seemed to be
> > different[*].
> 
> Hmmm...  Greg KH didn't say there were no automated nastygrams, just
> that he wasn't worried about it.
> 
> I can try it on the next to-be-backported commit and see what happens.

There are no "automated" nastygrams, it's a "hit this key to send out
this form message" I have in my email client.

The only time it triggers a false-positive is when I haven't had enough
coffee in the morning, which is what happened recently with a patch from
John Stultz.  If I've sent you that message incorrectly, I'm sorry,
please let me know.

Again, any patch cc:ed to stable that has a stable mark on it in the
signed-off-by area is fine, and it helps me to know to watch out for
things when they hit Linus's tree, or most importantly, to notice if
they somehow _don't_ hit his tree.  Again, some recent patches from John
fall in to that category, they didn't make it into Linus's tree when
they probably should have for 3.19, and now I need to scoop them up
quickly when they finally do.  If I hadn't been cc:ed on them, I would
not have noticed that.

Hope this helps explain things,

greg k-h
