From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH 0/2] Speedup fetch with large numbers of refs
Date: Sun, 25 Oct 2009 20:48:45 +0000 (GMT)
Message-ID: <alpine.LNX.2.00.0910252047340.11963@reaper.quantumfyre.co.uk>
References: <20091022210444.18084.61685.julian@quantumfyre.co.uk> <7vd44cymcv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 21:58:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2AAC-0002sw-Fr
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 21:58:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093AbZJYUwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 16:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754066AbZJYUwW
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 16:52:22 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:38286 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753638AbZJYUwV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Oct 2009 16:52:21 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id B88A9360CBC
	for <git@vger.kernel.org>; Sun, 25 Oct 2009 20:52:25 +0000 (GMT)
Received: (qmail 9253 invoked by uid 103); 25 Oct 2009 20:48:45 +0000
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.95.2/9936. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.02534 secs); 25 Oct 2009 20:48:45 -0000
Received: from reaper.quantumfyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 25 Oct 2009 20:48:45 +0000
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <7vd44cymcv.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131236>

On Sun, 25 Oct 2009, Junio C Hamano wrote:

> Hmm, t5515 does not seem to pass with this series for me.

Ah, sorry.  All the tests did (and still do) pass on my mac ...
I'll send an updated version once I get them to pass on Linux too.

-- 
Julian

  ---
George Orwell was an optimist.
