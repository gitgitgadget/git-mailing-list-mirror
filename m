From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] git add: do not add files from a submodule
Date: Wed, 23 Jul 2008 11:31:16 -0700
Message-ID: <7v8wvse9l7.fsf@gitster.siamese.dyndns.org>
References: <1216534144-23826-1-git-send-email-gitster@pobox.com>
 <alpine.DEB.1.00.0807201529150.3305@eeepc-johanness>
 <alpine.DEB.1.00.0807210256510.3305@eeepc-johanness>
 <alpine.DEB.1.00.0807222230490.8986@racer>
 <7vhcahgl2j.fsf@gitster.siamese.dyndns.org>
 <20080723081333.GA15243@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Jul 23 20:32:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLj8R-00042s-CJ
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 20:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842AbYGWSbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 14:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753821AbYGWSbX
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 14:31:23 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62540 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753762AbYGWSbW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 14:31:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 164F238D29;
	Wed, 23 Jul 2008 14:31:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D4FAF38D26; Wed, 23 Jul 2008 14:31:17 -0400 (EDT)
In-Reply-To: <20080723081333.GA15243@artemis.madism.org> (Pierre Habouzit's
 message of "Wed, 23 Jul 2008 10:13:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8C9C9042-58E5-11DD-B5FE-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89731>

Pierre Habouzit <madcoder@debian.org> writes:

> On Wed, Jul 23, 2008 at 06:40:20AM +0000, Junio C Hamano wrote:
> ...
>> If we started the process of diagnosing and fixing these issues earlier,
>> and had plausible code to address the issue already in 'next' before the
>> current -rc cycle started, the topic would have been an obvious candidate
>> for the coming release and I'd further say it would be even worth delaying
>> the release for a few weeks if it takes more time.  But I have to say it
>> is too late for 1.6.0 now if we are just noticing and starting the
>> discussion.
>
>   Well given that we now use submodules at work, and that git is
> nowadays somewhere in the top 5 of my most consciously (as opposed to
> the compiler that I rarely call by hand) used software suites (among my
> editor, my MUA, my shell and my tiling WM), I'm very much interested in
> tackling some things about what is (not) done with submodules yet.

Surely the effort is appreciated.

>> This comment goes to the issue Pierre raised last night as well.
>
>   You mean the git checkout issue?

Oh, no; that misuse of parse_opt() that forgot KEEP_DASHDASH one was not
what I had in mind.  I meant to say that your "switch branches between an
old pre-submodule rev and a new one that has a submodule at where a blob
or directory used to be" issue with a good explanation material was a good
starting point for submodule improvements for the next cycle.

I'd like the release schedule not too heavily based on "per feature", but
more time-based.
