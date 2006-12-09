X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Documentation/git-commit.txt
Date: Fri, 8 Dec 2006 23:31:23 -0500
Message-ID: <20061209043123.GB18204@fieldses.org>
References: <7vy7pik51b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 9 Dec 2006 04:31:56 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vy7pik51b.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33798>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GstsM-00056O-Pl for gcvg-git@gmane.org; Sat, 09 Dec
 2006 05:31:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758817AbWLIEb2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 23:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758426AbWLIEb2
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 23:31:28 -0500
Received: from mail.fieldses.org ([66.93.2.214]:42209 "EHLO
 pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1758751AbWLIEbY (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 23:31:24 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1Gstrv-000767-Dd; Fri, 08 Dec 2006
 23:31:23 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Fri, Dec 08, 2006 at 03:20:32AM -0800, Junio C Hamano wrote:
> I think I went overboard and ended up not using the word
> "index", but eradicating the word was not my intention.

Yeah, "index" is a perfectly OK word, and it's already used all over the
documentation.

I think what you want to avoid is a huge digression into blobs, trees,
SHA1's, and the structure of the index file when you could just slip it
in there without a lot of fanfare, maybe like:

> +When recoring your own work, the contents of modified files in
> +your working tree are staged with gitlink:git-add[1].
		       ^^^
...are temporarily stored to a staging area called the "index" with...

(though maybe that's a little cumbersome).

Also, I don't think there's anything wrong with the verb "stage", but I
think it may be a little less commonly used (in this meaning) than the
term "staging area", so people might catch on faster if we started with
"staging area".

