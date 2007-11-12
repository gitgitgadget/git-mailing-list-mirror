From: Bill Lear <rael@zopyra.com>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare
 repositories?
Date: Mon, 12 Nov 2007 11:55:15 -0600
Message-ID: <18232.37763.897729.895378@lisa.zopyra.com>
References: <86k5on8v6p.fsf@lola.quinscape.zz>
	<20071112131927.GA1701@c3sl.ufpr.br>
	<Pine.LNX.4.64.0711121355380.4362@racer.site>
	<200711121719.54146.wielemak@science.uva.nl>
	<Pine.LNX.4.64.0711121624330.4362@racer.site>
	<vpq3avbv2ju.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121715090.4362@racer.site>
	<18232.35893.243300.179076@lisa.zopyra.com>
	<Pine.LNX.4.64.0711121727130.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 18:56:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrdVb-0001n7-9R
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 18:55:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbXKLRzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 12:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752367AbXKLRzY
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 12:55:24 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60202 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752314AbXKLRzX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 12:55:23 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id lACHtLI10836;
	Mon, 12 Nov 2007 11:55:21 -0600
In-Reply-To: <Pine.LNX.4.64.0711121727130.4362@racer.site>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64677>

On Monday, November 12, 2007 at 17:30:10 (+0000) Johannes Schindelin writes:
>Hi,
>
>On Mon, 12 Nov 2007, Bill Lear wrote:
>
>> We have an administrator create a new bare repo for us, and we populate 
>> it by pushing into it.  It wold be nice if the administrator could 
>> create a bare repo and we could clone from it, and push to it to 
>> populate it, instead of cloning the bare repo from another repo that has 
>> already been (partly) populated.
>
>I don't see what is soooo hard with using git-remote in the repo you are 
>pushing from.  It's just a "git remote add origin <url>", and you can even 
>use this to push right afterwards: "git push --all origin".
>
>Besides, if you really want to work together, chances are that you do 
>_not_ want to start with <n> independent initial commits.  So you need to 
>populate the repository before starting _anyway_.
>
>Why are easy solutions so unattractive?

Well, 1) to answer your first point: it's not soooo hard, but it's an
extra step that just seems unnecessary.  2) It's not the *easiest*
solution that one can think of, so people naturally complain: "why do
I have to push in the clutch AND select the gear"?


Bill
