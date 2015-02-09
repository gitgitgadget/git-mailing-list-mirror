From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Is there some way to suppress Cc email only to stable?
Date: Mon, 9 Feb 2015 15:35:37 -0800
Message-ID: <20150209233537.GG4166@linux.vnet.ibm.com>
References: <20150209194224.GA27482@linux.vnet.ibm.com>
 <20150209215350.GU29365@google.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mingo@kernel.org, stable@vger.kernel.org,
	greg@kroah.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: stable-owner@vger.kernel.org Tue Feb 10 00:35:50 2015
Return-path: <stable-owner@vger.kernel.org>
Envelope-to: glks-stable3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <stable-owner@vger.kernel.org>)
	id 1YKxrj-0001CW-VH
	for glks-stable3@plane.gmane.org; Tue, 10 Feb 2015 00:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933301AbbBIXfm (ORCPT <rfc822;glks-stable3@m.gmane.org>);
	Mon, 9 Feb 2015 18:35:42 -0500
Received: from e39.co.us.ibm.com ([32.97.110.160]:56967 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932911AbbBIXfl (ORCPT
	<rfc822;stable@vger.kernel.org>); Mon, 9 Feb 2015 18:35:41 -0500
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <stable@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Mon, 9 Feb 2015 16:35:41 -0700
Received: from d03dlp02.boulder.ibm.com (9.17.202.178)
	by e39.co.us.ibm.com (192.168.1.139) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	Mon, 9 Feb 2015 16:35:40 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id D64633E40030;
	Mon,  9 Feb 2015 16:35:39 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t19NYEf029294722;
	Mon, 9 Feb 2015 16:34:14 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t19NZcXA019555;
	Mon, 9 Feb 2015 16:35:39 -0700
Received: from paulmck-ThinkPad-W500 (sig-9-65-236-19.ibm.com [9.65.236.19])
	by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id t19NZcXP019525;
	Mon, 9 Feb 2015 16:35:38 -0700
Received: by paulmck-ThinkPad-W500 (Postfix, from userid 1000)
	id 943F338BAA2; Mon,  9 Feb 2015 15:35:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150209215350.GU29365@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 15020923-0033-0000-0000-0000039B4032
Sender: stable-owner@vger.kernel.org
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263616>

On Mon, Feb 09, 2015 at 01:53:50PM -0800, Jonathan Nieder wrote:
> Hi,
> 
> Paul E. McKenney wrote:
> 
> > Cc: <stable@vger.kernel.org>
> >
> > Yet I cannot allow git-send-email to actually send email to that address,
> > lest I get an automated nastygram in response.
> 
> Interesting.  Last time this came up, the result seemed to be
> different[*].

Hmmm...  Greg KH didn't say there were no automated nastygrams, just
that he wasn't worried about it.

I can try it on the next to-be-backported commit and see what happens.

							Thanx, Paul

> Thanks,
> Jonathan
> 
> [*] http://thread.gmane.org/gmane.comp.version-control.git/178926/focus=178929
> 
