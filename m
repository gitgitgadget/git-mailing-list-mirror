From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: warning merge message
Date: Thu, 21 Dec 2006 16:25:23 -0800 (PST)
Message-ID: <121430.93915.qm@web31808.mail.mud.yahoo.com>
References: <Pine.LNX.4.63.0612211022280.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 01:25:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxYE5-00006y-6u
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 01:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423144AbWLVAZZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 19:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423147AbWLVAZZ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 19:25:25 -0500
Received: from web31808.mail.mud.yahoo.com ([68.142.207.71]:43514 "HELO
	web31808.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1423144AbWLVAZZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Dec 2006 19:25:25 -0500
Received: (qmail 4807 invoked by uid 60001); 22 Dec 2006 00:25:24 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=hDZh+6v8N5ZPkvrM7PbCEAc/OQDVJcvIQhx0GHurt7RXhjyjROJOp3kOytqt2clTIO7P5ifLCLLGG+R+xVx7MxqUpOHD7BhvrgKnlRjJx9bPprLC4fI/DKw/2e4sVUc6usaogvlGtKar1xX9kDwDw69B5ZyX6EqV3DrlI/78UoM=;
X-YMail-OSG: y5lky.sVM1k611V1ztOyylFILK4nPwS6mWAK14J7QhpvN.xeXyCRWx06Uq5LTzIGhTyUcgoWawbiZ6Ab2hKocJMqv2i3YZi.EKDGYlJ2Qimb_C30a5S4PAe4333bZ2U_Iix3Y1mLVlKxMRZkyHaT1Z9_SKlNdQjTVhxJObYePSGrnVZPQqpE5AyK
Received: from [64.215.88.90] by web31808.mail.mud.yahoo.com via HTTP; Thu, 21 Dec 2006 16:25:23 PST
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612211022280.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35095>

--- Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Can we please eliminate this f@#$ing message:
> > Warning: No merge candidate found because value of config option
> >          "branch.master.merge" does not match any remote branch fetched.
> 
> Well, you can always tell git explicitely what you want. I.e. specify the 
> remote _and_ the branch you want to merge.

What would be that setting if I want the default behavior?

Is this "merge candidate let-me-impose-my-workflow-on-you" merge
a single step or does it also checkout as
the default behavior: fast forward local origin to remote master,
merge local origin to local master, check out master?

> BTW I am still waiting for your test results regarding the segmentation 
> fault of merge-recursive.

I'm swamped.  Did you say you have no 64 bit machines you can try it on?
Also, I don't mind giving you my dev tree, but currently I don't export
it anywhere.  BTW, I've seen this bug on 64 bit machines.  I've not tried
it on 32.

    Luben
