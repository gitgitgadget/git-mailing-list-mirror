From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Some small fixes to glossary-content.txt
Date: Tue, 02 Apr 2013 08:48:30 -0700
Message-ID: <7vbo9xgchd.fsf@alter.siamese.dyndns.org>
References: <1481339149.727628.1364894663266.JavaMail.ngmail@webmail14.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Tue Apr 02 17:49:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN3SK-0007o8-Fc
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 17:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932716Ab3DBPse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 11:48:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35427 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760542Ab3DBPsc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 11:48:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58FA712484;
	Tue,  2 Apr 2013 15:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2qj9iBL23zpJQ40AM17iS2FBVeQ=; b=B4Uv34
	8fjQt6nZiwBvkINK5LL9R/7Ra66H75egPiLSt93/G0D2LmCESfBJ7d9AZj8ERxIz
	5mrgEECCNbnQsXrS+fTwvkM5SZdCPmE8P8x/hwfy0yhelKUko3D5u9AyXAVonU2f
	7qGlxMP2+kiMQWWP1iAp7qtbILCXl9nUT4a0k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KLu4P7w/ThJfv/SPJ6OMDZwGXvK8sn9Z
	IhLfPujYy/xRUQ+7mBAiVQsm75t7DYuGUDyVGoJyLIsu7LYZRTOLER1ML6tLuWD+
	6TsPL5I0yGoAC8EVbAI34lIylvx0oDNDnUIAjJMU3FdQiFnsOj2/RIYzKS3fWMYr
	2v/a1+ogvR8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50F8212483;
	Tue,  2 Apr 2013 15:48:32 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8F9212481; Tue,  2 Apr
 2013 15:48:31 +0000 (UTC)
In-Reply-To: <1481339149.727628.1364894663266.JavaMail.ngmail@webmail14.arcor-online.net>
 (Thomas Ackermann's message of "Tue, 2 Apr 2013 11:24:23 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C51E050E-9BAC-11E2-A45F-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219783>

Thomas Ackermann <th.acker@arcor.de> writes:

> While proof-reading the user-manual I noticed some issues with glossary-content.txt:
>
> - There is some outdated, misleading or irrelevant information which might only confuse
> new Git users and should therefore be removed.
> - The entries for object, object name and SHA1 lacked a little bit of consistency.
> - The glossary contains partial definitions for refspec and pathspec.

Only on the "partial" bit, and not limited to refspec and pathspec.

I think ideally for any key concepts:

 - The glossary should mention what it is and what it is used for;

 - Individual manual pages should mention how it is constructed and
   how it can be used.  To be complete, it may need to start by
   describing what it is and what it is used for, which may have to
   duplicate what we say in the glossary.
