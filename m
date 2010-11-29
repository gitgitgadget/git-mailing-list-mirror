From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv7.1 3/4 (amend)] gitweb: File based caching layer (from
 git.kernel.org)
Date: Mon, 29 Nov 2010 14:13:36 -0800
Message-ID: <7vvd3fzskv.fsf@alter.siamese.dyndns.org>
References: <201010311021.55917.jnareb@gmail.com>
 <201011130056.24222.jnareb@gmail.com> <201011281223.03141.jnareb@gmail.com>
 <201011281231.46786.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 23:14:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNByz-00086R-5P
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 23:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605Ab0K2WN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 17:13:56 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53065 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457Ab0K2WNz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 17:13:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6BA48385B;
	Mon, 29 Nov 2010 17:14:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BbQZZxtfEzws3/VE0i7GOohZGB0=; b=GPTbnt
	ZSCbEKpaPtZaGdvmq0UAZRQjc+lI9dEvO/tfNyL4b8gytgCA5MOyyqkp00jp+lnL
	Sk1GunjGq8brSJorQUNLr73Wmqz2f5TWCrdihmz+EC/jK6+EM6lzn3HaKBrF95uM
	jZgaY+FVxbva30RMhze8InHfSkBT2Cvxvvx+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PTZkSVcmztABHx6rm0jhiYtjE7BLwCxV
	rzMHLhGpWhGWGO6OncN+1m6CRiaeoxM8F5/HUjaJ5U4nJ0bQYsZ759keY3bVUzqS
	Vh0oBFjJDXw0zlRQIjpvXrfAOTCbmVCBQR/C0X/Ii53HkvRYYn8EdwXAUQrCT5HE
	n98xPCcm4R8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0D3233858;
	Mon, 29 Nov 2010 17:14:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DF8DE3854; Mon, 29 Nov 2010
 17:13:55 -0500 (EST)
In-Reply-To: <201011281231.46786.jnareb@gmail.com> (Jakub Narebski's message
 of "Sun\, 28 Nov 2010 12\:31\:46 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F9C7DE04-FC05-11DF-8CE7-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162433>

Jakub Narebski <jnareb@gmail.com> writes:

>> I have made mistake with this line when moving $caching_enabled check
>> out of cache_fetch to its caller.
>> 
>> Reusing $fullhashpath variable as a *capture buffer* (it has nothing
>> to do with path; it is not a filename no longer) wouldn't help there.
>
> Errr... I meant that this abuse didn't help avoiding my mistake.

Thanks.
