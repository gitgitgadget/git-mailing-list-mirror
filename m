From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [bug] git-add won't add foo/.git/bar
Date: Tue, 25 Mar 2008 00:01:53 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0803242359230.24262@kaos.quantumfyre.co.uk>
References: <fs9f0o$jge$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Michael Gebetsroither <gebi@sbox.tugraz.at>
X-From: git-owner@vger.kernel.org Tue Mar 25 01:03:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdwdH-0006pC-WC
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 01:03:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573AbYCYACe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 20:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753533AbYCYACe
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 20:02:34 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:44362 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751237AbYCYACe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 20:02:34 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id D7DD4C6090
	for <git@vger.kernel.org>; Tue, 25 Mar 2008 00:02:32 +0000 (GMT)
Received: (qmail 11147 invoked by uid 103); 25 Mar 2008 00:01:53 +0000
Received: from 192.168.0.4 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.4):. 
 Processed in 0.144958 secs); 25 Mar 2008 00:01:53 -0000
Received: from elfhelm.quantumfyre.co.uk (HELO kaos.quantumfyre.co.uk) (192.168.0.4)
  by neutron.datavampyre.co.uk with SMTP; 25 Mar 2008 00:01:53 +0000
X-X-Sender: jp3@kaos.quantumfyre.co.uk
In-Reply-To: <fs9f0o$jge$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78132>

On Tue, 25 Mar 2008, Michael Gebetsroither wrote:

> hi,
>
> % git-add -f foo/.git/bar
> fatal: unable to add foo/.git/bar to index

Well, git won't allow .git as a element anywhere in the path, when we 
should only care about the _first_ one - and also, if you use 
--git-dir=banana then we still check for '.git' ... oops.

patch in the works ... ;)

>
> How do i add such a file to a git repository?

wait? :P

Sorry, can't see any easy way to work around this atm.

>
> thx && cu,
> michael
>

-- 
Julian

  ---
"May the forces of evil become confused on the way to your house."
-- George Carlin
