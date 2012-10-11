From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Patch v2 2/8] Shorten two over-long lines in
 git-bisect-lk2009.txt by removing some white-space
Date: Thu, 11 Oct 2012 12:07:41 -0700
Message-ID: <7vbog87rpe.fsf@alter.siamese.dyndns.org>
References: <1412437370.46782.1349975589890.JavaMail.ngmail@webmail22.arcor-online.net>
 <1813304588.46882.1349975881205.JavaMail.ngmail@webmail22.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, philipoakley@iee.org, peff@peff.net
To: Thomas Ackermann <th.acker66@arcor.de>
X-From: git-owner@vger.kernel.org Thu Oct 11 21:07:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMO6v-000074-DZ
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 21:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933337Ab2JKTHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 15:07:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58213 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933147Ab2JKTHo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 15:07:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9671182C4;
	Thu, 11 Oct 2012 15:07:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SD9EvuS53xQgJUlLBVJCWunDSWo=; b=UVSSQZ
	s3sfIshROq/MwHjjbYiFMWAtUoWnY5PzfZPuR3GVaUegBLnFMcEeLHu3sW8IYQAV
	KsMemwjTSXi8XO7jTk0EAP/hsPvj4iFPGg1NG2vhAqkZsT4Z/DDJFSDhhFSLmEgf
	En2tROtaCWsKsH6kBjfU5AoYFlcLLQN2VzdOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qbkmf0MUqFWLilKvBrXHZq75Gv9K34OJ
	nzjhi4OQKDVvJ3U3eypoMKvDHnMCCXgcsG46vGG1T+TMLl7J14TVkxQe5swBa4kY
	/6eRAmPDFlkU4KDAyADVtolfJ/lEoqeCw0l9SuFzdE+xe4BQDe8DrOpM0OuKiFnB
	yf6JBUdc7bE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 838DA82C3;
	Thu, 11 Oct 2012 15:07:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F3B5082C1; Thu, 11 Oct 2012
 15:07:42 -0400 (EDT)
In-Reply-To: <1813304588.46882.1349975881205.JavaMail.ngmail@webmail22.arcor-online.net>
 (Thomas Ackermann's message of "Thu, 11 Oct 2012 19:18:01 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EF1C3FC8-13D6-11E2-95C7-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207507>

Thomas Ackermann <th.acker66@arcor.de> writes:

> @@ -331,7 +331,7 @@ Date:   Sat May 3 11:59:44 2008 -0700
>  
>      Linux 2.6.26-rc1
>  
> -:100644 100644 5cf8258195331a4dbdddff08b8d68642638eea57 4492984efc09ab72ff6219a7bc21fb6a957c4cd5 M      Makefile
> +:100644 100644 5cf8258195331a4dbdddff08b8d68642638eea57 4492984efc09ab72ff6219a7bc21fb6a957c4cd5 M  Makefile
>  bisect run success
>  -------------

If you are redoing this as "more like a printed book for easier
reading", it might make more sense to shorten it like this:

    :100644 100644 5cf82581... 4492984e... M      Makefile
