From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 5/8] var: accept multiple variables on the command line
Date: Thu, 15 Nov 2012 00:10:12 -0800
Message-ID: <20121115081012.GE8429@elie.Belkin>
References: <20121115003029.GA17550@sigill.intra.peff.net>
 <20121115003504.GE17819@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 15 09:10:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYuWw-0002Bw-BU
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 09:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992889Ab2KOIKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 03:10:19 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58451 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992679Ab2KOIKS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 03:10:18 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so984229pbc.19
        for <git@vger.kernel.org>; Thu, 15 Nov 2012 00:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZAXu/5FSxJyfpsYr5is5+INgY43Yhihpml4EFkoMqTE=;
        b=jPf57RcerLT3+9o9Tz2jjkbfmPURF4XMadV2giQv0ridal14XT+tuu+D8VxgyhIVtF
         I/LcLzEOn1D14mh1gAGXPgozKPZ3UPUanDwcYYuhc5Dd7jLrTwq6RImPkCRdI3ZdYjdU
         XU35b1JxKW6Dokz8ZTiz2AaE3aYccfPK4BeXGOAMNWhk4tP+hhEobteDinPcFbvFixEV
         CZU3PziyZHnmFrrxlZ6mFCvuQw6PYtIEJojpbqVh3idUL33siQN5kYeaXQWLkgLTg2ds
         mwkjyTT6VFatW6rdtRCNi9+DpI6TafByrFA8N8jY2DGEq8Mn8b7v7sc27oxfpipjfKJ6
         KQ0g==
Received: by 10.68.252.168 with SMTP id zt8mr2396020pbc.43.1352967017610;
        Thu, 15 Nov 2012 00:10:17 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id o5sm9344020paz.32.2012.11.15.00.10.15
        (version=SSLv3 cipher=OTHER);
        Thu, 15 Nov 2012 00:10:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121115003504.GE17819@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209806>

Jeff King wrote:

> This patch lets callers specify multiple variables, and
> prints one per line.
[...]
> Signed-off-by: Jeff King <peff@peff.net>

Very pleasantly done --- thanks.  For what it's worth, assuming this
is tested, I can't see any reason not to apply it.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
