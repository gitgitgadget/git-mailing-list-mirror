From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] Submodules: Add the new config option "ignore"
Date: Thu, 05 Aug 2010 16:27:30 -0700
Message-ID: <7vvd7obpy5.fsf@alter.siamese.dyndns.org>
References: <4C4DD33F.4020104@web.de> <4C4DD3CF.9070906@web.de>
 <7vhbjjware.fsf@alter.siamese.dyndns.org> <4C5B3D36.1060902@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Aug 06 01:27:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh9qk-0006JH-F5
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 01:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760830Ab0HEX1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 19:27:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59304 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759334Ab0HEX1k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 19:27:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 48166CA164;
	Thu,  5 Aug 2010 19:27:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zqZKoPn4s1qr5pnJ7uOMF2OxOWI=; b=kUOy4Z
	esi39M43Qx5ZyFXTu4qh9K8t9l4yQfh5FXHU5hdne4qQ1PJWtsLtztzL9+8xmQBb
	c6+QY22PHf0C8SVt0RMznDMlQ7dNfZ8H7U23BkoxhG1QvL/bpPjIZlysZOeA5cNI
	fGaqF8ZPjnRuRGHsYv9lGJWsM2LFCl3tu+xNo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uwy5AtNHNHPadtCOM6WTzen2hhpU6MBw
	2OO9luGFwhcCK5gks6XrT3Cpgc5UgP4cSBgq3sa8HlmnEstjQ5fvr+cA19Nv/k+U
	f6nV3Lqo5q1FlZDWW4/4yz7ABX2lYIOPl/KkauDwaNTT/gbvWzNuAAvbmcP1e7uz
	7NI22NAg1Ck=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 15803CA163;
	Thu,  5 Aug 2010 19:27:36 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 411FFCA162; Thu,  5 Aug
 2010 19:27:32 -0400 (EDT)
In-Reply-To: <4C5B3D36.1060902@web.de> (Jens Lehmann's message of "Fri\, 06
 Aug 2010 00\:37\:42 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 07A6E0BA-A0E9-11DF-B127-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152740>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 28.07.2010 23:35, schrieb Junio C Hamano:
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> 
>>> The .gitmodules file is parsed for "submodule.<name>.ignore" entries
>>> before looking for them in .git/config. Thus settings found in .git/config
>>> will override those from .gitmodules,...
>> 
>> Hmph.
>> 
>> The value of "submodule.<name>.path" does not have to be "<name>".  There
>> seems to be a bit of confusion here.
>
> Thanks for clearing up my confusion, this is v2 of this patch using the
> path configured for the submodule instead of its name.

Hmph, I thought that it would make more sense to use <name> so that once
the user configures ignore in .git/config, it will persist across moving
of the submodule in the superproject tree.  I wonder what others would
think.

Will queue, anyway.

Thanks.
