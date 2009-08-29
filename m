From: Junio C Hamano <gitster@pobox.com>
Subject: Re: vc in emacs problem with git
Date: Sat, 29 Aug 2009 11:41:24 -0700
Message-ID: <7viqg65up7.fsf@alter.siamese.dyndns.org>
References: <f46c52560908270828o574c0de6s17189a7326a1376d@mail.gmail.com>
 <f46c52560908270914o7027dc0bo873544dc0687cc48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: help-gnu-emacs@gnu.org, Git Mailing List <git@vger.kernel.org>
To: Rustom Mody <rustompmody@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 29 20:41:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhSrx-0003HJ-92
	for gcvg-git-2@lo.gmane.org; Sat, 29 Aug 2009 20:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395AbZH2Slg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2009 14:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752390AbZH2Slf
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Aug 2009 14:41:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59308 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385AbZH2Slf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2009 14:41:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BD7533CCE1;
	Sat, 29 Aug 2009 14:41:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gBVNcCg38OzyGTPwBp4HivV0CNk=; b=szSo5v
	6DZjel9UvuCCCV17ItD6RGEcSg4sm0UFGCdVwT6eG729HRsWEt596dMT2RyI9L1r
	yCxNH4z7AYbbmeUjZUlpFCNXb/SQoczX36exKAY1zGbLn9+5TlBM+kIW3JdxPKXG
	oeP1xYuyWUWnJBWEBrHOJ3WUZDbKFA3NfbFl8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uZogiPK/8uKbNwGgchfJSbWyYG1h+WrO
	q26fzc+OOIwuvlfLIOkslGxujqnFIBJJlnklYBg3ol2r6k8uOG42IGoGU1WW26so
	Zlk5lo8zGZrO62qNII9SCSXLKuTohEIN/LtAEWcwE1V0q8Zx3YPQ8sQJ2z2zny9a
	o1CiGJCtKoE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 94C2D3CCDF;
	Sat, 29 Aug 2009 14:41:32 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 38FCE3CCDB; Sat, 29 Aug 2009
 14:41:25 -0400 (EDT)
In-Reply-To: <f46c52560908270914o7027dc0bo873544dc0687cc48@mail.gmail.com>
 (Rustom Mody's message of "Thu\, 27 Aug 2009 21\:44\:33 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 928BC8F6-94CB-11DE-B6D7-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127382>

Rustom Mody <rustompmody@gmail.com> writes:

> Just updating my own question:
> when I do a C-x v v (vc-next-action)
> which is supposed to be the most basic operation for checking in a file I get
>
>  Wrong type argument: stringp, nil
>
> So vc can be assumed to be a broken I guess?

Have you checked contrib/emacs/README?
