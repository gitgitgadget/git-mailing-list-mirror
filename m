From: David Kastrup <dak@gnu.org>
Subject: Re: Shell script cleanups/style changes?
Date: Fri, 03 Aug 2007 08:08:35 +0200
Message-ID: <85hcnhw3oc.fsf@lola.goethe.zz>
References: <7vsl71tyyq.fsf@assigned-by-dhcp.cox.net>
	<86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<20070802214103.GT29424@schiele.dyndns.org>
	<85vebxy47e.fsf@lola.goethe.zz>
	<7vwswdsfjp.fsf@assigned-by-dhcp.cox.net>
	<85ps25y1ac.fsf@lola.goethe.zz>
	<7vk5sdscfr.fsf@assigned-by-dhcp.cox.net>
	<85wswdwjll.fsf@lola.goethe.zz>
	<20070803022828.GY29424@schiele.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 08:08:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGqLA-00032H-Ik
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 08:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754983AbXHCGIp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 02:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754352AbXHCGIp
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 02:08:45 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:38386 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753986AbXHCGIo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Aug 2007 02:08:44 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 326E61F56F3;
	Fri,  3 Aug 2007 08:08:43 +0200 (CEST)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 1BE7C2D3788;
	Fri,  3 Aug 2007 08:08:43 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-000-210.pools.arcor-ip.net [84.61.0.210])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id DA3681F7042;
	Fri,  3 Aug 2007 08:08:42 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 3BC441C4F931; Fri,  3 Aug 2007 08:08:36 +0200 (CEST)
In-Reply-To: <20070803022828.GY29424@schiele.dyndns.org> (Robert Schiele's message of "Fri\, 3 Aug 2007 04\:28\:28 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3848/Thu Aug  2 22:22:06 2007 on mail-in-04.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54672>

Robert Schiele <rschiele@gmail.com> writes:

> On Fri, Aug 03, 2007 at 02:24:38AM +0200, David Kastrup wrote:
>> The situation is that we currently don't avoid the former.  Robert
>> said that he had prepared a patch that would do so.
>> 
>> It would make sense to either encourage him to present his patch
>
> Well, if you want to see it, just tell me.  Do you want to have it with or
> without the arithmetic replacements I did as well?

>From Junio's answer, I gather that indeed this would seem pointless.
$(...) is not going away anytime soon, and I have seen no evidence
that there is a shell in widespread use that supports it, but doesn't
support ${...#...}.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
