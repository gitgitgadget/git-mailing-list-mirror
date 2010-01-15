From: Sebastian Pipping <webmaster@hartwork.org>
Subject: Re: git clone against firewall
Date: Fri, 15 Jan 2010 20:12:16 +0100
Message-ID: <4B50BE10.5010603@hartwork.org>
References: <4B4FACB1.2080902@hartwork.org> <7vzl4fz0zb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 20:12:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVras-00049l-5H
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 20:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758015Ab0AOTMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 14:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757627Ab0AOTMV
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 14:12:21 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.29]:57406 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810Ab0AOTMU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 14:12:20 -0500
Received: from [78.52.98.79] (helo=[192.168.0.3])
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <webmaster@hartwork.org>)
	id 1NVrai-0002Ee-Vq; Fri, 15 Jan 2010 20:12:17 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20100103 Thunderbird/3.0
In-Reply-To: <7vzl4fz0zb.fsf@alter.siamese.dyndns.org>
X-Df-Sender: 874396
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137098>

On 01/15/10 19:17, Junio C Hamano wrote:
> What do you exactly mean by "blocking"?

I chose "BLOCK always" as action for that port in my home router
(Netgear ProSafe 802.11g) config.  No idea how it's exactly doing that.


> I am guessing that you can resolve the hostname in your environment
> (i.e. you configured your NAT to let DNS go directly outside).

Name resolution works, yes.


> What
> happens when you try the following?
> 
>     $ telnet git.overlays.gentoo.org 9418
> 
> Do you get:
> 
>     Trying 66.219.59.40...
>     telnet: Unable to connect to remote host: Connection refused
> 
> If you get something like:
> 
>     Trying 66.219.59.40...
>     Connected to pelican.gentoo.org.
>     Escape character is '^]'.
> 
> then I don't think you are blocked, and if that is the case, there is not
> much we can do about it.

I get a loop/freeze on

  Trying 66.219.59.40...

nothing more.  Can you deduce from that, what's happening?


> I think your firewall can help, though, by not pretending to be allowing
> the connection and then blocking you halfway.

I'm afraid I cannot configure that.



Sebastian
