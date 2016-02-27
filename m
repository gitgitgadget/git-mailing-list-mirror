From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/22] Mark more strings for translation
Date: Sat, 27 Feb 2016 11:00:27 -0800
Message-ID: <xmqqoab2f06s.fsf@gitster.mtv.corp.google.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
	<xmqq7fhqhxal.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 20:00:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZk6V-0000P6-9i
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 20:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756709AbcB0TAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 14:00:31 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62730 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756657AbcB0TAa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 14:00:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AB9BD448F5;
	Sat, 27 Feb 2016 14:00:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j3VBNFokAZTRkhTzQZUSExUi1Zg=; b=mP7dO6
	NyNEeXU+YolZQoLGQCWWxGvp/fH3l6nH0RwWgCSrTQ4EBWgvtrIK7Qhx4MJvJwf2
	Vwb62jcKbd5+FtslI/Msx+vhI8+y4BN3gR1qE9IICRCjDN2wWscuRPES4ao6UD2f
	5fOIhH2bFNg1mlwxFnDcoonl77EquA2//1BeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kNfJ4O0S+7ks9/ox558R6WrWr+d4Hz97
	EC2wQu7J/gztrYryOh4OIZfE0zst8nbh0R8uBssbqaC/46dxI+IKqs0JG4T81tke
	DZSk2woC21mM9CLzJNWHNrNHe2WZnQN2bCTzybzD3abYyj+iRXIvaCCx4UjSYnqH
	kG3BCMvXWtU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A1906448F4;
	Sat, 27 Feb 2016 14:00:29 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1E62D448F3;
	Sat, 27 Feb 2016 14:00:29 -0500 (EST)
In-Reply-To: <xmqq7fhqhxal.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sat, 27 Feb 2016 09:34:42 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5E404DB6-DD84-11E5-87A3-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287722>

Junio C Hamano <gitster@pobox.com> writes:

> Thanks.  "A new string we added since v2.7.0 that is not marked for
> i18n" is a new i18n bug and "a string that used to be marked is not
> marked when the code was rewritten since v2.7.0" is an i18n
> regression, and we would want to "fix" both post -rc0 period.  The
> patches that touch new strings added since 1.7.x are exactly that ;-)

Oops, I meant 2.7.x here, not 1.7.x.

>> This series marks many strings for translation. It's a result of
>> looking for new strings between 1.7.2 and 'master', and sometimes
>> looking around touched files some more.

And I hope you meant 2.7.2 here, too.
