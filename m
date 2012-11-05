From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCHv2 2/2] git p4: add support for 'p4 move' in P4Submit
Date: Mon, 5 Nov 2012 12:57:24 -0500
Message-ID: <20121105175724.GB889@padd.com>
References: <1342135740-30290-1-git-send-email-pw@padd.com>
 <1342135740-30290-3-git-send-email-pw@padd.com>
 <loom.20121105T183530-627@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, ggibons@perforce.com
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 18:57:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVQvc-0000CD-Qe
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 18:57:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073Ab2KER52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 12:57:28 -0500
Received: from honk.padd.com ([74.3.171.149]:55348 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750901Ab2KER51 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2012 12:57:27 -0500
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id C6AAFD27;
	Mon,  5 Nov 2012 09:57:26 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 8FCC422B86; Mon,  5 Nov 2012 12:57:24 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <loom.20121105T183530-627@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209079>

vitor.hda@gmail.com wrote on Mon, 05 Nov 2012 17:37 +0000:
> Pete Wyckoff <pw <at> padd.com> writes:
> 
> > 
> > From: Gary Gibbons <ggibbons <at> perforce.com>
> > 
> > For -M option (detectRenames) in P4Submit, use 'p4 move' rather
> > than 'p4 integrate'.  Check Perforce server for exisitence of
> > 'p4 move' and use it if present, otherwise revert to 'p4 integrate'.
> > 
> 
> Hi Pete,
> 
> I've just been hit by a situation where this command is available but is
> disabled in the server. I don't know what is the best approach to avoid
> this issue.

Really?  The command exists in the server because it returns the
text output for "p4 help move".  But "p4 move" itself fails
because it is somehow disabled in the server?

I didn't even know it was possible to administratively disable
commands.

What's the actual error message?  And versions of your client and
server (p4 -V, p4d -V, p4 info).

Any ideas Gary?

		-- Pete
