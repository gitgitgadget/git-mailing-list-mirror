From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH v3 2/3] Allow help.htmlpath to be a URL prefix
Date: Fri, 29 Jun 2012 00:38:30 +0100
Message-ID: <20120628233830.GA2765@arachsys.com>
References: <8d3c71d21710c66e4d5560cec958552b69a22338.1340866684.git.chris@arachsys.com>
 <cebaecfaa217a20794e8278b4db3ce5b8d667834.1340866684.git.chris@arachsys.com>
 <7vvcib3zam.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 29 01:38:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkOIN-00027A-6M
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jun 2012 01:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217Ab2F1Xii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jun 2012 19:38:38 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:55188 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab2F1Xih (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2012 19:38:37 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1SkOIF-0003Yc-CA; Fri, 29 Jun 2012 00:38:35 +0100
Content-Disposition: inline
In-Reply-To: <7vvcib3zam.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200800>

Junio C Hamano <gitster@pobox.com> writes:

> Sounds sensible and looks reasonable.  Thanks.

Great! Glad they were of interest.

> I do not think [PATCH 3/3] is a positive change at all, though.

Yes, I think my aversion for being thrown into the full manual with
git foo --help is quite unusual, so this one's probably better left
as one of my idiosyncratic local patches.

The reason I thought there was a chance this could be of wider interest is
that, on a machine without man pages,

  $ git show --help
  warning: failed to exec 'man': No such file or directory
  fatal: no man viewer handled the request

is a bit unfriendly when git actually has enough internal help to be able to
offer

  $ git show -h    
  usage: git log [<options>] [<since>..<until>] [[--] <path>...]
     or: git show [options] <object>...

...but only if you know that -h exists and is not a synonym for --help.

Cheers,

Chris.
