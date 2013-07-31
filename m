From: John Keeping <john@keeping.me.uk>
Subject: Re: Making a patch:  "git format-patch" does not produce the
 documented format
Date: Wed, 31 Jul 2013 22:48:19 +0100
Message-ID: <20130731214818.GP2337@serenity.lan>
References: <201307312131.r6VLVliK028321@hobgoblin.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Dale R. Worley" <worley@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jul 31 23:48:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4eFy-0001w6-VT
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 23:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756926Ab3GaVs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 17:48:27 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:48156 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab3GaVs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 17:48:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 16474CDA57E;
	Wed, 31 Jul 2013 22:48:26 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WqHAg6R8txUY; Wed, 31 Jul 2013 22:48:25 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id E231ACDA3EC;
	Wed, 31 Jul 2013 22:48:24 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id CA216161E49E;
	Wed, 31 Jul 2013 22:48:24 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3DsqtpFNvr8F; Wed, 31 Jul 2013 22:48:24 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 503F3161E3BA;
	Wed, 31 Jul 2013 22:48:20 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <201307312131.r6VLVliK028321@hobgoblin.ariadne.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231469>

On Wed, Jul 31, 2013 at 05:31:47PM -0400, Dale R. Worley wrote:
> Notice that the whole commit message has been formatted as if it is
> part of the Subject line, and the line breaks in the commit message
> have been refilled.
> 
> The file Documentation/SubmittingPatches says that "git format-patch"
> produces patches in the best format, but the manual page shows an
> example more like this:
> 
>     From 8f72bad1baf19a53459661343e21d6491c3908d3 Mon Sep 17 00:00:00 2001
>     From: Tony Luck <tony.luck@intel.com>
>     Date: Tue, 13 Jul 2010 11:42:54 -0700
>     Subject: [PATCH] Put ia64 config files on the
>     MIME-Version: 1.0
>     Content-Type: text/plain; charset=UTF-8
>     Content-Transfer-Encoding: 8bit
> 
>     arch/arm config files were slimmed down using a python script
>     (See commit c2330e286f68f1c408b4aa6515ba49d57f05beae comment)
>     [...]
> 
> That is, the first line of the commit message is in the Subject and
> the remaining lines are in the message body.  As far as I can tell,
> that's what SubmittingPatches prescribes.  And that is what I see in
> the Git mailing list on vger.
> 
> (This is with git 1.8.3.3.)
> 
> Exactly how should the commit message be inserted into the patch
> e-mail?  What needs to be updated so the code is consistent with the
> documentation?

git-format-patch(1) says:

        By default, the subject of a single patch is "[PATCH] " followed
        by the concatenation of lines from the commit message up to the
        first blank line (see the DISCUSSION section of git-commit(1)).

I think that accurately describes what you're seeing.  The referenced
DISCUSSION section describes how to write a commit message that is
formatted in a suitable way, with a short first subject line and then a
blank line before the body of the message.
