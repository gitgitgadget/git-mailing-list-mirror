From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sat, 4 Aug 2007 14:42:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708041432350.7932@beast.quantumfyre.co.uk>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net>
 <200708041511.05191.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 15:42:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHJti-0008Dm-NF
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 15:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764774AbXHDNmX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 09:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764691AbXHDNmX
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 09:42:23 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:33288 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764617AbXHDNmW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 09:42:22 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 4B7CEB8D7E
	for <git@vger.kernel.org>; Sat,  4 Aug 2007 14:42:20 +0100 (BST)
Received: (qmail 12092 invoked by uid 103); 4 Aug 2007 14:42:19 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3852. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.032901 secs); 04 Aug 2007 13:42:19 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 4 Aug 2007 14:42:19 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <200708041511.05191.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54847>

On Sat, 4 Aug 2007, Robin Rosenberg wrote:

>
> Commit 281a53bb79786a6d7e54f9715cc8ad46fc2bdb0e introduced some stains on my man pages. They
> look like:
>
>           .ft C
>                     A---B---C topic
>                    /
>               D---E---F---G master
>           .ft
>
> Versions (Mandriva 20071):
>
> 	asciidoc-8.1.0-1mdv2007.1
> 	docbook-style-xsl-1.72.0-1mdv2007.1

docbook xsl 1.72 is the culprit.  This version has extra escaping rules 
that weren't in 1.71 and were removed for 1.73.  In addition these rules 
are not backwardly compatible.  Basically, you can't build the git docs 
properly with 1.72 ...

See http://thread.gmane.org/gmane.comp.version-control.git/52369

-- 
Julian

  ---
<seemant> you should always know where your inodes are, and who they are with
