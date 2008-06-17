From: Junio C Hamano <gitster@pobox.com>
Subject: Re: suggestions for generating diffs through the revision list
Date: Tue, 17 Jun 2008 15:04:28 -0700
Message-ID: <7v63s767mb.fsf@gitster.siamese.dyndns.org>
References: <20080617214142.GM16941@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 00:06:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8jJP-0003rR-Sq
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 00:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760624AbYFQWEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 18:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760620AbYFQWEj
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 18:04:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41984 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760222AbYFQWEh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 18:04:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B433C11620;
	Tue, 17 Jun 2008 18:04:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E70A91161F; Tue, 17 Jun 2008 18:04:32 -0400 (EDT)
In-Reply-To: <20080617214142.GM16941@redhat.com> (Don Zickus's message of
 "Tue, 17 Jun 2008 17:41:42 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5F58AC94-3CB9-11DD-B079-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85330>

Don Zickus <dzickus@redhat.com> writes:

> I am try to walk the revision history for a given path and analyze the
> diff (as compared to its parent).  What is the proper way of doing that?
>
> I noticed a bunch of 'library' calls such as
>
> init_revsion(&revs);
> setup_revisions(argc, argv, &revs, "HEAD");
> prepare_revision_walk(&revs, NULL);
> commit = get_revision(&revs);
>
> But what I can't find is the way to generate diffs.  I see lots and lots
> of code to do it, but every builtin seems to do it differently.  Not
> knowing the internals that well, I was hoping for some advice.
>
> I stumbled upon calls like
>
> run_diff_files
> run_diff_index
>
> but I haven't seen how to use them correctly.

Documentation/technical/api-*.txt
