From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-prompt.sh: shorter equal upstream branch name
Date: Tue, 07 Oct 2014 13:10:30 -0700
Message-ID: <xmqqiojvej49.fsf@gitster.dls.corp.google.com>
References: <1412091370-11727-1-git-send-email-jcarsique@nuxeo.com>
	<542B1623.2070109@bbn.com>
	<xmqq7g0krb2p.fsf@gitster.dls.corp.google.com>
	<542B7AF8.6080501@bbn.com>
	<xmqqppebptmj.fsf@gitster.dls.corp.google.com>
	<54340D63.8030507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Simon Oosthoek <s.oosthoek@xs4all.nl>,
	"Eduardo R. D'Avila" <erdavila@gmail.com>
To: Julien Carsique <julien.carsique@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 22:10:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xbb5o-0002AM-FQ
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 22:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777AbaJGUKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 16:10:34 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54347 "EHLO sasl.smtp.pobox.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753645AbaJGUKc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 16:10:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 00C8614891;
	Tue,  7 Oct 2014 16:10:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4jx/QEA8rPmrQHq4a+KDRDM1KO0=; b=XSdUUo
	lalDjEsgPkjqV7expcArizoOS0gbitpyCNvGXc0+mRNmcSkPNiZAYmmeUpA5KTxA
	1zGXdjtVJ6VnsQNJN5gYh9jS3GJa6FLzS+5TPiE2srfE/5rhLdMeGDrHerwd4C+R
	hmq4U32/dFXjpO4kL4hoq0GQra4U2+oVh7KBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YaMN2mVbEDIgetG2FEgAh+jrh0I/xEpA
	AMNSyr3s0yCmtNvUxpC31d2FWCYjbrM1jwSv3/VW95r2bZm9ufbuWKWeo4q3BLJR
	PU9Yj0wavTp6tb8Db9m+VIloMGiWAUT8qO0b4FQJQcwGNcRlBEDHVDZNcy/xuPgv
	vzb/+xXlWcc=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E83B114890;
	Tue,  7 Oct 2014 16:10:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 53C411488F;
	Tue,  7 Oct 2014 16:10:31 -0400 (EDT)
In-Reply-To: <54340D63.8030507@gmail.com> (Julien Carsique's message of "Tue,
	07 Oct 2014 17:57:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FD295F56-4E5D-11E4-AD5F-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257954>

Julien Carsique <julien.carsique@gmail.com> writes:

> Hi,
>
> Thank you both for your feedback!
> I'm looking at applying your requests:
> - add tests,
> - variable renaming,
> - use of local,
> - fix multiple issues on string parsing
> - avoid useless bash-isms? Did you agree on the ones I should remove?
>
> I'll send an updated patch asap. Tell me if I forgot something.

I just re-read the comments in the thread, and a few things look
missing:

 - git-svn?
 - conditionally enable this feature?

Other than that the above list looks like a fairly good one.

Thanks.
