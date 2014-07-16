From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 4/4] tag: support configuring --sort via .gitconfig
Date: Wed, 16 Jul 2014 14:40:54 -0700
Message-ID: <xmqq1ttlrnh5.fsf@gitster.dls.corp.google.com>
References: <1405467179-16064-1-git-send-email-jacob.e.keller@intel.com>
	<1405467179-16064-4-git-send-email-jacob.e.keller@intel.com>
	<20140715234240.GB5572@peff.net>
	<1405467974.2577.21.camel@jekeller-desk1.amr.corp.intel.com>
	<xmqqiomxrxq2.fsf@gitster.dls.corp.google.com>
	<1405545219.15392.17.camel@jekeller-desk1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	"peff\@peff.net" <peff@peff.net>
To: "Keller\, Jacob E" <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 23:41:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7Wwl-0005KG-Us
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 23:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbaGPVlD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 17:41:03 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61315 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751122AbaGPVlB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 17:41:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3C4CC2A09C;
	Wed, 16 Jul 2014 17:41:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GxgK5zvlC0TpCWYZEQFbFB9ucSs=; b=w1PKuX
	IWry0REi30ONcjX6tMyF3yR9X201tqnaaHYvVuaxqpCbtrGeHRGuGUOX4whVNc1V
	yeWBqBL7fWDMpGavwwpaN6Qga9ohfBYNd1cL96tKq/2hzjpaf13Vb1qkbV+obpDt
	T9wvvoIxDYPh8YHSimgWhsS6fyMgnq3AykTXw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JxME/mSFajtDTWUChM1KjmFdbA6fMKUL
	M7VSK+mxuNP0WjkmYifF8eXu+SQic8FC+bMOe4WKnA/6J5hqF6gvv5f5tfz4m/oS
	oL4tvQ65uF1aoBPE/LXWhn4LZ7uNWP4ZGIT+6AJu9HEIZlvoj4899U3Lbngy2X8l
	7CTbsKaCEno=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 29F972A09B;
	Wed, 16 Jul 2014 17:41:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7A5B62A097;
	Wed, 16 Jul 2014 17:40:55 -0400 (EDT)
In-Reply-To: <1405545219.15392.17.camel@jekeller-desk1.amr.corp.intel.com>
	(Jacob E. Keller's message of "Wed, 16 Jul 2014 21:13:39 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DDE2A124-0D31-11E4-8670-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253692>

"Keller, Jacob E" <jacob.e.keller@intel.com> writes:

>> After all, it seems to me that the one in
>> 
>>     http://thread.gmane.org/gmane.comp.version-control.git/253346
>> 
>> struck the right balance among various abuses; let's use the error
>> reporter from that version, instead of going down this rabbit hole.
>> 
>> Thanks.
>
> So is that patch series version acceptable then? Or should I spin one
> again that is in that vein?

I do not offhand know what other changes you had in v9 since
$gmane/253346, so I'll leave it up to you.  If the only difference
is the error reporting codepath, and you are happy with what I have
in my tree

    $ git log -p --reverse -3 a93d886b9

then we can proceed with that version.  Have there been any issues
raised on that older version other than error reporting?
