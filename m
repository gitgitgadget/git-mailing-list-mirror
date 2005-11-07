From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: Problem in update from the linux-2.6 repository
Date: Mon, 7 Nov 2005 15:22:08 -0800
Message-ID: <20051107232208.GB3788@reactrix.com>
References: <1131380293.5824.139.camel@blade> <1131401931.5824.149.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 00:24:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZGJf-0007LV-Ug
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 00:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965591AbVKGXWO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 18:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965594AbVKGXWN
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 18:22:13 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:34129 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S965591AbVKGXWN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2005 18:22:13 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jA7NM9u9032341;
	Mon, 7 Nov 2005 15:22:09 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jA7NM86h032338;
	Mon, 7 Nov 2005 15:22:08 -0800
To: Marcel Holtmann <marcel@holtmann.org>
Content-Disposition: inline
In-Reply-To: <1131401931.5824.149.camel@blade>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11292>

On Mon, Nov 07, 2005 at 11:18:51PM +0100, Marcel Holtmann wrote:

> forget about this thing. The reason for this problem was the kernel.org
> mirroring and the repository wasn't in a sane state. However it would be
> great if we can detect this somehow.

Is this an issue with the two servers (or virtual servers?) behind the
kernel.org DNS name being out of sync?

Would it make sense to configure the individual servers to be http-alternates
of each other?

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
