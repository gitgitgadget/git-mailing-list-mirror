From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-rebase.txt: fix -f description to match actual git behavior.
Date: Mon, 18 Aug 2014 09:32:30 -0700
Message-ID: <xmqqtx59yd0h.fsf@gitster.dls.corp.google.com>
References: <87bnrq22uf.fsf@osv.gnss.ru>
	<xmqq4mxh5w34.fsf@gitster.dls.corp.google.com>
	<xmqqzjf94f5n.fsf@gitster.dls.corp.google.com>
	<87d2c22cnx.fsf@osv.gnss.ru>
	<xmqq38cx1w0e.fsf@gitster.dls.corp.google.com>
	<87ioltik7g.fsf@osv.gnss.ru>
	<xmqqioltza8z.fsf@gitster.dls.corp.google.com>
	<87ha1advqe.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergey Organov <sorganov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 18:33:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJPrs-0000bg-Jo
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 18:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbaHRQcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 12:32:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55429 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751835AbaHRQck (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 12:32:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D61F430B5B;
	Mon, 18 Aug 2014 12:32:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3jnePi3GCNESMpYZJu3zAaiSRFs=; b=cdXEzL
	KAnhy4s58WymgOEtWeA2yy0T0k4HDCMtrkB56uTNR0PDaYeR2Zr1rifbV2Ve7P7Q
	wu0RiLRFgkr6MWiJBdcK5wCrTpwcwAzkMxSWyipbrvdjYs3pKBA2MP/8LH9Se/LB
	5v7nHlIZi1h16iaUWTVsKzVOEs6Gmsreqs7vA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j+mf6O9KFkRRXfNCKdlPOFmElVm4DaG9
	lcJlzo++AT0c1XAGr4pjol9FzJffgDdT1C21/mAsyRL6v0vGlwWXcqYv62jUO34J
	67lcKM51czgyZqd4YlHr4nS4q6yEOhZ67N3b0j0ptQeXOhXHvczOuBed/Fy0xov5
	QHhX652/ToQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CB6F130B5A;
	Mon, 18 Aug 2014 12:32:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1E39A30B4E;
	Mon, 18 Aug 2014 12:32:32 -0400 (EDT)
In-Reply-To: <87ha1advqe.fsf@osv.gnss.ru> (Sergey Organov's message of "Mon,
	18 Aug 2014 12:53:45 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 40A4DD18-26F5-11E4-A199-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255395>

Sergey Organov <sorganov@gmail.com> writes:

>> (I rarely use preserve-merges myself, so I offhand do not know for
>> certain).
>
> I wonder, don't you yourself use preserve-merges because you don't care
> and just use the default, or because you actually use vanilla
> history-flattening feature?

The latter.
