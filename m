From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Fri, 18 Jan 2008 12:28:22 -0800
Message-ID: <7vr6gedgk9.fsf@gitster.siamese.dyndns.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201>
	<65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org>
	<200801162251.54219.jnareb@gmail.com>
	<1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org>
	<alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
	<7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org>
	<alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org>
	<B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org>
	<alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org>
	<8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org>
	<alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org>
	<B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com>
	<alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org>
	<478F99E7.1050503@web.de>
	<alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org>
	<F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org>
	<alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org>
	<Pine.LNX.4.64.0801181114430.817@ds9.cixit.se>
	<alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 21:29:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFxqL-0008Hq-T6
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 21:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764391AbYARU2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 15:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764878AbYARU2e
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 15:28:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35837 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764843AbYARU2c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 15:28:32 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DE9877717;
	Fri, 18 Jan 2008 15:28:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CC6D7714;
	Fri, 18 Jan 2008 15:28:23 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 18 Jan 2008 09:11:47 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71058>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 18 Jan 2008, Peter Karlsson wrote:
>> 
>> But they are not different strings, they are canonically equivalent as
>> far as Unicode is concerned.
>
> Fuck me with a spoon.
>
> Why the hell cannot people see that "equivalent" and "same" are two 
> totally different meanings.

Could people _please_ stop this already?

I think the sane people see the difference between equivalence
and sameness, and we established that a filesystem that mangles
the filenames behind user's back is a bad design.  Anybody who
followed the thread and still does not agree with you is, eh,
"ugly-and-stupid", as you might say ;-).  You cannot educate
them all.

The thing is, even if you mange to educate them all, that broken
filesystem, and other filesystems with similar brokenness, do
not go away.  If your ultimate objective is to declare that it
is the right thing for git not to support such broken
filesystems, and to make everybody agree to it, that is fine.
Please keep pouring fuel to the fire.  But if that is not the
case, we would need to devise a way to help lives easier for the
unfortunate people who are stuck on such filesystems.  They may
not even realize that they are unfortunate now, and I agree that
some education is justified, but this thread has raged on long
enough to salvage any salvageable lost souls (the remaining ones
may be beyond salvation but let's not waste time on them).

I'd rather see our mental bandwidth spent on coming up with a
workable workaround for such broken filesystems, while not
hurting use of git on sane platforms.

I fear it might have to end up to be very messy and slow,
though.
