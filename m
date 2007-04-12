From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: git-format-patch --subject-prefix support.
Date: Thu, 12 Apr 2007 01:54:20 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704120150320.22924@beast.quantumfyre.co.uk>
References: <11763358884124-git-send-email-robbat2@gentoo.org>
 <7vodlumntw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 02:54:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbnZy-0000O9-7E
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 02:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759AbXDLAyX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 20:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753761AbXDLAyX
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 20:54:23 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:58377 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753745AbXDLAyX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2007 20:54:23 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 7F19CC2E04
	for <git@vger.kernel.org>; Thu, 12 Apr 2007 01:54:21 +0100 (BST)
Received: (qmail 19972 invoked by uid 103); 12 Apr 2007 01:53:54 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90/3065. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.033295 secs); 12 Apr 2007 00:53:54 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 12 Apr 2007 01:53:54 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <7vodlumntw.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44299>

On Wed, 11 Apr 2007, Junio C Hamano wrote:

> "Robin H\. Johnson" <robbat2@gentoo.org> writes:
>
>> Add a new option to git-format-patch, entitled --subject-prefix that allows
>> control of the subject prefix '[PATCH]'. Using this option, the text 'PATCH' is
>> replaced with whatever input is provided to the option. This allows easily
>> generating patches like '[PATCH 2.6.21-rc3]' or properly numbered series like
>> '[-mm3 PATCH N/M]'.
>>
>> 1/2 - Implementation and documentation
>> 2/2 - Test case
>
> I suspect this is a job for send-email, not format-patch.  List?

Surely though, send-email is simply a helper for sending patches generated 
by format-patch?  Is there any reason to deny the ability to set the 
prefix to those who don't use send-email but do use format-patch? 
(Personally I found send-email to be cumbersome and confusing, so I've 
stopped using it ...)

It's format-patch that applies the current "[PATCH]" prefix anyway ...

-- 
Julian

  ---
Death, when unnecessary, is a tragic thing.
 		-- Flint, "Requiem for Methuselah", stardate 5843.7
