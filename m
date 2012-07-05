From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Can show relative date of the commit with future
 timestamp
Date: Thu, 05 Jul 2012 10:26:51 -0700
Message-ID: <7vy5myqftw.fsf@alter.siamese.dyndns.org>
References: <1341505087-13632-1-git-send-email-tomxue0126@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tom Xue <tomxue0126@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 05 19:27:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmppT-0004xt-6E
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 19:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296Ab2GER0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 13:26:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63508 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191Ab2GER0x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 13:26:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 911AB8CEA;
	Thu,  5 Jul 2012 13:26:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WGlXmgyLDZB4AwBsM/Lq+0QQnHA=; b=ae4BoO
	NgCqDqMeAdQAf8k/lhvVv5bXlcAQy6P4o5yUsa4a5sZgyIGVgn2v8I0l0CbKmEjf
	5a9D9EVYukz7olLgFXCdC/advibCYggh1o1lzl8u2zxjSK+Bm8xy219eqEy2/xDx
	/4GrauUZ7E9fhO8UdH1HBFVMQllIrMe+bkpfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KVf9VXevaTpLfFmoY4szNKYW8w6jm8Kc
	sBaubBLH8ccRTewasx+07AFac3wWkAxraziUf5nygK7WyavcMnJtbrmArPoQyJrL
	+FskZi3vQLE27Zim11vo2EQDohqrbdLoD/ZlQWS+2w2iYYomMiP6HvHkLR4/KJeo
	cnqKWagvM7w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87EC68CE9;
	Thu,  5 Jul 2012 13:26:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 220198CE8; Thu,  5 Jul 2012
 13:26:53 -0400 (EDT)
In-Reply-To: <1341505087-13632-1-git-send-email-tomxue0126@gmail.com> (Tom
 Xue's message of "Fri, 6 Jul 2012 00:18:07 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9CA19FF2-C6C6-11E1-AAFA-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201055>

Tom Xue <tomxue0126@gmail.com> writes:

> ---
>  date.c | 186 ++++++++++++++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 125 insertions(+), 61 deletions(-)

WHY?
