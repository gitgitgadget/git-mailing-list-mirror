From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/5] nd/branch-show-rebase-bisect-state updates
Date: Wed, 20 Mar 2013 07:37:26 -0700
Message-ID: <7vfvzqgms9.fsf@alter.siamese.dyndns.org>
References: <1362572482-20570-1-git-send-email-pclouds@gmail.com>
 <1363174973-17597-1-git-send-email-pclouds@gmail.com>
 <7vhak7i6ch.fsf@alter.siamese.dyndns.org>
 <CACsJy8C93OOLWW2tdh17XA1k3Zs_kUjyZ32v4Ywk2BK83BL3wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 15:37:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIK9M-0005Pk-FR
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 15:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755873Ab3CTOh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 10:37:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41186 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239Ab3CTOh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 10:37:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B15A99A4;
	Wed, 20 Mar 2013 10:37:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rdbrcVsGLTZ9Gi0jepBJdJmOWZo=; b=IWiOaf
	suiQ+UaFLoiln4P7W0N4PFMPie0GpeILjb5in5GSpO0pR0Cwd08oMtpqLEFFVmc+
	DU3pwpMBnQYv7KQm8D5lPDn3bbBGjT6j3hNYp7VxFV89PZnnmEh13CxGw67bjJ1u
	4+sBRZz8hVqjuAqLLRIZtlL7l0XC7Bbnv1Ahg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wx08GS6rPZ7vSdPLx1tfWNxIVQd+hJZR
	4H++SH8tFdeMklYJaNq874iVN8KiYsH8fgjxyt1OEb/dtDMI41EYRX9ykfBAoLUQ
	tT5Xt7jXFal1sUY3PX2ox+ocCWC35RFHiDkYrn5ajmy1a9zgS5mmvUxSQL5PuOzG
	PJYV76m7YuE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5028599A3;
	Wed, 20 Mar 2013 10:37:28 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6D0E99A1; Wed, 20 Mar 2013
 10:37:27 -0400 (EDT)
In-Reply-To: <CACsJy8C93OOLWW2tdh17XA1k3Zs_kUjyZ32v4Ywk2BK83BL3wQ@mail.gmail.com> (Duy
 Nguyen's message of "Wed, 20 Mar 2013 19:40:49 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B02983D0-916B-11E2-8B03-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218610>

Duy Nguyen <pclouds@gmail.com> writes:

>> I think the message should better say "before you started to bisect
>> you were on 'jch'" or something instead.
>
> How about
>
> * (no branch, bisect started on jch)
>
> then?

Sure.

What you are showing is used only to decide where "git bisect reset"
goes to, I think.
