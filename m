From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce gc.autowarnonly config option
Date: Fri, 09 Mar 2012 11:35:55 -0800
Message-ID: <7veht15zz8.fsf@alter.siamese.dyndns.org>
References: <20111105140529.3A6CE9004A@inscatolati.net>
 <CAGdFq_g=+A7q7_ZkUYG6LZ+ehLBtMY+s+nJxhp4FVhUQ4Zo_rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fernando Vezzosi <buccia@repnz.net>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 20:36:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S65be-00011f-S2
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 20:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758910Ab2CITf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 14:35:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40677 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754662Ab2CITf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 14:35:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 115D76C5F;
	Fri,  9 Mar 2012 14:35:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZFkdZOhiQl55e9lztOgtRkg305I=; b=KUtVcT
	E2FN7qfaGI9qOx4mjvK4EQ3mqeGCg2Vp+XzbGjJV+7aWKzKImwJEdpZa7TqcWF43
	aqTPuZbehV097eU0jiLOy4oUtuUnVgG8mWtXG8SQ5xZ4Oc4ghF6vHMW8wwMinile
	xEslpDc+eKtzBi3I+j27Taz262g2t5hZYe6XM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ByJxrLunR9I4DgKHhEINW55W5iY9woLx
	rxXmsNvd7IEbWN/IPLoXtG6rEnEG5qKxhwsCVrsrf2bcFuO2YKKXjleplXOf1KxZ
	GQCd11NldTlwEksbL6x+4/YqlQh0ZJ789uxMvsgNa20Z6A6eXQ1D9TaQQi1e48aG
	XfRbX35l+88=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0762B6C5E;
	Fri,  9 Mar 2012 14:35:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7BB196C5D; Fri,  9 Mar 2012
 14:35:56 -0500 (EST)
In-Reply-To: <CAGdFq_g=+A7q7_ZkUYG6LZ+ehLBtMY+s+nJxhp4FVhUQ4Zo_rA@mail.gmail.com> (Sverre
 Rabbelier's message of "Fri, 9 Mar 2012 13:20:36 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 174C9054-6A1F-11E1-AADE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192737>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Sat, Nov 5, 2011 at 08:39, Fernando Vezzosi <buccia@repnz.net> wrote:
>> When `git gc --auto` would detect need for garbage collection to run, it
>> would just run. With this patch, enabling gc.autowarnonly will instead
>> make it just emit a warning.
>
> Does anyone know what happened to this patch?

If I recall correctly, it was pointed out that people who would get
annoyed by unexpected triggering of an auto gc would get annoyed by
constant nagging by this warning until they reach the point that
they can stop and run gc themselves, and the patch was never updated
to take that issue into account.
