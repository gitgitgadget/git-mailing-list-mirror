From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Setting up a bug tracking system where users can file bug
 reports and feature requests for Git
Date: Mon, 16 Feb 2009 02:00:49 -0800
Message-ID: <7vljs6bt0u.fsf@gitster.siamese.dyndns.org>
References: <loom.20090216T025046-863@post.gmane.org>
 <7vab8nf38a.fsf@gitster.siamese.dyndns.org>
 <slrngpibdp.gmk.heipei@minime.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Gilger <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Mon Feb 16 11:02:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ0Iz-0002G0-3T
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 11:02:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754728AbZBPKA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 05:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754705AbZBPKA5
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 05:00:57 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62340 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061AbZBPKA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 05:00:56 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A0F372B3DC;
	Mon, 16 Feb 2009 05:00:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D54832B3CC; Mon,
 16 Feb 2009 05:00:51 -0500 (EST)
In-Reply-To: <slrngpibdp.gmk.heipei@minime.lan> (Johannes Gilger's message of
 "Mon, 16 Feb 2009 09:11:20 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B32875A4-FC10-11DD-A969-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110157>

Johannes Gilger <heipei@hackvalue.de> writes:

> On 2009-02-16, Junio C Hamano <gitster@pobox.com> wrote:
>> A tracking system is just a tool.  You need to have a competent and stable
>> project secretary whose job is to look after the issues database.
> ...
> If we had such a secretary who's not only familiar with the bugtracker 
> but also familiar enough with git and it's development organization, 
> he/she could work with the system, filter out the noise and mail real 
> bugs or well-thought-through feature-requests to this mailing-list (with 
> a link back to the bugtracker) with the full text of the bug and maybe 
> his/her oppinion about it.

If there were such a person or a group of people to help the project that
way, it would be great.  What you just said is in total agreement of the
paragraph you quoted above (which I omitted ;-)).

> But maybe that's just duplication of work, in your eyes.

As you culled the To/Cc list and sent it only to the mailing list, I
cannot quite tell if you were referring to me, so this is an unsolicited
comment to your statement, but I do not think it is duplication of work at
all.

Sifting chaffs and interfacing with people are what I would love to see
from a capable project secretary.  It is already a large part of what the
maintainer does (see Documentation/howto/maintain-git.txt), but as the
project grows larger, you'll see bottleneck at the maintainer and the
major contributors.  Three things you can do to help are to filter noise,
to summarize useful inputs, and to offload the routine prodding (in both
direction -- querying the status of unfilled requests to developers, and
asking for confirmation of an already implemented fix/enhancement to
requestors) from the maintainer and major contributors, which I listed as
the project secretary tasks.

There are other ways to help: by answering user questions, spotting and
correcting wrong answers and FUDs given in response to inquiries from new
people, dowsing flames before they get out of control, reducing recurring
topics by pointing out previous discussions, etc.
