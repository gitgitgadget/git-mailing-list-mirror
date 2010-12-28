From: Bruce Momjian <bruce@momjian.us>
Subject: Re: "git show" does not use diff.external like "git diff"
 does
Date: Tue, 28 Dec 2010 12:54:42 -0500 (EST)
Message-ID: <201012281754.oBSHsgU18495@momjian.us>
References: <7v39phyec2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 28 18:55:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXdlY-0006n4-FH
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 18:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754374Ab0L1RzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 12:55:03 -0500
Received: from momjian.us ([70.90.9.53]:61415 "EHLO momjian.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754119Ab0L1RzD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 12:55:03 -0500
Received: (from bruce@localhost)
	by momjian.us (8.11.6/8.11.6) id oBSHsgU18495;
	Tue, 28 Dec 2010 12:54:42 -0500 (EST)
In-Reply-To: <7v39phyec2.fsf@alter.siamese.dyndns.org>
X-Mailer: ELM [version 2.4ME+ PL124 (25)]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164279>

Junio C Hamano wrote:
> Bruce Momjian <bruce@momjian.us> writes:
> 
> > I have diff.external configured properly, and it is used by "git diff",
> > but "git show" does not call the script and only returns unified diffs.
> >
> > Is there a way to make "git show" use an external diff script?
> 
> "git show --ext-diff"?
> 
> We end the Description section of the manual with "This manual page
> describes only the most frequently used options." without explicitly
> saying "Options from the underlying this and that commands can be given as
> well", which is rather suboptimal.
> 
> The only existing hint there is one sentence before, "The command takes
> options applicable to the git diff-tree command...", but the reader needs
> to be both careful and vaguely familiar with the way the git command set
> is structured to take advantage of that hint.

Yes, someone on IRC eventually suggested --ext-diff, and it does work. 
I was hoping for something that caused 'show' to always use --ext-diff,
like git diff does.  A git alias was the only suggested workaround.

-- 
  Bruce Momjian  <bruce@momjian.us>        http://momjian.us
  EnterpriseDB                             http://enterprisedb.com

  + It's impossible for everything to be true. +
