From: Junio C Hamano <gitster@pobox.com>
Subject: Re: shell commands in ReleaseNotes
Date: Sat, 19 Sep 2009 15:30:04 -0700
Message-ID: <7veiq27ekz.fsf@alter.siamese.dyndns.org>
References: <200909192357.32369.Resul-Cetin@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Resul Cetin <Resul-Cetin@gmx.net>
X-From: git-owner@vger.kernel.org Sun Sep 20 00:30:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mp8Rh-0006vS-Vw
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 00:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968AbZISWaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Sep 2009 18:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbZISWaI
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Sep 2009 18:30:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58257 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbZISWaI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Sep 2009 18:30:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 147DF38EFF;
	Sat, 19 Sep 2009 18:30:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MrrZ04jpAo7ZuySx5dRPmT+muE0=; b=xW4pdz
	m0s6Qhhh+dVD4DDjWtAqzkwM+9Fkvf/zZwqQXLyeAAQ4L3xlQXZA4WUt46rq5Cem
	qMvlInCs4ps9m6+UWZsWR8Je1CgwmA7DK5rZzxDG9odA4mqQiSCPhjFFnLm75omZ
	SQpKg11rim7sBRdTYlfdIkuP8r+F2kUmpW0bs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mn+W6pUbBJlYg9dUIeGa7oi9p4c5Nr+2
	lAbET72gFkGRePIC6iZz3yunf6UP+D0M8bN7ym3XQm47+qv7PuhQW+aeQVeqH8SX
	MdwRmGMC2nJ7eZh+yc/L19Rcn/kIEg6HYjVLoZnzt5qpu46vqknhQW10lfyy2emR
	sElX+K4IVkw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ECC5D38EFD;
	Sat, 19 Sep 2009 18:30:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 69FE338EFC; Sat, 19 Sep
 2009 18:30:06 -0400 (EDT)
In-Reply-To: <200909192357.32369.Resul-Cetin@gmx.net> (Resul Cetin's message
 of "Sat\, 19 Sep 2009 23\:57\:32 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FCD1811E-A56B-11DE-A04C-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128829>

Resul Cetin <Resul-Cetin@gmx.net> writes:

> Real nice idea to create an overview about changes in a repository for writing 
> a releasenotes. But how is it real used by the maintainer?

Open the file, go to the beginning of the scriptlet and mark (\C-SP), go
to the end (\M->), feed it to shell (\M-| sh RET), open /var/tmp/1 and
read it over while cutting the updated definition of O=.

Everything done in Emacs, no need for any extra editor.
