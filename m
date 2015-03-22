From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Remove tcl-format flag from a message that
 shouldn't have it
Date: Sun, 22 Mar 2015 14:40:12 +1100
Message-ID: <20150322034012.GD14271@iris.ozlabs.ibm.com>
References: <1421914779-30865-1-git-send-email-alexhenrie24@gmail.com>
 <CAMMLpeTvtzPuiQJVxAx-Ja4JsoUxih5azMaN7_RcLvajny6A6g@mail.gmail.com>
 <xmqqlhk6agxg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>,
	patthoyts@users.sourceforge.net,
	Alex Henrie <alexhenrie24@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 04:41:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZWlj-0005O6-Bj
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 04:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbbCVDle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 23:41:34 -0400
Received: from ozlabs.org ([103.22.144.67]:36007 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601AbbCVDlb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 23:41:31 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id F2EFC1401AF; Sun, 22 Mar 2015 14:41:29 +1100 (AEDT)
Content-Disposition: inline
In-Reply-To: <xmqqlhk6agxg.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266043>

On Mon, Feb 09, 2015 at 01:55:23PM -0800, Junio C Hamano wrote:
> Alex Henrie <alexhenrie24@gmail.com> writes:
> 
> > This is just a friendly reminder that this patch has been sitting in
> > the mailing list archives for a couple of weeks, and it has not yet
> > been accepted or commented on.
> 
> I think that is because the message was not sent to the right
> people, and also because the patch was made against a wrong project
> ;-).
> 
> I'll forward it to the gitk maintainer after digging it out of the
> archive and tweaking it.  Thanks.
> 
> Paul, comments?
> 
> -- >8 --
> From: Alex Henrie <alexhenrie24@gmail.com>
> Date: Thu, 22 Jan 2015 01:19:39 -0700
> Subject: gitk: Remove tcl-format flag from a message that shouldn't have it
> 
> xgettext sees "% o" and interprets it as a placeholder for an octal
> number preceded by a space. However, in this case it's not actually a
> placeholder, and most translations will replace the "% o" sequence with
> something else. Removing the tcl-format flag from this string prevents
> tools like Poedit from freaking out when "% o" doesn't appear in the
> translated string.
> 
> The corrected flag will appear in each translation's po file the next time
> the translation is updated with `make update-po`.
> 
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>

Thanks, applied.

Paul.
