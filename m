From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: fix esc_param
Date: Wed, 14 Oct 2009 02:13:58 -0700
Message-ID: <7vpr8qe3s9.fsf@alter.siamese.dyndns.org>
References: <1255463496-21617-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 11:25:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My00q-000330-Sh
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 11:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755990AbZJNJPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 05:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758248AbZJNJPR
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 05:15:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44427 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758226AbZJNJPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 05:15:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EC55E58DCC;
	Wed, 14 Oct 2009 05:14:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=xHo7FfvPSdpbAQAFpu5eTXXDfUQ=; b=tNuhoVZYvfmg6+sArbKSFDS
	44yBI58LA97B0Q8nqAz5h3bY43rdED7ojorT9w90bssMyysDl95QPkRWoG8pzmWJ
	MLwX5/FfYjY7QXoqbvVt4R010y8e+WgGlGkNeAChfrbcVsDN1cSuZLVI62ej6lce
	nCISanjk0aGoLAmc96Sg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=SdfMToFUIVjGDsxYACQdmVRVfaeR6D/ue56yVPGxdc+dWOIk6
	6ymwQ+diFH1BU5HdgumVAU08EuP3ld3moLEs7+4PD6EZU6NYg2LcygrcZsBT5qEw
	brsAPKxNswWPK5dQSkjnrUWSKQA0QChg61MV5AtoO9+t+nGShaCrqIAPPU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B547458DCB;
	Wed, 14 Oct 2009 05:14:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A8DC58DCA; Wed, 14 Oct
 2009 05:13:59 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EC0B690A-B8A1-11DE-9FA5-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130274>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> ...
> Finally, remove an unnecessary escaping of the + sign.
>
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Thanks.
