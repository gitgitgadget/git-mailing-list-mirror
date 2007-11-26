From: Junio C Hamano <gitster@pobox.com>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 13:47:18 -0800
Message-ID: <7v3ausfzmh.fsf@gitster.siamese.dyndns.org>
References: <200711252248.27904.jnareb@gmail.com>
	<858x4l2apc.fsf@lola.goethe.zz>
	<alpine.LFD.0.99999.0711261417580.9605@xanadu.home>
	<854pf8243i.fsf@lola.goethe.zz>
	<20071126195750.GD25784@efreet.light.src>
	<AA5ECB69-3F77-483E-AD19-04A5515779B3@wincent.com>
	<7vhcj8g0op.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.99999.0711261631170.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>, Jan Hudec <bulb@ucw.cz>,
	David Kastrup <dak@gnu.org>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 22:47:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwlnx-0004xo-Lq
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 22:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373AbXKZVra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 16:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754775AbXKZVra
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 16:47:30 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:58312 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754285AbXKZVr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 16:47:29 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 29C152EF;
	Mon, 26 Nov 2007 16:47:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 321A799158;
	Mon, 26 Nov 2007 16:47:42 -0500 (EST)
In-Reply-To: <alpine.LFD.0.99999.0711261631170.9605@xanadu.home> (Nicolas
	Pitre's message of "Mon, 26 Nov 2007 16:35:18 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66136>

Nicolas Pitre <nico@cam.org> writes:

> On Mon, 26 Nov 2007, Junio C Hamano wrote:
>
>> Wincent Colaiuta <win@wincent.com> writes:
>> 
>> > For the benefit of newcomers, I just wish the plumbing was kept a  
>> > little bit out of sight. You know, porcelain in /usr/bin and plumbing  
>> > in /usr/libexec or other such place.
>> >
>> > It's fine once you've learnt your workflows and know the 10 or 15 Git  
>> > tools that you'll be using day-to-day; but for people who are just  
>> > starting off this can be a little bit intimidating:
>> >
>> > $ git-<tab>
>> > Display all 146 possibilities? (y or n)
>> 
>> I'd agree to that but I've always considered this an issue for distros.
>> We've supported an ability for them to specify a gitexecdir separate
>> from /usr/bin in our Makefile for almost two years.
>
> Would probably be a good thing to start enforcing that by default. It's 
> easier to follow such policies when they're coordinated from the project 
> origin.

Not really.  The project origin ships the Makefile to install under
$HOME, but I do not see any distros following that.
