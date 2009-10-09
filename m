From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] perl/Makefile.PL: detect MakeMaker versions
 incompatible with DESTDIR
Date: Thu, 08 Oct 2009 23:51:19 -0700
Message-ID: <7vljjl5ac8.fsf@alter.siamese.dyndns.org>
References: <7wQSYSBJPoVtvyGI0lqsDW37w4byCpgpMaHiDKALwW_oJ9nHXddX9OBMnqXGZBVAo2U7Tc1BMxg@cipher.nrlssc.navy.mil> <FE_WTi0YAHrCrSdGFemlb7ALatFkdSu5V7Yfb5CUgyoxfv3ZFXdFABKbT1boP7aeGWli-gJPcBA@cipher.nrlssc.navy.mil> <4ACDE76C.4040307@viscovery.net> <unyNhuV9VB06SYvOR8ONK47yVKPtJfgRVKs-sKMFc-8rKMQBz7DPnw@cipher.nrlssc.navy.mil> <F3v6_n7wtTFWz8nzE5EpqB8ZsobXLax0nn_ghA5foHOvOJEMjHl0Qw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, gitster@pobox.com,
	git@vger.kernel.org, c@gryning.com,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Oct 09 08:56:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw9P2-0007Wp-3w
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 08:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932928AbZJIGwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 02:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932749AbZJIGwQ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 02:52:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48863 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932730AbZJIGwP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 02:52:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 58FE870470;
	Fri,  9 Oct 2009 02:51:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FR3GST3RpXri6e1qOz2Ogx9GyrI=; b=mRKLt1
	6COJcR6fN+bGX881clup6K5y5rn2ySpbcymqo4hWDsKUjrp07j1IYI6hkq2DBSJu
	f3LxIhs3ZHWkd3IzJfT+E/hgD9MkAJuM/d8RUHdzm2ozAGOcg/SqwjA3goknmY/c
	lOYUxf/qNWwN23Jx0mBa3/pJoNBOEPZV9eGf0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qPs5zuUGlrx6ec2LuzRwJFgUXl5q3Dwh
	0lcgIqiHfzNJYtKbawLJvDe3hvEgTKYkkqUc0TZsMEzV9+eUGiX6sdxC8vcM595S
	FwvgdplKJPZvXADsPBjaVOI8tjBdqKFm7GDkA3pyPoeDWsKAeZkSoxj2RgmGTcIl
	psEl/ktdeYo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 169CA7046F;
	Fri,  9 Oct 2009 02:51:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3B1707046E; Fri,  9 Oct 2009
 02:51:20 -0400 (EDT)
In-Reply-To: <F3v6_n7wtTFWz8nzE5EpqB8ZsobXLax0nn_ghA5foHOvOJEMjHl0Qw@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Thu\, 08 Oct 2009 11\:58\:57 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2BCFC5F0-B4A0-11DE-8D60-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129744>

Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil> writes:

> I think we're safe.

Thanks.
