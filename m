From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default documented in "man git-push"?
Date: Wed, 03 Oct 2012 22:45:46 -0700
Message-ID: <7va9w23i45.fsf@alter.siamese.dyndns.org>
References: <CAN7QDoK4WCuRMu+KV6ACo9miR9_eFEE510J5PDiPk+BXLyQG9Q@mail.gmail.com>
 <CALkWK0mxLQNOE8kZUJrxYQMWXpzZW0uS+N2iGXxdRmCXTzYcBQ@mail.gmail.com>
 <CACsJy8B7Z4kVYax4igYQ-d8q6e+GrPL3UwzhHSYbJ5Qo0TiL-w@mail.gmail.com>
 <CALkWK0kKzt8ii-+O0zRM1JLenP+XKh-2Wv_v6zXkkcvTGQ2MQg@mail.gmail.com>
 <CACsJy8BB4WM1Lqz4yCGnGN2DV1Xsip3Qzh86ibBXwt2BnaNENA@mail.gmail.com>
 <CALkWK0=N0OwTyu1KDAKzM48ioevGtmMNgy5gfK2J78zSPx7CVA@mail.gmail.com>
 <CACsJy8APN-CdBZgLzuNWAa5ArR2gkcStY4GZ=79fU7sGT9pOMw@mail.gmail.com>
 <7vvcer4chm.fsf@alter.siamese.dyndns.org>
 <CACsJy8D5TCP+77NObD7Q58k6OKQhbZKU-i4tb2RX40xj5CPsgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 23:59:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtOk-0001DP-HN
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192Ab2JDFpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 01:45:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51274 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754354Ab2JDFpx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 01:45:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D1F15EA7;
	Thu,  4 Oct 2012 01:45:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pVgJLQNARawQ0GP7Jy7+cGrHVPA=; b=fXG0IG
	L59Qsi3R+tQJIdgtqzw4oRKNd0r/S9svWAwy6qy6URbgO0BGWNnFyAqZttIpGwpd
	i6YK+aPT7DctE03Ak8q+CgY6RPWhkvtCq1SWooAv3h8SAVBYj2aI++peIGjjYAsG
	v/03/Eacg0AeRBV5N4aJHKG5MgSQiF5iSszuM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iWBtNQ5l8dJO6rkJTcjKXheG18I5bNuS
	Bhaow9wnGvY16PPMGod98L2f1oxRz0XoIY9Vnu7e0bShc/cGa+BEViq1eQ9ioKKM
	Zh2uSD7uM5aYBaQYhpdevPlh19t9oce/fPkc3bhrp83EHSMpwAtTR/DpaHE+hRxE
	/rVlGYOalqs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17A625EA6;
	Thu,  4 Oct 2012 01:45:52 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EFCD95EA5; Thu,  4 Oct 2012
 01:45:50 -0400 (EDT)
In-Reply-To: <CACsJy8D5TCP+77NObD7Q58k6OKQhbZKU-i4tb2RX40xj5CPsgw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Thu, 4 Oct 2012 09:01:18 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C138EC3C-0DE6-11E2-8B03-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206948>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Thu, Oct 4, 2012 at 1:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> I would recommend against listing any advice.* in the command manual
>> pages.  They are meant to give an advice in cases that are often
>> confusing to new people and are supposed to advise how to turn it
>> off in the message.
>
> OK. I think I was surprised that some messages were controlled by
> advice.* but gave no hints about that and I found that out by other
> means. I'll check all the advice messages.

As far as I can tell,

    $ git grep -e 'advice\.' Documentation

shows the list in config.txt and nothing else, and they do talk
about when they are issued, but the reasoning behind them may not be
described to a sufficient degree (that is, unless a reader carefully
thinks things through, s/he may not be able to figure out why).  But
I think what we have there is more or less OK.
