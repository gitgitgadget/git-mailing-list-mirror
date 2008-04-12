From: Gabriel <g2p.code@gmail.com>
Subject: Re: [PATCH] Default to fetching a remote after adding it.
Date: Sat, 12 Apr 2008 17:13:32 +0200
Message-ID: <20080412171332.5abb2705@localhost>
References: <20080411203501.7095b866@localhost>
	<1207939163-24787-1-git-send-email-g2p.code@gmail.com>
	<alpine.DEB.1.00.0804121532550.16366@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 12 17:14:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkhQx-00069l-Og
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 17:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822AbYDLPNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 11:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752814AbYDLPNq
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 11:13:46 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:6426 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788AbYDLPNp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 11:13:45 -0400
Received: by fg-out-1718.google.com with SMTP id l27so793145fgb.17
        for <git@vger.kernel.org>; Sat, 12 Apr 2008 08:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding:sender;
        bh=FIRn9zxtryD3dc2hl11FYyTS0M4JYwD9Gl940u+Ihkg=;
        b=BP/qQ6ieK6kkx72pId1NOCFB75uYWTQLgw8n3L66VAxBRrHFgDEoIh7KpXejLBknBp4GFPHcVW+yulE8sX5/onT+y16pUEigw8p65UKeRK5O0Mt3nfjVO3n8+TUGolxl+CtEopp5/SgiEKtRBBH9M/m//PN6aMguRQ2sIqULDmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding:sender;
        b=m2xgg615xE/sH8GrKscOBuKAsmGRabas1P9oaZGoIeT6qp5GpxJtNaCPi+zWWXzM2LZkVrwzs10Wv1IaCzBdke4Tn67EnAZ/RtdCvMmIDay+y/nfQM0hhDoN4Z+OstGNJXe5xEP3oR1iN60oXGbE8PO4EFv+DpPpKz5B1a6cyfY=
Received: by 10.86.72.15 with SMTP id u15mr8526952fga.21.1208013223939;
        Sat, 12 Apr 2008 08:13:43 -0700 (PDT)
Received: from localhost ( [88.162.203.35])
        by mx.google.com with ESMTPS id 4sm3224530fge.3.2008.04.12.08.13.41
        (version=SSLv3 cipher=OTHER);
        Sat, 12 Apr 2008 08:13:43 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0804121532550.16366@eeepc-johanness>
X-Mailer: Claws Mail 2.10.0 (GTK+ 2.12.0; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79361>

On Sat, 12 Apr 2008 15:33:30 +0100 (BST),
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Hi,
> 
> On Fri, 11 Apr 2008, Gabriel wrote:
> 
> > This is what the user wants in 99% of cases.
> 
> This is wrong, at least in my experience.  Do not make up statistics
> if you want to be taken seriously.

This is obviously not a real statistic, and poor wording on my part. It
was meant to summarise the justification that I gave in the parent
mail; that justification was certainly up to discussion, and it turns
out I was wrong.

Which leaves us with the other suggestion of the previous patch, that
others have discussed. Now that we have the maintainer's opinion, this
is also settled.

Anyway, it's easy to get into subjective arguments on usability, and
I'll be more careful about this. Which shouldn't prevent us from
improving git usability.
