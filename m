From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9] git on Mac OS and precomposed unicode
Date: Thu, 16 Aug 2012 20:26:31 -0700
Message-ID: <7v393mxkpk.fsf@alter.siamese.dyndns.org>
References: <201207081550.25850.tboegi@web.de> <5011AD4A.8060901@dewire.com>
 <7vhasu5dld.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 05:26:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2DCp-0003Na-Pc
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 05:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030547Ab2HQD0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 23:26:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60167 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933650Ab2HQD0d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 23:26:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58738817D;
	Thu, 16 Aug 2012 23:26:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fid/4XtITJm1i/XPSYtReT5T6aQ=; b=iNMBCu
	fryRIBVN9XyrmvgjA7SeQojt10fb8nXAt7v73Uz/HSTdnSrmTgcTUcG9C9jbInH/
	VM1tKWdWCyNEsfsYjKOIk0dQ5w4tkfgpLLapiZhMbKekWLy3dbKIdBesVADCgAc8
	Mxkqmyb8GjcBZGAfXnMi8f1f0RJOur8qi10X0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VWRy5x7xL4KF65fgCYLMt/Z3BzZsFdd4
	SUXguKaI+sVwxjs/vzBAyUVu3zwUH0Q/GYLxFvVbKGRqrf4BY2JxCJXovctp1UHI
	gnq3yWIgWMQSUGuJPNAyTJWD8kV4ren63sZ4ic/ZDtinbQgOY6bSe+xJv5FEzPQ+
	mM1zSfYbJ18=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46D79817C;
	Thu, 16 Aug 2012 23:26:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC73A817B; Thu, 16 Aug 2012
 23:26:32 -0400 (EDT)
In-Reply-To: <7vhasu5dld.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 26 Jul 2012 16:04:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 578312D6-E81B-11E1-9E70-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
>
>> Just a couple of nitpicks.
>
> Polishing is always good and better late than never, but for a topic
> that has long been graduated to 'master' already, it would be easier
> to review and discuss if it came as a patch form relative to the
> codebase _after_ the topic has been applied.

Mild ping for a possible follow-ups that didn't seem to have
happened...
