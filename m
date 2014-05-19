From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [BUG] git push writes to stderr instead of stdout on success
Date: Mon, 19 May 2014 20:43:19 +0400
Message-ID: <20140519164319.GA3468@seldon>
References: <20140519150358.GA3099@seldon>
 <20140519154909.GD20289@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 19 18:43:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmQev-0003AB-6F
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 18:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbaESQnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 12:43:25 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:52060 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S932503AbaESQnX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 12:43:23 -0400
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WmQel-0000uG-Ud; Mon, 19 May 2014 20:43:20 +0400
Content-Disposition: inline
In-Reply-To: <20140519154909.GD20289@sigill.intra.peff.net>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249596>

On Mon, May 19, 2014 at 11:49:09AM -0400, Jeff King wrote:
> On Mon, May 19, 2014 at 07:03:58PM +0400, Marat Radchenko wrote:
> 
> > `git push` writes to stderr instead of stdout
> 
> That's by design.
> 
> Which one is correct is largely a matter of philosophy / mental model.
> This case has been discussed before:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/180673
> 
> Keep in mind also that "git push --porcelain" does go to stdout and is
> machine-parsed, so no other messages can go to stdout when that option
> is enabled.

Oh, missed --porcelain switch. Thanks.
