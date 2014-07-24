From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jul 2014, #04; Tue, 22)
Date: Thu, 24 Jul 2014 15:45:48 -0700
Message-ID: <xmqqvbqm74v7.fsf@gitster.dls.corp.google.com>
References: <xmqq4my9f4qw.fsf@gitster.dls.corp.google.com>
	<B6FB0C239E6E4E2489FAB9EF1C902988@PhilipOakley>
	<xmqqegxcdjzl.fsf@gitster.dls.corp.google.com>
	<7ACC0F5AD23E4C839D2F819B23DA9564@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Jul 25 00:46:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XARlx-0002P2-3h
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 00:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbaGXWp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 18:45:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54810 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751638AbaGXWp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 18:45:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4BC292BCD4;
	Thu, 24 Jul 2014 18:45:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5WP5ginU+/1pFo7uBCoDpnppOjQ=; b=TV+cAY
	LHwChwJ4LGuXZOtPY+Y6ORNAlnU3b/ccAM7FmZQL/d+pkvSUTh7Hd7LXwPaG9lIC
	+ShjGsjzey4RTLCr0oWkKQz4oufEOAzLAI+pm4/cKeKh3Er7eklZzIpVCgBaYdsW
	VnfIUN2fm2lnG86F4gNTPqjjF+0wW0joEQDUk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aeJNMuassz3pj4NSX3S/JUeBs35anorc
	zye9Cm9CVjLrw0zBs6Rj582qH0f8i1U9DHBS6w98Wg0qw0ix6VbyCkucNxPWkyPz
	Ncr3jX3eH/1E9fCIIUDkxYAkLy7fZFxukvKyHfkVKpuRKdzYTMpKsvvcMMyPqLMT
	trf1034+DAs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 410AC2BCD2;
	Thu, 24 Jul 2014 18:45:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4D50C2BCC6;
	Thu, 24 Jul 2014 18:45:50 -0400 (EDT)
In-Reply-To: <7ACC0F5AD23E4C839D2F819B23DA9564@PhilipOakley> (Philip Oakley's
	message of "Thu, 24 Jul 2014 23:37:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 42AE0118-1384-11E4-8A66-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254192>

"Philip Oakley" <philipoakley@iee.org> writes:

>> which still makes me feel hesitant to promote this
>> document without updating its contents, though.
>>
>
> I hadn't viewed it as a 'promotion', rather it was simply ensuring
> access to the guide via the help system, instead of leaving it
> somewhat hidden.

Stale or incorrect pieces of advice that are hidden will not harm
(non-)readers.  Making them more available would mean giving them
more chances to do harm ;-).
