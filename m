From: Brian Swetland <swetland@google.com>
Subject: Re: `git-send-email' doesn't specify `Content-Type'
Date: Sun, 11 Nov 2007 00:39:15 -0800
Organization: Google, Inc.
Message-ID: <20071111083915.GA18021@bulgaria>
References: <87ode3klc7.fsf@chbouib.org> <Pine.LNX.4.64.0711100052290.4362@racer.site> <20071110101420.GA21353@bulgaria> <20071110122528.GA4977@atjola.homenet> <20071110123505.GA24445@bulgaria> <20071110125126.GA7261@atjola.homenet> <20071111083224.GA30299@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ludovic =?iso-8859-1?Q?Court=E8s?= <ludo@chbouib.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 11 09:40:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir8MO-0005g4-88
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 09:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301AbXKKIjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 03:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753060AbXKKIjt
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 03:39:49 -0500
Received: from smtp-out.google.com ([216.239.45.13]:55692 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbXKKIjs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 03:39:48 -0500
Received: from zps38.corp.google.com (zps38.corp.google.com [172.25.146.38])
	by smtp-out.google.com with ESMTP id lAB8daRB011551;
	Sun, 11 Nov 2007 00:39:36 -0800
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:to:cc:subject:message-id:references:
	mime-version:content-type:content-disposition:in-reply-to:organization:user-agent;
	b=cCVaiWmLJxfBmgeWclp+usbq2Own5W0lVr65gp1BZ8h/ITkkY5aa/1qRpXbbPCWdv
	xE5YA/yTK/YJTQGJQHO3g==
Received: from bulgaria (bulgaria.corp.google.com [172.18.102.38])
	by zps38.corp.google.com with ESMTP id lAB8dZ2I004791;
	Sun, 11 Nov 2007 00:39:36 -0800
Received: by bulgaria (Postfix, from userid 1000)
	id 2F12B8F45C; Sun, 11 Nov 2007 00:39:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20071111083224.GA30299@sigill.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64431>


This issue with the encoding of the author got me thinking...

What happens if the metadata has utf8 content and the patch itself has 
some *other* non-ascii encoding (some iso-latin variant perhaps).

Is there any way to deal with that situation sanely other than indicate
that it's 8bit content and not specify an encoding?  Is that what
happens currently?

Brian
