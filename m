From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Replaced "green" with "#00FF00".
Date: Tue, 1 Jan 2013 10:21:59 +1100
Message-ID: <20121231232159.GA20724@iris.ozlabs.ibm.com>
References: <20121227125916.GC7039@mobiltux>
 <7v623nmmly.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Hofmann <git-dev@uninformativ.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 00:22:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tpogf-0000Qg-86
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 00:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148Ab2LaXWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 18:22:09 -0500
Received: from ozlabs.org ([203.10.76.45]:54266 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092Ab2LaXWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 18:22:09 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id EF3332C0094; Tue,  1 Jan 2013 10:22:07 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <7v623nmmly.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212368>

On Thu, Dec 27, 2012 at 09:27:37AM -0800, Junio C Hamano wrote:
> Peter Hofmann <git-dev@uninformativ.de> writes:
> 
> > Subject: Re: [PATCH] gitk: Replaced "green" with "#00FF00".
> 
> > gitk looks pretty awkward with Tk 8.6. "green" is simply too dark now
> > because it has changed from "#00FF00" to "#008000".
> 
> Your observation "awkward" is somewhat subjective and I am hesitant
> to recommend this change without a better justification.  Given the
> reasoning behind the change Tcl/Tk people made, I wouldn't be
> surprised if people coming from webapp world view the "green" color
> rendered by updated Tcl/Tk more natural.

Given that "green" is used as the background color in some places,
e.g. for the boxes containing the names of heads, and that the general
scheme is dark foreground on light background, I agree that #008000 is
too dark in those places.

> Besides, if we are declaring with this patch that we will stick to
> X11 colors and will not adopt W3C colors, the patch shouldn't update
> only "green", but set all the other colors in stone, no?  "purple",
> for example, is also different between X11 and W3C.

Purple is only used for octopus merges.  I'd like to think of a better
way to use color in representing octopus merges if possible.

> > One could also use "lime" instead of "#00FF00" but that would break
> > compatibility with older versions of Tk.
> 
> A better solution might be to make these colors customizable.

Indeed.  Some people prefer to have all their windows to have light
foregrounds on dark backgrounds, so they would also benefit from
having more of the colors customizable.

Paul.
