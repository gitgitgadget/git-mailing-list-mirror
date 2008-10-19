From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git checkout: --track and --no-track require -b" check
 accidentally resurrected?
Date: Sun, 19 Oct 2008 15:15:53 -0700
Message-ID: <7vhc785izq.fsf@gitster.siamese.dyndns.org>
References: <1224377652.19061.12.camel@mattlaptop2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Mon Oct 20 11:02:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrgaH-0004SU-Fx
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 00:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbYJSWQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 18:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbYJSWQA
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 18:16:00 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38638 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbYJSWP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 18:15:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B684F8D8E7;
	Sun, 19 Oct 2008 18:15:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 75E4C8D8E6; Sun, 19 Oct 2008 18:15:55 -0400 (EDT)
In-Reply-To: <1224377652.19061.12.camel@mattlaptop2.local> (Matt McCutchen's
 message of "Sat, 18 Oct 2008 20:54:12 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 81AC156E-9E2B-11DD-99B1-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98629>

Matt McCutchen <matt@mattmccutchen.net> writes:

> Merge commit 9ba929ed resurrected the following two-line check, which
> was removed in the first parent and unchanged in the second:
>
> 	if (!opts.new_branch && (opts.track != git_branch_track))
> 		die("git checkout: --track and --no-track require -b");
>
> Is this intentional?  Does it make a difference?
>
> (I noticed this while carefully examining 9ba929ed to find out why "git
> merge" stopped honoring merge.conflictstyle.  Ironically, I hit this bug
> again during the examination.)

Again, good eyes.  I think the two lines should go; my fault at cdb22c4
(Merge branch 'jc/better-conflict-resolution' into next, 2008-09-02).

Thanks.
