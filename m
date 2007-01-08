From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] git-reset --hard: use quotes when we tell the user what
 HEAD was reset to
Date: Mon, 08 Jan 2007 08:33:49 +0000
Message-ID: <45A201ED.8030003@shadowen.org>
References: <20070106102322.7468.57615.stgit@c165>	<7v8xgg553u.fsf@assigned-by-dhcp.cox.net>	<4c8ef70701070456k2f0585f4ga6c35bd77c939c59@mail.gmail.com> <7vfyam1r18.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 09:34:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3px9-0008Qn-6e
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 09:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161198AbXAHIdz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 03:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161200AbXAHIdz
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 03:33:55 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:4200 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161198AbXAHIdy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 03:33:54 -0500
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1H3pw8-0006E6-1V; Mon, 08 Jan 2007 08:32:56 +0000
User-Agent: Icedove 1.5.0.9 (X11/20061220)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyam1r18.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.1.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36242>

Junio C Hamano wrote:
> "Fredrik Kuivinen" <frekui@gmail.com> writes:
> 
>>>>     I think we need to delimit the name better, probabally we need to quote
>>>>     it.  Perhaps something like:
>>>>
>>>>     HEAD is now at ac9c110: "git-fetch: remove .keep file at the end".
>>> ...
>> I don't think the second point is much of an issue. Is it really that
>> irritating to
>> read a word-wrapped line of text? I agree with the first point though, in most
>> cases it will not be a problem in other projects.
>>
>> I still think it is worth doing it, but it certainly isn't super
>> important. Feel free
>> to drop the patch if you want to.
> 
> I do not care much either way, but the third point is that the
> quoted output would look "interesting" if the original title
> text has double-quoted words.  I.e.
> 
>     HEAD is now at 9945d98: "Add "--cacheinfo" option to update-cache."
> 
> Notice also your hand-wrapped example has the final full-stop
> outside the quote, which your patch would not produce ;-).

Heh, well perhaps I should use the original for a while longer and see
if I get used to it.  Of course I mostly use git on git and linux which
both tend to have "error" in their titles :).

-apw
