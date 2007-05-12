From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: how to set up e-mail notification?
Date: Sat, 12 May 2007 02:35:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705120232320.30969@beast.quantumfyre.co.uk>
References: <20070511195539.GF3491@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
X-From: git-owner@vger.kernel.org Sat May 12 03:35:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmgW0-0002HD-Ru
	for gcvg-git@gmane.org; Sat, 12 May 2007 03:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530AbXELBfP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 21:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754789AbXELBfP
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 21:35:15 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:58940 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754530AbXELBfN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 May 2007 21:35:13 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id F3921C649C
	for <git@vger.kernel.org>; Sat, 12 May 2007 02:35:11 +0100 (BST)
Received: (qmail 30977 invoked by uid 103); 12 May 2007 02:33:28 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3225. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.035271 secs); 12 May 2007 01:33:28 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 12 May 2007 02:33:28 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <20070511195539.GF3491@cs-wsok.swansea.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47012>

On Fri, 11 May 2007, Oliver Kullmann wrote:

> Hello,
>
> I have set up a Git repository as a shared repository as described in
> the CVS-to-Git conversion manual.
>
> Now I want this shared Git repository to send out notification e-mails
> after commits, simulating what with CVS was achieved by
> adding to CVSROOT/loginfo the lines

...

> Now I would guess many others have already solved that task, and so I would
> be glad it they could tell me such a little script (standard Linux environment).

There's one in the standard git source tree: 
contrib/hooks/post-receive-email

never used it myself ...

-- 
Julian

  ---
Zoe: "Are those grenades?"

Jayne: "Cap'n doesn't want 'em."

Zoe: "We're robbing the place.  We're not occupying it."
