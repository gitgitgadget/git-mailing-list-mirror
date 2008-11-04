From: Ian Hilt <ian.hilt@gmx.com>
Subject: Re: How to send patch series without storing them to disk?
Date: Mon, 3 Nov 2008 23:04:19 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811032259220.1791@sys-0.hiltweb.site>
References: <490EC57E.4080200@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Liu Yubao <yubao.liu@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 05:08:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxDDX-00071m-JK
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 05:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031AbYKDEEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 23:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752981AbYKDEEX
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 23:04:23 -0500
Received: from mail.gmx.com ([74.208.5.67]:52016 "HELO mail.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752966AbYKDEEX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 23:04:23 -0500
Received: (qmail invoked by alias); 04 Nov 2008 04:04:21 -0000
Received: from cpe-75-185-223-130.woh.res.rr.com (EHLO localhost) [75.185.223.130]
  by mail.gmx.com (mp-us005) with SMTP; 03 Nov 2008 23:04:21 -0500
X-Authenticated: #47758715
X-Provags-ID: V01U2FsdGVkX1+LgB1pKHyL7KJe4Uo8quU7OiQqAg+d9hAhfPnj7s
	B91hyQgrtllVoj
In-Reply-To: <490EC57E.4080200@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100029>

On Mon, 3 Nov 2008, Liu Yubao wrote:
> Hi,
> 
> I want to send patches like this:
> 
>   git format-patch --stdout --no-color -C --thread -n $oldrev..$newrev | ...send...
> 
> It seems git-send-email can't read email from stdin.

Currently there is a discussion on the git mailing list concerning a way
to make the following possible:

    git send-email $oldrev..$newrev

Here's some more information,

  <http://marc.info/?l=git&w=2&r=1&s=git+send-email&q=b>


	Ian
