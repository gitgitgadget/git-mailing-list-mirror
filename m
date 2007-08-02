From: David Kastrup <dak@gnu.org>
Subject: Re: Shell script cleanups/style changes?
Date: Fri, 03 Aug 2007 01:52:32 +0200
Message-ID: <85d4y5xznj.fsf@lola.goethe.zz>
References: <85odhpzmbo.fsf@lola.goethe.zz>
	<7vsl71tyyq.fsf@assigned-by-dhcp.cox.net>
	<86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<20070802214103.GT29424@schiele.dyndns.org>
	<85vebxy47e.fsf@lola.goethe.zz>
	<7vwswdsfjp.fsf@assigned-by-dhcp.cox.net>
	<20070802232126.GU29424@schiele.dyndns.org>
	<85k5sdy0lk.fsf@lola.goethe.zz>
	<20070802234515.GW29424@schiele.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 01:52:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGkTD-0004d6-RO
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 01:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757301AbXHBXwl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 19:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756856AbXHBXwl
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 19:52:41 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:58155 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756833AbXHBXwk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Aug 2007 19:52:40 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 6B27B183D9B;
	Fri,  3 Aug 2007 01:52:39 +0200 (CEST)
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net [151.189.21.50])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id 59F0623D2D9;
	Fri,  3 Aug 2007 01:52:39 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-049-245.pools.arcor-ip.net [84.61.49.245])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 27E542351A8;
	Fri,  3 Aug 2007 01:52:39 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 74C481D0344E; Fri,  3 Aug 2007 01:52:32 +0200 (CEST)
In-Reply-To: <20070802234515.GW29424@schiele.dyndns.org> (Robert Schiele's message of "Fri\, 3 Aug 2007 01\:45\:15 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3848/Thu Aug  2 22:22:06 2007 on mail-in-10.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54648>

Robert Schiele <rschiele@gmail.com> writes:

> On Fri, Aug 03, 2007 at 01:32:07AM +0200, David Kastrup wrote:
>> Robert Schiele <rschiele@gmail.com> writes:
>> > Well, I have now a patch ready for submission that would replace all
>> > occurences of ${PARAMETER#WORD}, ${PARAMETER%WORD}, and $((
>> > EXPRESSION )).  But if you say that you won't accept replacement of
>> > $( ... ) then this is not worth the effort since this one isn't
>> > accepted as well.
>> 
>> I absolutely can't understand your claim that most things work for
>> you, then.  Are you _really_, _really_ sure you are talking about
>> /bin/sh here?
>
> I started wondering myself and it turned out that we just didn't
> look in the right place.  Actually we _have_ an infrastructure in
> place to replace the shell.  (SHELL_PATH in the Makefile) In that
> case I would not consider this an issue and you might go on with the
> cleanup from my point of view.

I was starting to doubt my sanity here.  Sorry that this thread
resulted in wasted work for you.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
