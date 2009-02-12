From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH] Update documentation to add further information about
 using Thunderbird with git-imap-send.
Date: Thu, 12 Feb 2009 13:18:48 -0800
Organization: YPO4
Message-ID: <49949238.3040600@xenotime.net>
References: <49944570.1020805@codeweavers.com> <7vocx7jr26.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeremy White <jwhite@codeweavers.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 22:19:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXiyI-0005XX-I4
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 22:19:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753560AbZBLVSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 16:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753038AbZBLVST
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 16:18:19 -0500
Received: from xenotime.net ([72.52.64.118]:37158 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751238AbZBLVSS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 16:18:18 -0500
Received: from ::ffff:71.117.247.66 ([71.117.247.66]) by xenotime.net for <git@vger.kernel.org>; Thu, 12 Feb 2009 13:18:15 -0800
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
In-Reply-To: <7vocx7jr26.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109658>

Junio C Hamano wrote:
> Jeremy White <jwhite@codeweavers.com> writes:
> 
>> +  3.  Disable the use of format=flowed
>> +      Edit..Preferences..Advanced..Config Editor.  Search for:
>> +        mailnews.send_plaintext_flowed
>> +      toggle it to make sure it is set to 'true'.
> 
> True???

Hi,

Someone else questioned (corrected) that as well.  It also
conflicts with the Linux kernel file:Documentation/email-clients.txt (extract):

- Edit your Thunderbird config settings so that it won't use format=flowed:
      user_pref("mailnews.send_plaintext_flowed", false);


~Randy
