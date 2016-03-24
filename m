From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD] minor frustration in 'git add' pathname completion
Date: Thu, 24 Mar 2016 15:06:37 -0700
Message-ID: <xmqqbn637cpe.fsf@gitster.mtv.corp.google.com>
References: <xmqqr3ez7dqw.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaUPf=kBCuH__8BahjM3WjSGaijiQr05pMKe+TNdg3W9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 23:06:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajDOv-0006fB-Ac
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 23:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbcCXWGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 18:06:41 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:63833 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750916AbcCXWGk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 18:06:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 853D14D5AF;
	Thu, 24 Mar 2016 18:06:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mMIAwjJrgV4ouxhEW8oTImIL/RM=; b=xA/s8x
	HtS9VkJQetSqeCPL4SK+BrBdB9UAqTaQ4DeSiGUUy0pNxrT6VlFTxLD1O0EceRUo
	tFmzVTz+rVNDX7NvrIGXEe0eInmzYLQf6KP/nJ7CZHcFk00TZ4PavUCE+vbyLS8U
	8JGLOOlEkLjWKDDt3WhPjcbtUyuJ3g3NpLFMo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iI3GM7hJWNkln+JNosYqeggwLbSmlMze
	nYSj4dmXwGt3MeutrAaCKeQsrK+3eYyRYqhfpc0ZfpZII7cBW/o2SXVUoD9olQdV
	fWw/OLiTDVYZ3BvjojSDFXm7sMoaoE7Nb8QlCCLELhuOS5KESuzboxzSgHPcPn4W
	ewUuBl39YyY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7E4B44D5AD;
	Thu, 24 Mar 2016 18:06:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EF7C24D5AC;
	Thu, 24 Mar 2016 18:06:38 -0400 (EDT)
In-Reply-To: <CAGZ79kaUPf=kBCuH__8BahjM3WjSGaijiQr05pMKe+TNdg3W9w@mail.gmail.com>
	(Stefan Beller's message of "Thu, 24 Mar 2016 14:56:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AEBED360-F20C-11E5-9BCB-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289810>

Stefan Beller <sbeller@google.com> writes:

> On Thu, Mar 24, 2016 at 2:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Discuss.
>
>> For example, I keep
>> a backup version of whats-cooking.txt in the working tree that I use
>> to manage the 'todo' branch as whats-cooking.txt+, and this is not
>> explicitly "ignored".
>
> Completely side tracking thought: Have you considered ignoring
> whats-cooking.txt+ locally?

The point is that I shouldn't have to.  I wasn't asking for a
workaround.
