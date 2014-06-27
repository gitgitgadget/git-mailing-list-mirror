From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: catch mkdtemp errors
Date: Fri, 27 Jun 2014 10:16:30 -0700
Message-ID: <xmqqmwcy2ryp.fsf@gitster.dls.corp.google.com>
References: <1403146394-9589-1-git-send-email-davvid@gmail.com>
	<xmqq4mz74cuv.fsf@gitster.dls.corp.google.com>
	<20140627065924.GB21103@iris.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Jun 27 19:16:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0ZlS-0004KA-8T
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 19:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbaF0RQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 13:16:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54518 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419AbaF0RQh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 13:16:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A39DF21E72;
	Fri, 27 Jun 2014 13:16:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s0gypsHW+Zo2t9cWMVKQc3O8HpU=; b=BolFej
	lkev4eMXADFJCs+EUWHnhcSMqhWvlOkkSPAbvQzTG4izrgZrINjoMdnEZna9/Xz5
	wR2QDwMBdTYX+j3MGZeCTUSC1eWLd/4uAv9Geha8qoWEJZVfSd+dFnspn4cEuQyf
	qfdesf9knffLrt79Vig6IVpN4UM1TmlMDWyy0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oWb1qusRM1G4ifa9fkVKC28hMwHUlkDI
	+TQBHrjYvk1mBKL3rXXnU7ZdcawwZhz4IyMPx45c/NtvFCEBrAxd2Js6z5Ysf6Te
	XzFpFaNF1SBdM5NmAph23hDHb9zngsVmL3oNNHpAO6Dgf1KpOyAVxGdwEX4F9W8o
	+5G3xhvZzTA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 95FD921E71;
	Fri, 27 Jun 2014 13:16:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4D09E21E67;
	Fri, 27 Jun 2014 13:16:23 -0400 (EDT)
In-Reply-To: <20140627065924.GB21103@iris.ozlabs.ibm.com> (Paul Mackerras's
	message of "Fri, 27 Jun 2014 16:59:24 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C3850C3A-FE1E-11E3-B870-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252562>

Paul Mackerras <paulus@samba.org> writes:

> On Thu, Jun 26, 2014 at 01:47:36PM -0700, Junio C Hamano wrote:
>> 
>> In the meantime, I've fetched from you and merged up to your
>> master~2 aka 17f9836c (gitk: Show staged submodules regardless of
>> ignore config, 2014-04-08).
>
> I have applied and pushed out this patch, along with one from Max
> Kirillov, so please do another fetch.

Thanks, will do.
