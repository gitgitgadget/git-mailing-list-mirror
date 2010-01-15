From: Sebastian Pipping <webmaster@hartwork.org>
Subject: Re: git clone against firewall
Date: Fri, 15 Jan 2010 20:19:50 +0100
Message-ID: <4B50BFD6.2090308@hartwork.org>
References: <4B4FACB1.2080902@hartwork.org> <7vzl4fz0zb.fsf@alter.siamese.dyndns.org> <4B50BE10.5010603@hartwork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 20:20:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVriU-0007mV-6F
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 20:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758077Ab0AOTT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 14:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758076Ab0AOTT7
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 14:19:59 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.43]:48648 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756261Ab0AOTT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 14:19:58 -0500
X-Greylist: delayed 70090 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Jan 2010 14:19:58 EST
Received: from [78.52.98.79] (helo=[192.168.0.3])
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <webmaster@hartwork.org>)
	id 1NVri3-0008Fg-3G; Fri, 15 Jan 2010 20:19:51 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20100103 Thunderbird/3.0
In-Reply-To: <4B50BE10.5010603@hartwork.org>
X-Df-Sender: 874396
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137101>

On 01/15/10 20:12, Sebastian Pipping wrote:
> I get a loop/freeze on
> 
>   Trying 66.219.59.40...
> 
> nothing more.  Can you deduce from that, what's happening?

Wait, it actually times out:

  # date ; telnet git.overlays.gentoo.org 9418 ; date
  Fr 15. Jan 20:14:01 CET 2010
  Trying 66.219.59.40...
  telnet: Unable to connect to remote host: Connection timed out
  Fr 15. Jan 20:17:10 CET 2010



Sebastian
