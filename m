From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Want to do some cleanups in this round of l10n
Date: Thu, 23 Jan 2014 09:26:46 -0800
Message-ID: <xmqqppnivcbt.fsf@gitster.dls.corp.google.com>
References: <CANYiYbFJFaM=RgoSv1H8_av-D4e40c0viEXPBokGRvYNjjFhzg@mail.gmail.com>
	<1390044238.17519.6.camel@localhost.localdomain>
	<CANYiYbG-_S1d+dE03K-q5JOn4So7Ory7R+osz284=JGnd-ZC0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-2022-jp?B?QWxleGFuZGVyIFNob3BvdiAoGyRCJyEnXSdWJ1wnYydRJ18bKEI=?=
	 =?iso-2022-jp?B?GyRCJ1UnbCdiGyhCIBskQic6J2AnYSdgJ1MbKEIp?= 
	<lists@kambanaria.org>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 18:27:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6O3O-0007f6-N8
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 18:26:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154AbaAWR0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 12:26:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37355 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753230AbaAWR0y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 12:26:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C3A764696;
	Thu, 23 Jan 2014 12:26:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1AKs4URDv3tih92TuKzJ97mQZUs=; b=qfbW8S
	qgOGW5ZJjZgRBEGllM+ujNfOaQ7oSCLcgx2dWOPzV2Zg4rl/7M89mW+RetuKfSWs
	EEp26UzcYxJ/PmHU6DnpS469OcKEdSr1lULmU/1niHg2mNqjwo0DpLTMqJEm0MxZ
	Abxea1CchL9TbFFWbFZyLYbjINmPp2GKeePY0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rWcFDz/PdDNSSDtYr68icxA9BlC0n5hd
	FzQHiMuPRPaFdighiGiCdvCL0cgdkG9aVnoQK51J0byITemxatinfh0R/iJMggeu
	jbjvf7ezeNIvsMe2QbK0mA1vpI+1mx9IC7JF7LdOg163qlz/75NmZ6pl0j8+Ix7n
	0ZasNKE9Afk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 198E864695;
	Thu, 23 Jan 2014 12:26:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E5F456468E;
	Thu, 23 Jan 2014 12:26:51 -0500 (EST)
In-Reply-To: <CANYiYbG-_S1d+dE03K-q5JOn4So7Ory7R+osz284=JGnd-ZC0A@mail.gmail.com>
	(Jiang Xin's message of "Sat, 18 Jan 2014 19:59:46 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8C22EB76-8453-11E3-B274-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240921>

Jiang Xin <worldhello.net@gmail.com> writes:

> Maybe three weeks left. You can estimate it by checking the date
> for history tags, such as v1.8.5-rc0 and v1.8.5-rc3.
>
>     v1.8.5-rc0: Wed Oct 30 12:17:56 2013 -0700
>     v1.8.5-rc3: Wed Nov 20 11:27:39 2013 -0800
>     v1.8.5: Wed Nov 27 12:14:52 2013 -0800

Or please consult <https://tinyurl.com/gitcal>

> Yes, fuzz messages are not included. I double checked the history
> of da.po and nl.po, and I'm sure there are no further updates since
> their maintainers sent me Email like "Hi, add me as the maintainer
> for that language, and I will send translations latter..."
>
> Remove them can make the Git package smaller and give
> opportunities to other contributors.

Yeah, I think removing them is sane and fine.
