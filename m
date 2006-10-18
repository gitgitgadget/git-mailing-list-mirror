From: Mike McCormack <mike@codeweavers.com>
Subject: Re: [PATCH] git-imap-send: Strip smtp From_ header from imap message.
Date: Thu, 19 Oct 2006 04:02:55 +0900
Organization: CodeWeavers
Message-ID: <45367A5F.7060507@codeweavers.com>
References: <452EBF77.7040301@oribi.org> <7vlknegnwk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Markus Amsler <markus.amsler@oribi.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 12:05:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga8IM-0007xR-Tb
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 12:05:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWJRKFE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 06:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbWJRKFE
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 06:05:04 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:50829 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S932142AbWJRKFB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 06:05:01 -0400
Received: from foghorn.codeweavers.com ([216.251.189.130] helo=[127.0.0.1])
	by mail.codeweavers.com with esmtp (Exim 4.50)
	id 1Ga8IC-0001BI-So; Wed, 18 Oct 2006 05:04:57 -0500
User-Agent: Icedove 1.5.0.7 (X11/20061014)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlknegnwk.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29218>


Junio C Hamano wrote:
> Markus Amsler <markus.amsler@oribi.org> writes:
> 
>> Cyrus imap refuses messages with a 'From ' Header.
>>
>> Signed-off-by: Markus Amsler <markus.amsler@oribi.org>
> 
> Do you know if this change does not upset other implementations
> of imap servers?
> 
> Mike, are you Ok with this change?

Works for me with Courier IMAP.  I'm no expert on mail headers either, 
so no objections from me.

Mike
