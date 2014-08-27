From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/6] clean up author parsing
Date: Wed, 27 Aug 2014 10:36:20 -0700
Message-ID: <xmqqegw1esx7.fsf@gitster.dls.corp.google.com>
References: <20140827075503.GA19521@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 27 19:36:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMh99-0001yO-UF
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 19:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935138AbaH0Rgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 13:36:31 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50320 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933707AbaH0Rga (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 13:36:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 662963330C;
	Wed, 27 Aug 2014 13:36:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y/+PYE5HgU4CBOXSmcVIUIRHi3A=; b=Yf3Gn4
	7BSvyVCLwTEGU9voPXysBWoR2vI3ZVgOuIiqoQTrfULHCoOJJMeo1EqUHzt6YXIW
	H4Uffx1acnWsZaMuhJlF4Haft7z6OHPTMTbqWLElgNByq5TDA5Mk6xE5+kk/pLKF
	2BIMVazmLkLCWmK5szTpruTTiu/V2K0JCteDs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yiam/JssNVv+iXNEUmNcGRp82U5s8U8d
	r1YXl4InDwMwP6AcxgOdkDkOO6F293K+eanANLqgIMmfTZtnhxc5cV1m2jJhEXkB
	8zE6IuLxBx0wGPHvDIX9paAONnGonDU638BmRcVhkYKOJQYajXOzf5N0h04fTkEg
	9Li3JXuyues=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5B8083330B;
	Wed, 27 Aug 2014 13:36:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2077033307;
	Wed, 27 Aug 2014 13:36:22 -0400 (EDT)
In-Reply-To: <20140827075503.GA19521@peff.net> (Jeff King's message of "Wed,
	27 Aug 2014 03:55:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A939F774-2E10-11E4-BE23-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256015>

Overall it looked sensible, modulo a minor nit that may not matter
in the context of this series.  Will queue.
