From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach 'rebase -i' the command "amend"
Date: Sun, 04 Oct 2009 23:33:42 -0700
Message-ID: <7vocomfiyh.fsf@alter.siamese.dyndns.org>
References: <4AC8F22F.5070101@gmail.com>
 <alpine.DEB.1.00.0910042308200.4985@pacific.mpi-cbg.de>
 <6672d0160910042308v7280dcadyff97b977bcfe12c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: =?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 08:42:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuhHa-0002Xh-H2
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 08:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300AbZJEGee convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Oct 2009 02:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754210AbZJEGee
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 02:34:34 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44185 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937AbZJEGee convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2009 02:34:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8FC7E6BB06;
	Mon,  5 Oct 2009 02:33:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QiuT1sQt7pRd
	+vmPjGInR2OyoMI=; b=W9yTWDmPDqCSIviNebXgb6z9874OyR/YIIutDq2B9Dtk
	EOeTwTehZ43xmacyGmKta6fFs+uFIxwpTk8GLb3NWr8drtio5m6Et9EHaZG22Ucs
	MTSNBCPBJBHc9arO6GXpMLjcrahyvtJdRRKDltZMlAO/AGvia4Du5j736ZwKgnE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=iA0+pX
	3m8NO1OihYCv9VAOPRPJY/AnEM0i4dzgvXlNLbsrIWvNRYJhwSyULntgeLI+7JgR
	7GbxRnc+Va/Gh4qukI+tMoqOVQTTpZYyhBBKzh4wiEO2MQg8rQWHClO+jdsoLkGT
	2d77/whjx1r0FH/w+QGOMkO3JAwxcxY+Tsdzo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 679CD6BB05;
	Mon,  5 Oct 2009 02:33:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CECA96BB00; Mon,  5 Oct 2009
 02:33:43 -0400 (EDT)
In-Reply-To: <6672d0160910042308v7280dcadyff97b977bcfe12c3@mail.gmail.com>
 (=?utf-8?Q?=22Bj=C3=B6rn?= Gustavsson"'s message of "Mon\, 5 Oct 2009
 08\:08\:49 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0A8B9AB0-B179-11DE-9585-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129534>

Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com> writes:

> I found this thread from January 2009:
>
> http://thread.gmane.org/gmane.comp.version-control.git/105738
>
> Having read the thread, I agree that "amend" would be misleading.

Yeah, I thought "reword" might be a good command name back then.

Was the naming the only issue in the discussion there?
