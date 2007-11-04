From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix display overlap between remote and local progress
Date: Sun, 04 Nov 2007 15:11:12 -0800
Message-ID: <7v4pg1sj1r.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.9999.0711032328490.21255@xanadu.home>
	<Pine.LNX.4.64.0711041331520.4362@racer.site>
	<alpine.LFD.0.9999.0711041610520.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Nov 05 00:11:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iood5-0006ye-MB
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 00:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206AbXKDXL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 18:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752936AbXKDXL3
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 18:11:29 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:37601 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbXKDXL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 18:11:28 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id A408B2EF;
	Sun,  4 Nov 2007 18:11:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id EAFF6923EE;
	Sun,  4 Nov 2007 18:11:45 -0500 (EST)
In-Reply-To: <alpine.LFD.0.9999.0711041610520.21255@xanadu.home> (Nicolas
	Pitre's message of "Sun, 04 Nov 2007 16:19:52 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63454>

Nicolas Pitre <nico@cam.org> writes:

> On Sun, 4 Nov 2007, Johannes Schindelin wrote:
>
>> On Sun, 4 Nov 2007, Nicolas Pitre wrote:
>> 
>> > +#define SUFFIX "\e[K"  /* change to "        " if ANSI sequences don't work */ 
>> 
>> I am almost certain (without even testing) that cmd.exe has problems with 
>> that.  It does not even understand colorisation.
>
> That's what I was expecting.  This is why I suggested an alternative in 
> the comment.

That's fine --- cmd.exe weenies can patch it away ;-).

The compiler at k.org complains of "\e" being non ISO-C, though.
