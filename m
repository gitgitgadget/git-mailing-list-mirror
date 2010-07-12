From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 13/13] some document update
Date: Mon, 12 Jul 2010 11:45:31 -0700
Message-ID: <7v1vb8bktw.fsf@alter.siamese.dyndns.org>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
 <1278829141-11900-13-git-send-email-struggleyb.nku@gmail.com>
 <m3hbk6l901.fsf@localhost.localdomain>
 <AANLkTinO9uLByOvUMRf4Y9vcne1jNAfPnvT3Dq0l4xa9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio Hamano <gitster@pobox.com>
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 20:45:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYO0l-0002uA-Hz
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 20:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756229Ab0GLSpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 14:45:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37182 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869Ab0GLSpn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 14:45:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B004AC352D;
	Mon, 12 Jul 2010 14:45:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kl3f5sEE0DLgtiSQPrjaq0v0R0g=; b=ii0Rou
	N/gO/FUjrhIaYLjn9sdMqyK/FiQZCv8VNFIjf/qx583Te7E3lRG0tDYWF/CCmbp8
	YUcGEzFZlu3AqbK6PRM2gB2UE9JFfToseqXa9L25Tjlfjm9ZEeI4Y6gDnmfmp0pq
	ePSQ5Ih5TPOHi9+R0DW7gZD5eH8DnK+7Bcqkw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aZcW6aHEAjnWHsW5QC60uKeD7LFdNzfd
	vfK08CKwGYUSyj0lpatuBat520wyOR1pLi6O6c7Pm3gpwS2cvaqUbO6we6ll2puX
	FbBFtNJIfoQks4iiduGZHlWmuhsN9EuTkHzRUfJHsL8ITyNIZ2MWypPzN4hTeycA
	hy7n0PIM21w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 78F3AC3529;
	Mon, 12 Jul 2010 14:45:38 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8476FC3525; Mon, 12 Jul
 2010 14:45:33 -0400 (EDT)
In-Reply-To: <AANLkTinO9uLByOvUMRf4Y9vcne1jNAfPnvT3Dq0l4xa9@mail.gmail.com>
 (Bo Yang's message of "Mon\, 12 Jul 2010 22\:12\:57 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AA0F8CD8-8DE5-11DF-AFF5-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150840>

Bo Yang <struggleyb.nku@gmail.com> writes:

> ...
> Thanks a lot for your advice, I have revised the patch.
>
> -----------------------------------------------------------
>>From 88ed88a53d83c2d46fa4917008efadc531ba1068 Mon Sep 17 00:00:00 2001
> From: Bo Yang <struggleyb.nku@gmail.com>
> Date: Sat, 26 Jun 2010 01:35:48 -0700
> Subject: [PATCH v3 revised 13/13] some document update
>
> Both 'git log' and 'git blame' support the same
> format of '-L' arguments, so put the argument
> format description into a new file.
>
> Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
> ---
>  Documentation/blame-options.txt     |   19 +------------------
>  Documentation/git-log.txt           |   13 +++++++++++++
>  Documentation/line-range-format.txt |   18 ++++++++++++++++++
>  3 files changed, 32 insertions(+), 18 deletions(-)

Every time you do this, you seem to send a corrupt patch, like...

> @@ -19,6 +20,9 @@ command to control what is shown and how, and
> options applicable to
> ...
> diff --git a/Documentation/line-range-format.txt
> b/Documentation/line-range-format.txt

Please don't.
