From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/7] New remote-bzr remote helper
Date: Sun, 25 Nov 2012 20:09:34 -0800
Message-ID: <7v4nkdxawx.fsf@alter.siamese.dyndns.org>
References: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
 <CAMP44s2F9C4cr6v===M3AWHieaiUk1adigcU8txpZPL0wN81Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 05:09:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcq13-0001rr-MX
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 05:09:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753908Ab2KZEJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 23:09:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62812 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753702Ab2KZEJh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 23:09:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18F9D99DF;
	Sun, 25 Nov 2012 23:09:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lqho2CgXZBteVai4e5JoqtO0GEE=; b=KamKda
	uud4IBlwGi7lT0GqLOGKErzMd5/oemOtc6AZtvC+A5WbEzE0w4oRpT4/mSEGozTF
	v/MiPQ7NdQ0O6gpOR8opAkMA4WEaNeObhH4JX956KVYigiNMrbt/zBMPy/3N7DG9
	9SYCE1scXlhNAmlwAnKlPl5SvVMFxoIvMYMDs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UQsqsiB56r5QGFQI+6roEqzTfoAI0kMj
	qTo24ggM4N209w55lfOT8oU+T/ArvL0eU2MhqoYw9dM4znaVFrX8/KQmabt69gE3
	Y8YlccKV27fupYSKqD8UOPjQK6pXhHHPPV1kW1gKx/Be+1bbcH01APnqeE7FNysM
	Tpq60E7fRxk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0629599DE;
	Sun, 25 Nov 2012 23:09:37 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E51299DD; Sun, 25 Nov 2012
 23:09:36 -0500 (EST)
In-Reply-To: <CAMP44s2F9C4cr6v===M3AWHieaiUk1adigcU8txpZPL0wN81Ow@mail.gmail.com> (Felipe
 Contreras's message of "Sat, 24 Nov 2012 11:21:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 173A44D4-377F-11E2-BA53-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210406>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Sun, Nov 11, 2012 at 3:19 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> This is a re-roll of the previous series to add support to fetch and push
>> special modes, and refactor some related code.
>
> It seems this one got forgotten, I only see v2 in pu.

Oops; I think that was fell through the cracks during the maintainer
hand-off.  As the previous one has already been cooking in 'next'
for a week or so, I would appreciate if you send incremental updates
to fix or enhance what is in there.

Thanks.
