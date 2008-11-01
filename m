From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git/lib and git/git-gui/lib merge mis-hap?
Date: Sat, 01 Nov 2008 15:46:54 -0700
Message-ID: <7vljw33vz5.fsf@gitster.siamese.dyndns.org>
References: <490CAE40.4060300@op5.se> <20081101202201.GA15463@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 23:48:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwPGa-0007lX-DP
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 23:48:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbYKAWrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 18:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbYKAWrK
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 18:47:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58999 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbYKAWrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 18:47:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9365B77AAE;
	Sat,  1 Nov 2008 18:47:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1580A77AAC; Sat,  1 Nov 2008 18:47:01 -0400 (EDT)
In-Reply-To: <20081101202201.GA15463@spearce.org> (Shawn O. Pearce's message
 of "Sat, 1 Nov 2008 13:22:01 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 02F84A62-A867-11DD-9E22-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99783>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Andreas Ericsson <ae@op5.se> wrote:
>> Settling down to get some libgit2 hacking done (adding build-rules
>> to git.git), I noticed that there's a file in git.git called
>> lib/remote_add.tcl, which looks as if it belongs in git-gui/lib.
>>
>> I don't know how this happened, but since I assume it's subtree
>> merged (thus requiring more work to correct than a simple patch),
>> it would be nifty if it could get corrected so as to make space
>> for the up-and-coming git library :-)
>
> That was a bad merge of git-gui on my part.  I thought it was fixed.
> It only happened in next, and was there only for a day before
> someone pointed it out to me, and I fixed it in the tree.

You seem to have further changes to the master branch of git-gui.  Would
it be a good time to pull for me?  The same question goes to maint as
well.
