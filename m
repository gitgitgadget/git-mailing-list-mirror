From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] git help: group common commands by theme
Date: Fri, 08 May 2015 11:58:50 -0700
Message-ID: <xmqqh9rmlwut.fsf@gitster.dls.corp.google.com>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>
	<554B30D5.3050909@emmajane.net> <554CFEC3.5030105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Emma Jane Hogbin Westby <emma.westby@gmail.com>,
	git@vger.kernel.org
To: =?utf-8?Q?S=C3=A9bastien?= Guimmara <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 08 20:59:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqnUA-00044I-1d
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 20:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076AbbEHS6x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 May 2015 14:58:53 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50747 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752755AbbEHS6w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 May 2015 14:58:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BF4B4E354;
	Fri,  8 May 2015 14:58:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3SEkkFKdKavN
	ZGALmCSv2GZfYLM=; b=hpHjni3VULch9Yl5jaefxLoI+CTSXvZlalmD/bVS4td2
	lefh8aKThXiCqwuXaLLgwQhL6VR+et/il0myVyWBnRqvnL901IpsOHB3LkDGO7pz
	geDm2Chlpu/gwsea0I0mZNshoa3P+yctZWRGtzO3lzS2MQE0ciPj1DlI51VhdSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Ni5qwS
	oS+5/QelanQJ0kwUW1fX/LE8QGmnd5/ApuB1vodvAphU29n3nUcGu6/WzrgRiekn
	RGY3BskEmujmrIZ3iZlPjXRgeZkB40sV9U/qsNEFUvZMox30hjRkDHJd8A7eLEK2
	p9FD17K01Z3ly6I+eRTWzPcOsOvHZE+cEJ5Qs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 139C84E353;
	Fri,  8 May 2015 14:58:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8C8B94E351;
	Fri,  8 May 2015 14:58:51 -0400 (EDT)
In-Reply-To: <554CFEC3.5030105@gmail.com> (=?utf-8?Q?=22S=C3=A9bastien?=
 Guimmara"'s message of
	"Fri, 08 May 2015 20:21:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 443F93B2-F5B4-11E4-877B-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268646>

S=C3=A9bastien Guimmara  <sebastien.guimmara@gmail.com> writes:

> On 05/07/2015 11:31 AM, Emma Jane Hogbin Westby wrote:
>
>>> The most commonly used git commands are:
>>>
>>>     * starting a working area:
>>>        clone      Clone a repository into a new directory
>>>        init       Create an empty Git repository or reinitialize [.=
=2E.]
>>>
>>>     * working on the current change:
>>>        add        Add file contents to the index
>>>        reset      Reset current HEAD to the specified state
>> I could not live without status at this stage, and status always tel=
ls
>> me what I should do next. I'm tempted to see it up here instead...
>
> The layout was not designed to be workflow oriented (even if it appea=
rs
> so), but rather theme oriented.

I tend to agree with Emma here; even if your original ordering was
not using the workflow as the grouping criterion, that is something
that can easily be fixed, I would think.

After all, the very original did not categorize and sorted
alphabetically, so there is no room for the "we chose to be
theme-oriented (I am not sure what it means, though) and a major
redesign at this point will confuse users" kind of resistance to
come into the picture.  At least not yet.

Thanks.
