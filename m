From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix many comment typos
Date: Sun, 03 Jun 2012 14:31:09 -0700
Message-ID: <7vk3zoxeua.fsf@alter.siamese.dyndns.org>
References: <8762baf8do.fsf@rho.meyering.net>
 <7vmx4lz5bm.fsf@alter.siamese.dyndns.org> <87396ceuoy.fsf@rho.meyering.net>
 <4FCB4E0A.5080107@lsrfire.ath.cx> <87wr3od02b.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Sun Jun 03 23:31:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbIOK-0004YM-EK
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 23:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754795Ab2FCVbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 17:31:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60533 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753731Ab2FCVbM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 17:31:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9017382C9;
	Sun,  3 Jun 2012 17:31:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V1CwwsyaFJCHrVSQSSOk5kwBOpU=; b=kn9sDh
	QtTlHSwMWQuPMIjTK2Ihu4m02bZ0OwBOrzjDM5YSiIf9ULh+o0m3PqDJK2tXebap
	qsIcd3CxoWizLFT7ftdatj7WSZ+3xfTU7Kr8/4uLTBm28YKRN6EBDcGRegHKwdr9
	MfCl6lJDxs5dnfWdTlf4Zz4voxn8IypZjtWsE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ezqm/SDUqZaMGYFyNAX1cQ4K2xFo8buj
	s/GkUOVUwA5mlLqD3/EWfUawmwLaC37Y7MqXhSyCbxki7PbsNhLtpms2Gd9JzkEf
	ZAIXqSnWDZvxJvQHaSzLn0/ZoxqWkyeOjPD7RG3+et5ffpUg/m4xi/01rzCYzCR8
	IuHKQvT100Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 858DE82C8;
	Sun,  3 Jun 2012 17:31:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D68082C6; Sun,  3 Jun 2012
 17:31:11 -0400 (EDT)
In-Reply-To: <87wr3od02b.fsf@rho.meyering.net> (Jim Meyering's message of
 "Sun, 03 Jun 2012 14:58:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 70405D48-ADC3-11E1-8196-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199104>

Jim Meyering <jim@meyering.net> writes:

> You're right.  Changing the RelNotes that way would not be useful.
> However, changing git-bisect.sh should make it easier for non-native
> English speakers to understand that obscure diagnostic.

Oh, there is no doubt about that.  Thanks for a clean-up effort.
