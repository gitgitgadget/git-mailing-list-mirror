From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Anybody know a website with up-to-date git documentation?
Date: Wed, 30 Jan 2013 09:18:24 -0800
Message-ID: <7vlibalhcv.fsf@alter.siamese.dyndns.org>
References: <D6EAC791-63E2-4B0E-92AA-676112039BD9@quendi.de>
 <20130130115439.GH1342@serenity.lan>
 <71A3AA8C-DBA2-44F7-9B69-AEDB81BB0906@quendi.de>
 <CAMK1S_i+ML+HuTRuox5rU4bsV0+xoFLWpK63WrdXuzhgyHJbrA@mail.gmail.com>
 <6BE76AE4-254E-43DD-A3FF-88B5486029A5@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Jan 30 18:18:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0bJF-00041e-Lk
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 18:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505Ab3A3RSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 12:18:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34153 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754290Ab3A3RS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 12:18:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 901EBC853;
	Wed, 30 Jan 2013 12:18:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/3AR1zRGUcp5M0l/2a1dEGb8FJs=; b=Bh3cVJ
	juMzmuOLUbzz8cQuogcrCm7klb2OAJPCFgP8APXxq4zVk4HwD/gQAEVIhmVFRn9c
	HXcWwRF338kDfWTYdcyU5pv28P24IcWcLd6tkky12aiM+bw87FAutFgQzj5nFx3t
	w2amq3sBqet2fzXKwj5rlOdOqp+lnkOReUXTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O45vN7fr5BT4iHU1l/nKiD9cUO5cMC7V
	odNWihw31c3s5vOzWvq3DtzeER05dNF2vkRqUO+HK2rdUne34IZeJzQlU4dY/72j
	FlWr0ycyQQ2MUo+ogaudx1k1ob6WxXpyzXzyiS6lvBQcb2ZR8BBHsfMeAcktCG9Q
	ubCXe3JNSyM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84842C852;
	Wed, 30 Jan 2013 12:18:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E307CC851; Wed, 30 Jan 2013
 12:18:25 -0500 (EST)
In-Reply-To: <6BE76AE4-254E-43DD-A3FF-88B5486029A5@quendi.de> (Max Horn's
 message of "Wed, 30 Jan 2013 18:05:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0EA5632A-6B01-11E2-84D5-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215033>

Max Horn <max@quendi.de> writes:

[administrivia: please wrap lines to a reasonable width]

> On 30.01.2013, at 16:59, Sitaram Chamarty wrote:
>
>> I'm curious... what's wrong with 'git checkout html' from the git repo
>> and just browsing them using a web browser?
>
> Hm, do you mean "make html", perhaps? At least I couldn't figure
> out what "git checkout html" should do, but out of curiosity gave
> it a try and got an error...

Perhaps some information from "A note from the maintainer" (posted
to this list from time to time) is lacking.  Some excerpts:

    You can browse the HTML manual pages at:

            http://git-htmldocs.googlecode.com/git/git.html

    Preformatted documentation from the tip of the "master" branch can be
    found in:

            git://git.kernel.org/pub/scm/git/git-{htmldocs,manpages}.git/
            git://repo.or.cz/git-{htmldocs,manpages}.git/
            ...


Armed with that knowledge, I think Sitaram may have something like
this:

	[remote "htmldocs"]
		url = git://git.kernel.org/pub/scm/git/git-htmldocs.git/
		fetch = +refs/heads/master:refs/heads/html

and does

	git fetch htmldocs
        git checkout html

You can, too, of course ;-)
