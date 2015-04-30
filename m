From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2015, #04; Mon, 27)
Date: Wed, 29 Apr 2015 18:35:39 -0700
Message-ID: <xmqqy4la2yac.fsf@gitster.dls.corp.google.com>
References: <xmqqr3r5uyqg.fsf@gitster.dls.corp.google.com>
	<CACsJy8BYhwcewEdix1WaAY+ukeTfwkLyrcimJ2K7Rgwh0E6EDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 03:35:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YndOE-0000rs-RJ
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 03:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbbD3Bfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 21:35:43 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58407 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750969AbbD3Bfl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 21:35:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C3334DC20;
	Wed, 29 Apr 2015 21:35:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=91JnVVo5o3cmIiYr9I274FNQdcY=; b=uGytZY
	zXEWWPBaQdJG+Zifjq9+NCextQCcqL8mF3PBVB/Ir3rcemUAEYYWQqOsiZm7eiR6
	rSbTo5RZ2xmWIdB36Bki9ayAtV0PsIGZA1yYr/c4KPqZfB0K519D1lpBybW3bhQ6
	ClpG4u9Eda9pjdgHJKThF9o9tOCp+X1/r22Zk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nXPgOOAiWxVanvyzobyF7tnsbDIkY8wP
	gIMb1kW/U5WAUQ4oFlyvnfdfnTXKOxcHQknmw5HouCXSf3BGsSfOUcQeZIYFA+Ug
	0KEADkv/ogbPDXr8T2OiSMr2zEXwHmHms0qBpViyjtP3RHeH4lVBZy5cpUjEhfjS
	IzU4VVE7UMs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 544734DC1E;
	Wed, 29 Apr 2015 21:35:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A48E84DC17;
	Wed, 29 Apr 2015 21:35:40 -0400 (EDT)
In-Reply-To: <CACsJy8BYhwcewEdix1WaAY+ukeTfwkLyrcimJ2K7Rgwh0E6EDQ@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 30 Apr 2015 08:07:00 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 35DCFF44-EED9-11E4-B42C-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268046>

Duy Nguyen <pclouds@gmail.com> writes:

>>  Waiting for a further polished reroll ($gmane/265534).
>
> I'm a little bit busy with other things, so please drop this for now.
> I'll resubmit when I address all the comments from the last round.

Thanks. I'll keep it until then ;-).
