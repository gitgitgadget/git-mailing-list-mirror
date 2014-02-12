From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Make the global packed_git variable static to sha1_file.c.
Date: Wed, 12 Feb 2014 12:28:04 -0800
Message-ID: <xmqqmwhwm5yj.fsf@gitster.dls.corp.google.com>
References: <52fbc2d6.7kJdh2GOdWTzNcPK%szager@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: szager@chromium.org
X-From: git-owner@vger.kernel.org Wed Feb 12 21:28:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDgPm-0006JW-NF
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 21:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787AbaBLU2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 15:28:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62992 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753766AbaBLU2I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 15:28:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9B736A051;
	Wed, 12 Feb 2014 15:28:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g/D4wmS57A3sY8kw+kvB8gkAJI0=; b=RHH5MX
	Le6VMdabsQKS6DzgC7W9qZhRYV/5Hs2f1LegFUx6ZPcqoTKFGAP9stuQpnTT8f0J
	YY9TMEyCE2QeYWjaMKBF7cj15PcAdYdeoGLkiT8I5Qa6y/7Lh+5EIVDfBQ3jOwNK
	IJhoAzBYO7KuRmsCq3LtIK//48LkM4I7WThZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RC71tQ1oabJQ5nuA90A4TqOk6IQGKDAm
	qvGlBdEdYSv8LxyS0IVyCFuIXOSp4wFvT1qaoeTGi95JZxQodCxlrDFUXf+iK72/
	lK6t5KM21jx+OYv5DW5WVY6WYqS6opvQsb7tDd/ACDmc4wIgIvTy7+RGMVzzuLuo
	rxPCQyXU8Us=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93C3B6A050;
	Wed, 12 Feb 2014 15:28:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA16D6A04F;
	Wed, 12 Feb 2014 15:28:06 -0500 (EST)
In-Reply-To: <52fbc2d6.7kJdh2GOdWTzNcPK%szager@chromium.org>
	(szager@chromium.org's message of "Wed, 12 Feb 2014 10:52:06 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2E4BF8C2-9424-11E3-A749-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242022>

I'll locally fix up these style issues before commenting on the patch.

Thanks.

ERROR: space required after that ',' (ctx:VxV)
#78: FILE: builtin/count-objects.c:111:
+	struct pack_data pd = {0,0,0};
 	                        ^

ERROR: space required after that ',' (ctx:VxV)
#78: FILE: builtin/count-objects.c:111:
+	struct pack_data pd = {0,0,0};
 	                          ^

ERROR: space required after that ',' (ctx:VxV)
#171: FILE: builtin/fsck.c:683:
+		struct verify_packs_data vpd = {0,0,0};
 		                                 ^

ERROR: space required after that ',' (ctx:VxV)
#171: FILE: builtin/fsck.c:683:
+		struct verify_packs_data vpd = {0,0,0};
 		                                   ^

ERROR: space required after that ',' (ctx:VxV)
#541: FILE: builtin/pack-redundant.c:591:
+	struct add_pack_data apd = {filename,0,NULL};
 	                                    ^

ERROR: space required after that ',' (ctx:VxV)
#541: FILE: builtin/pack-redundant.c:591:
+	struct add_pack_data apd = {filename,0,NULL};
 	                                      ^

ERROR: space required after that ',' (ctx:VxV)
#565: FILE: builtin/pack-redundant.c:604:
+	struct add_pack_data apd = {NULL,0,NULL};
 	                                ^

ERROR: space required after that ',' (ctx:VxV)
#565: FILE: builtin/pack-redundant.c:604:
+	struct add_pack_data apd = {NULL,0,NULL};
 	                                  ^

ERROR: space prohibited after that '-' (ctx:WxW)
#726: FILE: pack-revindex.c:47:
+	num = - 1 - num;
 	      ^

ERROR: space required after that ',' (ctx:VxV)
#901: FILE: sha1_name.c:195:
+	struct disambiguate_data d = {len,bin_pfx,ds};
 	                                 ^

ERROR: space required after that ',' (ctx:VxV)
#901: FILE: sha1_name.c:195:
+	struct disambiguate_data d = {len,bin_pfx,ds};
 	                                         ^

total: 11 errors, 0 warnings, 781 lines checked
