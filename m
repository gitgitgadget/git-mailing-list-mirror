From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: pull-fetch-param.txt
Date: Fri, 20 Jul 2007 18:09:07 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707201758330.26817@reaper.quantumfyre.co.uk>
References: <tkrat.4532d38d43e16a62@s5r6.in-berlin.de>
 <7vhcymt07a.fsf@assigned-by-dhcp.cox.net> <452211C2.8020402@s5r6.in-berlin.de>
 <7vven1rfpj.fsf@assigned-by-dhcp.cox.net> <45222B18.1090305@s5r6.in-berlin.de>
 <20070712130631.13667.qmail@594d46613ccd9b.315fe32.mid.smarden.org>
 <7vvecps2rz.fsf@assigned-by-dhcp.cox.net>
 <20070713055346.634.qmail@1e54e4f4e1041d.315fe32.mid.smarden.org>
 <7vejjcpyb5.fsf@assigned-by-dhcp.cox.net>
 <20070713074824.9806.qmail@df2dc1a3890a6b.315fe32.mid.smarden.org>
 <20070720143214.23897.qmail@511f57d39b0a54.315fe32.mid.smarden.org>
 <7vbqe7xbvq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 19:09:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBvzK-0005S6-4R
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 19:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935150AbXGTRJM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 13:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934722AbXGTRJL
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 13:09:11 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:51135 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933058AbXGTRJK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jul 2007 13:09:10 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 4BADEB0EBB
	for <git@vger.kernel.org>; Fri, 20 Jul 2007 18:09:08 +0100 (BST)
Received: (qmail 16681 invoked by uid 103); 20 Jul 2007 18:09:07 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3701. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.0315 secs); 20 Jul 2007 17:09:07 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 20 Jul 2007 18:09:07 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <7vbqe7xbvq.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53101>

On Fri, 20 Jul 2007, Junio C Hamano wrote:

> Gerrit Pape <pape@smarden.org> writes:
>
>>> I'll check with the docbook-xsl Debian maintainer.
>>
>> The change in docbook-xsl was by intention, please see
>>  http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=420114#22
>
> Hmph. Where does that leave us poor users who would want to
> support both 1.71 and 1.72, I wonder...
>
> Will they have the same revert in 1.73 for that House Sign, too?

It looks like they do, so perhaps we could just say that you will have 
issues building the git docs with 1.72 and ignore my last patch?

(comparing http://docbook.xml-doc.org/snapshots/xsl/manpages/utility.xsl 
which has today's date and uses . and \ against 
http://docbook.sourceforge.net/release/xsl/1.72.0/manpages/utility.xsl 
which uses U+2302 and U+2593)

-- 
Julian

  ---
Old MacDonald had an agricultural real estate tax abatement.
