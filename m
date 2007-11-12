From: Bill Lear <rael@zopyra.com>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare
 repositories?
Date: Mon, 12 Nov 2007 11:24:05 -0600
Message-ID: <18232.35893.243300.179076@lisa.zopyra.com>
References: <86k5on8v6p.fsf@lola.quinscape.zz>
	<20071112131927.GA1701@c3sl.ufpr.br>
	<Pine.LNX.4.64.0711121355380.4362@racer.site>
	<200711121719.54146.wielemak@science.uva.nl>
	<Pine.LNX.4.64.0711121624330.4362@racer.site>
	<vpq3avbv2ju.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121715090.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 18:24:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ird1O-0006r3-LQ
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 18:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759224AbXKLRYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 12:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759201AbXKLRYK
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 12:24:10 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60147 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758070AbXKLRYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 12:24:09 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id lACHO6q07873;
	Mon, 12 Nov 2007 11:24:06 -0600
In-Reply-To: <Pine.LNX.4.64.0711121715090.4362@racer.site>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64668>

On Monday, November 12, 2007 at 17:15:51 (+0000) Johannes Schindelin writes:
>Hi,
>
>On Mon, 12 Nov 2007, Matthieu Moy wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > On Mon, 12 Nov 2007, Jan Wielemaker wrote:
>> >
>> >> I found out that cloning a empty bare repository produces nothing at 
>> >> all, [...]
>> >
>> > If they are empty, what exactly do you mean to clone?
>> 
>> I'd expect an empty repository, with the git remote configured 
>> correctly.
>
>Yeah, right.
>
>Last time I checked, those geneticists did not clone thin air.  They 
>always waited until they had something to clone.

We have wanted this behavior; I don't think it's so foolish.  We have
an administrator create a new bare repo for us, and we populate it by
pushing into it.  It wold be nice if the administrator could create a
bare repo and we could clone from it, and push to it to populate it,
instead of cloning the bare repo from another repo that has already
been (partly) populated.


Bill
