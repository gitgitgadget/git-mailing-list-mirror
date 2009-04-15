From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: "git cat-file <sha1>" shows usage but should not?
Date: Wed, 15 Apr 2009 18:33:10 +0100 (BST)
Message-ID: <alpine.LNX.2.00.0904151827530.14321@reaper.quantumfyre.co.uk>
References: <49E61067.6060802@hartwork.org> <20090415165420.GB24528@coredump.intra.peff.net> <49E611A5.8090602@hartwork.org> <20090415170444.GA24717@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Sebastian Pipping <webmaster@hartwork.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 15 19:35:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu90i-0000Tp-0U
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 19:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbZDORdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 13:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752025AbZDORdX
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 13:33:23 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:34966 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752004AbZDORdW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Apr 2009 13:33:22 -0400
Received: from neutron.quantumfyre.co.uk (quantumfyre.force9.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 26977131D7E
	for <git@vger.kernel.org>; Wed, 15 Apr 2009 18:33:21 +0100 (BST)
Received: (qmail 18163 invoked by uid 103); 15 Apr 2009 18:33:10 +0100
Received: from quantumfyre.force9.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/9237. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.035605 secs); 15 Apr 2009 17:33:10 -0000
Received: from quantumfyre.force9.co.uk (212.159.54.234)
  by quantumfyre.force9.co.uk with SMTP; 15 Apr 2009 18:33:10 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <20090415170444.GA24717@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116636>

On Wed, 15 Apr 2009, Jeff King wrote:

> static const char * const cat_file_usage[] = {
> -	"git cat-file [-t|-s|-e|-p|<type>] <sha1>",
> -	"git cat-file [--batch|--batch-check] < <list_of_sha1s>",
> +	"git cat-file {-t|-s|-e|-p|<type>} <object>",
> +	"git cat-file [--batch|--batch-check] < <list_of_objects>",

Shouldn't that read:

+	"git cat-file {--batch|--batch-check} < <list_of_objects>",

since, like the previous line, you are required to supply one of the two 
options?

-- 
Julian

  ---
DPRINTK("FAILURE, CAPUT\n");
         linux-2.6.6/drivers/net/tokenring/ibmtr.c
