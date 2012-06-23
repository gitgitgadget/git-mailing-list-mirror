From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix formatting in git-config(1)
Date: Sat, 23 Jun 2012 11:27:28 -0700
Message-ID: <7vy5ndkhnz.fsf@alter.siamese.dyndns.org>
References: <m2vcil4n0w.fsf@igel.home>
 <7v4nq5twwg.fsf@alter.siamese.dyndns.org>
 <7v62ainbub.fsf@alter.siamese.dyndns.org> <m2y5neqwwj.fsf@linux-m68k.org>
 <7vbokala5e.fsf@alter.siamese.dyndns.org> <m2boka5i0a.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Jun 23 20:27:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiV3Y-0000k7-8Y
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 20:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590Ab2FWS1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jun 2012 14:27:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46882 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755305Ab2FWS1b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2012 14:27:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D96C93C4;
	Sat, 23 Jun 2012 14:27:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gYrhBi5azcaFoawvl3DjSVfkAOc=; b=HYtlT/
	awRzg4I7sQkC89Myu9WInWMwjVL3hWyTil4am0KwTJWQCpvdZ2n+pEfCWn/UML/k
	yz5LSsho125FidJr/w9y1HmyeuA5IM5pk1fub0lgoS1Qq3Z9/wZ9iPkXK42VEZCq
	UcVcPw2OjYn+K6+phJTJWOH5O6Sffyr8lLIvU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xS7mF0zXzfxVjic/+Xmv+OqUJ5Vopacv
	s5JtKPe63efTgMbbGM26FDtDYlbvqYWIDWzX7OwA/6zUXikHd8jaGyiWzHnp6A7s
	t7bysax+O+NTzTW2xqu00E/TuCzI47zU0RDxmG8ckWeU/GIoENte/AqCmvN3DOoE
	BrPP7NbixuM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8500293C2;
	Sat, 23 Jun 2012 14:27:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E48B93C1; Sat, 23 Jun 2012
 14:27:30 -0400 (EDT)
In-Reply-To: <m2boka5i0a.fsf@igel.home> (Andreas Schwab's message of "Sat, 23
 Jun 2012 14:29:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 177CB564-BD61-11E1-ADAA-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200503>

Andreas Schwab <schwab@linux-m68k.org> writes:

> I've now found out that this is a bug in the docbook-xsl stylesheets,
> updating to 1.77.1 fixed the formatting.

Thanks for digging!
