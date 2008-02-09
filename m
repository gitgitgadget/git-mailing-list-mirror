From: Tommy Thorn <tommy-git@thorn.ws>
Subject: Re: [PATCH 3/4] git.el: Check for existing buffers on revert.
Date: Fri, 08 Feb 2008 21:41:16 -0800
Message-ID: <47AD3CFC.7090401@thorn.ws>
References: <87r6fporp3.fsf@wine.dyndns.org> <87ve4zzfkl.fsf@osv.gnss.ru>	<8763wzwlat.fsf@wine.dyndns.org> <87prv7z84i.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alexandre Julliard <julliard@winehq.org>, git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 06:42:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNiTZ-0004ww-3r
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 06:42:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbYBIFlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 00:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbYBIFlV
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 00:41:21 -0500
Received: from server204.webhostingpad.com ([69.65.0.218]:41821 "EHLO
	server204.webhostingpad.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751163AbYBIFlU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Feb 2008 00:41:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=thorn.ws;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:X-Source-Dir;
	b=LcS+crHmIBQn3ZD0hhDph0KNYY1o9RVljiLX/1ydlin2Y7dInR+nGULSCsPALrYH8dRkssdUePdsTVTqZwQF5YEumTpAT5/DlwtTjJw/gAgYVwT6FH0XicYjZ7IqV1P9;
Received: from 208.65.183.75.static.etheric.net ([208.65.183.75] helo=silver.numba-tu.com)
	by server204.webhostingpad.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <tommy-git@thorn.ws>)
	id 1JNiSh-0001z8-HG; Fri, 08 Feb 2008 23:41:15 -0600
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
In-Reply-To: <87prv7z84i.fsf@osv.gnss.ru>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server204.webhostingpad.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - thorn.ws
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73194>

Sergei Organov wrote:
> BTW, there is another related issue: what to do with buffers for which their
> files disappear (are removed). AFAIK PCVS doesn't close such buffers,
> that according to the above logic is confusing as well.
>   

Please don't revert such buffers! More than once have I been saved from 
a blunder by the fact that Emacs still had a copy of the accidentally 
erase/overwritten file. The normal Emacs behaviour is to prompt upon 
editing whether to edit the buffer since the file has changed.

Thanks
Tommy
