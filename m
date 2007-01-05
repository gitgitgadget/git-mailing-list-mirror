From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH 2/4] Improve cached content header of status output
Date: Fri, 05 Jan 2007 13:14:21 +0000
Message-ID: <459E4F2D.4000806@shadowen.org>
References: <1167765983316-git-send-email-j.ruehle@bmiag.de>	<11677659921833-git-send-email-j.ruehle@bmiag.de>	<459E2E57.6020503@shadowen.org> <7vr6u9g1l4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 14:14:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2otu-0007MO-Ry
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 14:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161083AbXAENOX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 08:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbXAENOX
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 08:14:23 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:2669 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965139AbXAENOX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 08:14:23 -0500
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1H2osy-0008CO-9A; Fri, 05 Jan 2007 13:13:28 +0000
User-Agent: Icedove 1.5.0.9 (X11/20061220)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr6u9g1l4.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.1.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36001>

Junio C Hamano wrote:
> Andy Whitcroft <apw@shadowen.org> writes:
> 
>>> +static void wt_status_print_cached_header(const char *reference)
>>> +{
>>> +	const char *c = color(WT_STATUS_HEADER);
>>> +	color_printf_ln(c, "# Cached changes to be committed:");
>>> ...
>> We seem to be using 'Cached' and 'staged' here.  I thought we had
>> updated all the docs to call files in the index "Staged for commit".
> 
> 	# Changes staged to be committed:
> 
> Somebody did not like the verb "stage"; perhaps we can say:
> 
> 	# You have added changes to these files to be committed:
> 	...

# These files have changes and are marked for commit:

>         # There are yet to be added changes to these files:

# These files have changes but are not marked for commit:

> 	...

-apw
