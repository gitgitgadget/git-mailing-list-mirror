From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] rebase: test ack
Date: Wed, 21 May 2014 11:30:26 -0700
Message-ID: <xmqqoayrougt.fsf@gitster.dls.corp.google.com>
References: <1400447743-18513-1-git-send-email-mst@redhat.com>
	<1400447743-18513-4-git-send-email-mst@redhat.com>
	<xmqq4n0lwizh.fsf@gitster.dls.corp.google.com>
	<20140520143850.GA13099@redhat.com>
	<xmqqvbt01o14.fsf@gitster.dls.corp.google.com>
	<20140521125246.GA21476@redhat.com>
	<xmqqioozqdgo.fsf@gitster.dls.corp.google.com>
	<20140521173950.GA24564@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed May 21 20:30:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnBHh-0005Hu-3I
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 20:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbaEUSac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 14:30:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61806 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751857AbaEUSac (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 14:30:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9C1FF18194;
	Wed, 21 May 2014 14:30:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=khCxYJElucMviiHP5CyBYInIzFc=; b=ERfRsB
	4Bk7MzKy5WXDGZc1xxadRgN/9w/jmZ4WfaJcXTf9aaZhF5HJ4NqD34H95kGME3FA
	KMdZy9nseI/C9Xro7Sda9dBPcZIjilkWVoUIxOyxsOqA6w2BTa355k6jz/jNL4VN
	172H5z4mrEdkDYmy7ithMSQS8n0PTNwg+CPqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E/q6XeGalaNGcSZuFNljdNOfpSrHEGCy
	JEC5zRDHhnbwzWZekNzBY1CDdrWyaZrez5yNqHKUgh+XYfqsG9KyrdsqRnYmv2s5
	YQALQ/wAw4DdZUCIMpB32gYPniS2klAyPgnBQeqpLLcM6vZ8W6pg0gHmgkUcBWNl
	8nLq68+9LWo=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9436C18193;
	Wed, 21 May 2014 14:30:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 412541818E;
	Wed, 21 May 2014 14:30:28 -0400 (EDT)
In-Reply-To: <20140521173950.GA24564@redhat.com> (Michael S. Tsirkin's message
	of "Wed, 21 May 2014 20:39:50 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FB96A924-E115-11E3-AA44-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249820>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Wed, May 21, 2014 at 09:54:47AM -0700, Junio C Hamano wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> 
>> > On Tue, May 20, 2014 at 08:13:27AM -0700, Junio C Hamano wrote:
>> >> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> >> 
>> >> > Just to clarify I can post v2 of 4/4 without reposting 1-3 since they
>> >> > are queued?
>> >> 
>> >> If you need to update anything queued only on 'pu' but not yet in
>> >> 'next', it is customary to ...
>> >
>> > Actually I don't see anything like it in pu.
>> ... 
> Oh sorry, didn't mean to try to pressure you. I was just surprised
> not to see it there. I know this applies cleanly to next so I'll just
> wait for 2.0 to be out.

Oh, no.  No pressure felt and no need to be sorry about anything.

I described a preferred procedure when the topic appeared in 'pu',
and I didn't answer your question for topics that are not even in
'pu' yet.

Being in 'pu' and not in 'next' is not much different from not being
in 'pu', so the preferred procedure is to send out the entire series
(unless it is a large 47-patch series ;-) to give everybody another
chance to comment, and it would be extra nice if you indicated which
ones are unchanged since the previous round to help those who did
already saw them.

Thanks.
