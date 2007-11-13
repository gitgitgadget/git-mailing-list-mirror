From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/2] Fix parent rewriting in --early-output
Date: Tue, 13 Nov 2007 00:48:16 -0800
Message-ID: <7v1wauv8dr.fsf@gitster.siamese.dyndns.org>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
	<18218.63946.772767.179841@cargo.ozlabs.ibm.com>
	<e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
	<alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711021809060.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711031103340.3342@woody.linux-foundation.org>
	<18221.14113.498416.396006@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0711032234030.15101@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711041004220.15101@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711041124050.15101@woody.linux-foundation.org>
	<alpine.LFD.0.9999.0711122046570.2786@woody.linux-foundation.org>
	<7v1wauzomr.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.9999.0711122238330.2786@woody.linux-foundation.org>
	<alpine.LFD.0.9999.0711122309270.2786@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 09:48:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrrRu-000331-1A
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 09:48:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbXKMIsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 03:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbXKMIsY
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 03:48:24 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:53345 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbXKMIsX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 03:48:23 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 485252FA;
	Tue, 13 Nov 2007 03:48:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 97F0193ECE;
	Tue, 13 Nov 2007 03:48:39 -0500 (EST)
In-Reply-To: <alpine.LFD.0.9999.0711122309270.2786@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 12 Nov 2007 23:16:08 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64770>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> This solves the problem quite naturally, because any tree that hasn't been 
> parsed - or even if it *has* been parsed, but just hasn't gone through 
> the compare function - will then always be seen as "different" and thus 
> interesting.
>
> This fairly straight-forward patch seems to work. It *replaces* the 
> pervious "patch 4/2", and yes, Junio, I think you were very right to 
> complain about that one.
>
> How does this one feel?

I think this is very natural and I like it.

I did not complain but just said I was puzzled, but after
thinking about this a bit I probably should have ;-).
