From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: On blame/pickaxe
Date: Mon, 16 Oct 2006 15:15:01 +0100
Message-ID: <453393E5.3020203@shadowen.org>
References: <7vr6xddm7h.fsf@assigned-by-dhcp.cox.net> <20061016022159.GZ20017@pasky.or.cz> <7v8xjgvjys.fsf@assigned-by-dhcp.cox.net> <200610161602.49811.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@suse.cz>,
	Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 16:15:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZTFn-0000jU-VX
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 16:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWJPOPl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 10:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbWJPOPl
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 10:15:41 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:58128 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S932092AbWJPOPl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Oct 2006 10:15:41 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GZTF5-0007zj-UC; Mon, 16 Oct 2006 15:15:00 +0100
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200610161602.49811.Josef.Weidendorfer@gmx.de>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28963>

Josef Weidendorfer wrote:
> Hi,
> 
> this blame-passing thing really looks very promising and powerful.
> 
> On Monday 16 October 2006 08:43, you wrote:
>> If the user is not prepared to see code movement, pickaxe can be
>> run without -M nor -C to get the classic blame output.
> 
> Another blame-passing heuristic would be very interesting for code:
> "Ignore white-space changes".
> This way, commits which only do some reindentations simply are skipped.
> 
> It looks like such a thing would just be a matter of passing "-b" to
> executions of "diff" in the blame-passing algorithm.

I am thinking that that is probabally going to need to be optional, for
example python the indentation is everything to the meaning of the code.

-apw
