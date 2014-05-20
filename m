From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] rebase: test ack
Date: Tue, 20 May 2014 08:13:27 -0700
Message-ID: <xmqqvbt01o14.fsf@gitster.dls.corp.google.com>
References: <1400447743-18513-1-git-send-email-mst@redhat.com>
	<1400447743-18513-4-git-send-email-mst@redhat.com>
	<xmqq4n0lwizh.fsf@gitster.dls.corp.google.com>
	<20140520143850.GA13099@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue May 20 17:13:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmljV-0008LL-7N
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 17:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035AbaETPNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 11:13:33 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63854 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266AbaETPNd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 11:13:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7446517D5D;
	Tue, 20 May 2014 11:13:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UTKmfvThKpBH+Lu/CO6khP1S9G0=; b=hidMEB
	Ply7T7K93r1/WV2Vgt1CiDRyEocGj3WzKs+l+Kxs7Tl4qmpE3dqS1UpTZQayo5K8
	gXB0vVHSQDAG7SQCQWY4npMfNV0Q6YH+UZgwArBblRQuk8bV4Tr7XjLj2RI6HpYz
	nvDIuDk1oPzRmEozOwPla+3zfoKDTjwSi42Ok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JhcDyBrytz3k4gFI5Htidhz2ilS0iVZG
	6msHn971IoMVDITuoZM6PdkIWQ2RB4C2VeGUsSVvRMNDEdBX9AKdmMDvreP03w+f
	EVf2JSakdZIHHSCSCEYy7gMPT403uHv5Hn8d7feWxItd2Os8doxuf/Mr+Whnr5Sk
	izIsSIsZ1KU=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6C08317D5C;
	Tue, 20 May 2014 11:13:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5D75317D5A;
	Tue, 20 May 2014 11:13:29 -0400 (EDT)
In-Reply-To: <20140520143850.GA13099@redhat.com> (Michael S. Tsirkin's message
	of "Tue, 20 May 2014 17:38:50 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4C926894-E031-11E3-BB70-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249693>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Just to clarify I can post v2 of 4/4 without reposting 1-3 since they
> are queued?

If you need to update anything queued only on 'pu' but not yet in
'next', it is customary to resend the whole for everybody to see
(what is already in 'next' should only be built upon incrementally
and not updated with replacement patches), while noting which ones
are the same as before.  Christian Couder has been doing it nicely
in his recent rerolls (if the series were not in 'next', that is).

Thanks.
