From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4] Documentation: triangular workflow
Date: Mon, 13 Jun 2016 11:35:27 -0700
Message-ID: <xmqqa8ipc4y8.fsf@gitster.mtv.corp.google.com>
References: <1465288693-6295-1-git-send-email-jordan.de-gea@grenoble-inp.org>
	<1465475708-1912-1-git-send-email-jordan.de-gea@grenoble-inp.org>
	<E41AB752AE614E189BC5BE289A8AEB2A@PhilipOakley>
	<xmqqinxhf0sx.fsf@gitster.mtv.corp.google.com>
	<5B90624A6DC7442C94B933A07F0CD08D@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Jordan DE GEA" <jordan.de-gea@grenoble-inp.org>,
	<mhagger@alum.mit.edu>, "Git List" <git@vger.kernel.org>,
	"Erwan Mathoniere" <erwan.mathoniere@grenoble-inp.org>,
	"Samuel Groot" <samuel.groot@grenoble-inp.org>,
	"Tom Russello" <tom.russello@grenoble-inp.org>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>,
	"Jeff King" <peff@peff.net>, <artagnon@gmail.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Jun 13 20:35:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCWi0-0001BQ-UJ
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 20:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbcFMSfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 14:35:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58806 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751578AbcFMSfb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 14:35:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 22A6B24B20;
	Mon, 13 Jun 2016 14:35:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5vumnQpJqslxsLQ78gkGYPqOEgs=; b=loLjdk
	vXpeWzdJhel9zP+jjLcD/SRQ1937Xr6IyjCrJuTPLZBbzUfxT0kPNcmgHrvP9muj
	HU/9WyvT19i+OQR/G93VEHxXe/Qo1iZAohmWS8S/vsN1w28AM0WARuV2a77z/ZCR
	xxCGsZcwxZCeq2XwmjqS+HBY+D1DlMMg6axfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MYUcqj6NPTT+CvHBgNRYm2uzs3URS4jp
	ZaIzYAmAJkUXtDxjwNVqUZIA6bBMpAx8k45L48ocGGUpI1Mr+zp4wkYa6gfNmCEL
	zp7UUCr2Ee4IjxtItgpLSDp5MOxYzXHFfxJ7JpmhzjQW8PKEmyIZyREYsxIlplEQ
	y8KhGISMors=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A5F024B1F;
	Mon, 13 Jun 2016 14:35:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 83A8824B1E;
	Mon, 13 Jun 2016 14:35:29 -0400 (EDT)
In-Reply-To: <5B90624A6DC7442C94B933A07F0CD08D@PhilipOakley> (Philip Oakley's
	message of "Sat, 11 Jun 2016 20:25:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9AAAB5F6-3195-11E6-ADA2-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297239>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
>> I do not think I agree.
>>
>> If you apriori know that you do want to hack on a project's code, then
>> forking at GitHub first and then cloning the copy would be OK.
>
> You've clipped my other point:
>
> -        One issue may be the different expectations of how the fork is
> -        created (it's only one click on the GitHub..)

Not really.  I said the same thing paraphrased:

    And at that point, you would create a publishing place, push into
    it, and tell others "Hey I did this interesting thing!".  That
    "create a publishing place" step could be just a one click at GitHub.

Anyway, let's step back a bit and agree that your local clone needs
to be told 4 pieces of information to help you in a triangular
workflow.  They are:

 * The URL of the "upstream";
 * The URL of the "publish" (aka "mine");
 * Your push should go to "publish" by default; and
 * Your pull should come from "upstream" by default.

Are we still on the same page, or have we already diverged?

If you start from a clone of "upstream", then the local clone
already knows two out of these four, namely, "The URL of the
'upstream' aka origin" and "Your pull should come from upstream by
default".  In order to go triangular, you still need to tell the
other two to your local clone, namely "There is another remote
called 'publish'" and "Your push should go to 'publish' not to
'origin'".

When you start by forking at GitHub and then cloning that fork,
would it make it easier to go triangular?  I do not think so.  The
local clone gives you (different) two out of these four, namely "The
URL of the 'publish' aka origin, which is your own fork" and "Your
push should go to 'publish'".  You still need to tell the other two,
"The URL of the 'upstream'" and "Your pull should come from
'upstream', not from 'origin'" to your local repository.

So I really do not see a point in arguing that "forking at GitHub is
easy with one click" favors "your local clone should start by
cloning your own fork".  Between starting from a clone of upstream
and starting from a clone of your own fork, it is the same amount of
work to go triangular even for people who fork before having any
clone locally, like you.

And I do not have to repeat myself that it is far more helpful to
give a recipe to go triangular starting from a clone of upstream for
people who first clone three similar projects to evaluate them,
discard two that do not suit their needs, and fork the best one, by
adding that fork as "publish" aka "mine", than giving a recipe to
start from a clone of one's own fork.

Having said that, there are indeed two interesting numbers we may
want to ask GitHub folks to help coming up with.  Take any popular
project with many public forks at GitHub, say rails with 13k forks.

 * How many "clone" from the upstream (i.e. rails/rails in this
   example) compared to 13k forks it has were made by the users?

   Many of them might be just following along (e.g. they want to
   build the tip of the tree that is ahead of any tagged released
   version), but there may be some among these local repositories
   cloned from upstream without forking that record their own
   commits.  These are the people who will benefit a version of the
   documentation under discussion if it describes how to start from
   a clone of upstream, then add your own fork as the publishing
   repository so that the user can use a triangular workflow.  I
   somehow suspect that there are a lot more than 13k (i.e. the
   number of public forks) of these people, but I do not think
   https://github.com/rails/rails page gives us the number.


 * What percentage of these 13k public forks are "empty forks",
   i.e. forked from the main project but has never been pushed into?

   It matters if the answer to this question is a non-trivial
   percentage.  It indicates that the owners of these forks did the
   "fork first and then clone from there", and had to do an extra
   work of adding the real upstream as another remote and set up to
   pull from there, if they wanted to just keep up to date; they
   would have been better off if they started by cloning the
   upstream first.
