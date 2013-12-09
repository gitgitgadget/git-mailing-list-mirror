From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Publishing "filtered branch repositories" - workflow / recommendations?
Date: Mon, 09 Dec 2013 15:56:29 -0800
Message-ID: <xmqqhaahvas2.fsf@gitster.dls.corp.google.com>
References: <CACPiFCJPq0fqOQrJD-8CHH405Xw61ZDynqqfN+_aZb3ZBgV2VA@mail.gmail.com>
	<52A0D199.1010403@web.de>
	<CACPiFCKHprB_oO_eXMYkey_CGbT7WOn5VDDjBdHbLRzcDpHnZw@mail.gmail.com>
	<52A0D9F5.3030101@web.de>
	<CACPiFCJ3mkOj=E+siideBpPfgS1tSicVQ46KqPK+Tha0DbkZHw@mail.gmail.com>
	<52A18F69.70002@web.de>
	<CACPiFCJ5hCPvRHB1knvMocN0XdHfSMpbZnqjf7yHAT4mMOSfzw@mail.gmail.com>
	<20131209225950.GG9606@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Dec 10 00:56:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqAgp-0003Gz-0D
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 00:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318Ab3LIX4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 18:56:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41875 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750912Ab3LIX4e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 18:56:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DC0559545;
	Mon,  9 Dec 2013 18:56:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ytQfsbjNoybYTnGmAsM/+MQjxM8=; b=g30Dpg
	5chgPAaNjq/z6UtnCTTd9osLid1Q2TPinGEv2BVUfl6ojDo+jwcTMUsqUkkGaCO0
	bUywYuUESBO8+efS6HYnU/TbYKbPSP4G2lbbx6fWpOtnyOMZ/Fv7WGrXVHls4YMx
	FLHI+FAZT4qqcX6kfMgQsP3JRHl63ULrq+B3A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RfYl3D/X9SPHmitVeoU4Hr4vJxLHZ1en
	Jhmff4KwYoNL5SJBCQOCZrrjUvLtHWAqpHuVYJWyZW8LpkD7fd7vE4LMq4KzZNDl
	R/OcrkBVGgE5mCvfb+czLBO+1iXd/rbBspdkyKDpO7LPCJp/X6r9TS0iBX388KH/
	vEmeNW2u2cs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D0FB59544;
	Mon,  9 Dec 2013 18:56:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BCA265953F;
	Mon,  9 Dec 2013 18:56:32 -0500 (EST)
In-Reply-To: <20131209225950.GG9606@sandbox-ub> (Heiko Voigt's message of
	"Mon, 9 Dec 2013 23:59:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 879BFE1A-612D-11E3-8FEA-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239124>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> On Fri, Dec 06, 2013 at 02:40:15PM -0500, Martin Langhoff wrote:
>> On Fri, Dec 6, 2013 at 3:48 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> > Right you are, we need tutorials for the most prominent use cases.
>> 
>> In the meantime, are there any hints? Emails on this list showing a
>> current "smart" workflow? Blog posts? Notes on a wiki?
>
> None that I know of mainly because we have not yet reached the goal we
> are aiming at. Maybe we should write something, A few points from
> $dayjob that come to my mind:
>
>   * A submodule commit is only allowed to be merged into master in a
>     superproject commit if it is merged into master (or a stable branch)
>     in the submodule. That way you ensure that any submodules commits
>     that are tracked in a superproject are contained in each other and
>     can be cleanly merged. (no rewinds, one commit contains the other)

I think this is closely related to Martin's list of wishes we
earlier saw in the thread: remind the user to push necessary
submodule tip before the top-level commit that needs that commit in
the submodule is pushed out.  Giving projects a way to implement
such a policy decision would be good, and having a default policy,
if we can find one that would be reasonable for any submodule users,
would be even better.  Would adding a generic pre-push hook at the
top-level sufficient for that kind of thing, I have to wonder.
