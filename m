From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rcs
Date: Wed, 06 Nov 2013 09:28:52 -0800
Message-ID: <xmqqy5518mnf.fsf@gitster.dls.corp.google.com>
References: <B49EE6A27F1B0642B4D12AD9C064E8C7B072E3@SOARCPRVSBEU000.regnet2.soar.ns>
	<20131029181614.GA13601@sigill.intra.peff.net>
	<B49EE6A27F1B0642B4D12AD9C064E8C7B072E5@SOARCPRVSBEU000.regnet2.soar.ns>
	<5279071B.2070309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"Hawkins\, Lisa M Mrs CTR USA USASOC-SOAR" 
	<lisa.hawkins1.ctr@soar.army.mil>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 06 18:29:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ve6ue-0000Pd-FS
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 18:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231Ab3KFR27 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Nov 2013 12:28:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48529 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755203Ab3KFR25 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Nov 2013 12:28:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF4364F12E;
	Wed,  6 Nov 2013 12:28:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QRhQx8bijz6+
	XwH+YbYXlKD3YgM=; b=ro646nrZrpLDymWaqRySviq9k74SBpuH8Rhyo0ge2sX3
	v93Wxl9qg5bwqnUhCeHw7A3Pv7ZaJSrzuYb0y6ii746rMIalxVhP/MVFOWrP63Ow
	td8qAl+CSmy54blI4QYS7QIfDV6TGxDQgeARiJBnTWOKBPg/DcCQxsEdU62SBls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ljWEcL
	haRaZXE23QZRyNb3HPsOWcc9rSlsVDPkDGUeLLHJnWCE2f9nSOZCq5HhsuCr4JZh
	Mue7q+riprxFasSMNYUBTrupkI4dNJ75PaeCtJ/52Lw8E6S/s2phdDoug096Doqy
	MWjhD1Y+Cy+QSQb9ceOYZM65ByqoRnL7/bKzI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E03B54F12D;
	Wed,  6 Nov 2013 12:28:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33A424F12C;
	Wed,  6 Nov 2013 12:28:56 -0500 (EST)
In-Reply-To: <5279071B.2070309@gmail.com> ("Jakub =?utf-8?Q?Nar=C4=99bski?=
 =?utf-8?Q?=22's?= message of "Tue,
	05 Nov 2013 15:56:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E9FC987E-4708-11E3-812C-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237359>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> Finnerty, James M Mr CTR USA USASOC-SOAR wrote
>> Jeff King [mailto:peff@peff.net]wrote:
>>> On Tue, Oct 29, 2013 at 11:35:21AM -0500, Finnerty, James M Mr CTR =
USA USASOC-SOAR wrote:
>>>
>>>> Hi. I'm going to attempt to import a git database into Razor which=
 is
>>>> linux rcs based. Does the linux version of git use rcs ?
>>>
>>> No, the formats are completely different, and you will have to tran=
slate.
>>> We don't usually get requests to go from git to rcs; it usually goe=
s
>>> the other way. :)
>
>>
>>    Thanks.  We have several systems using Razor right now. So we are
>> trying to get all the systems into one CM system. Razor is just a gu=
i
>> that uses rcs commands. Once we get everything synced we will explor=
e
>> our options for a complete development CM system.
>
> The problem with using RCS as sync (as base) is that it is least
> powerfull of VCS, and as far as I know do not offer place to store
> extra information, so conversion from Git to RSS will lose some
> information (committership, signed commits and signed merges, signed
> tags, etc.).

You forgot to mention another important one: atomicity of commits
across the entire tree.  The best you could do would be to assume
that changes in such a collection of RCS ,v files from a Git export
to different files with the same timestamp and by the same author
are likely to have come from the same Git commit, and that the
timestamp monotonically increases, in order to stitch the history
back together.
