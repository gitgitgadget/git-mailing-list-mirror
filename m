From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH v5 5/6] fast-import: add option command
Date: Thu, 27 Aug 2009 19:44:32 +0100 (BST)
Message-ID: <alpine.LNX.2.00.0908271942090.6501@reaper.quantumfyre.co.uk>
References: <1251396736-928-1-git-send-email-srabbelier@gmail.com> <1251396736-928-2-git-send-email-srabbelier@gmail.com> <1251396736-928-3-git-send-email-srabbelier@gmail.com> <1251396736-928-4-git-send-email-srabbelier@gmail.com>
 <1251396736-928-5-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.clatworthy@canonical.com>,
	Matt McClure <mlm@aya.yale.edu>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Aaron Bentley <aaron@aaronbentley.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 20:48:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgk1n-00017O-7p
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 20:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbZH0Ssq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 14:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbZH0Ssq
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 14:48:46 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:49541 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751168AbZH0Ssq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Aug 2009 14:48:46 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id BB827278875
	for <git@vger.kernel.org>; Thu, 27 Aug 2009 19:48:39 +0100 (BST)
Received: (qmail 25977 invoked by uid 103); 27 Aug 2009 19:44:32 +0100
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/9744. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.027301 secs); 27 Aug 2009 18:44:32 -0000
Received: from reaper.quantumfyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 27 Aug 2009 19:44:32 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <1251396736-928-5-git-send-email-srabbelier@gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127196>

On Thu, 27 Aug 2009, Sverre Rabbelier wrote:

> 	Similar to v4, but now requires that the 'feature git-options'
> 	command is seen before any 'option' command.

...

> +Option commands must be the first commands on the input, to give an
> +option command after any non-option command is an error.

Er ... shouldn't that be the first thing _after_ the "feature git-options" 
command?

-- 
Julian

  ---
You can't play your friends like marks, kid.
 		-- Henry Gondorf, "The Sting"
