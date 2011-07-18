From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 18/48] merge-recursive: Mark some diff_filespec struct
 arguments const
Date: Mon, 18 Jul 2011 16:40:40 -0700
Message-ID: <7vvcuz9myv.fsf@alter.siamese.dyndns.org>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
 <1307518278-23814-19-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 01:40:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QixQe-0003Wr-0P
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 01:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938Ab1GRXkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 19:40:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38442 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854Ab1GRXkm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 19:40:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 114DA4219;
	Mon, 18 Jul 2011 19:40:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=WIE2kfzzn5FGvghWHxPwOs4a6cU=; b=o7OJD7eYqomY4d/k8RFQ
	t9yxn9mb1GSPmgRc4+jGDMLe6qBBg+h/W+Q+hyd9SnHU+WB+n5iFY1a/Dl/0Hv86
	LrpLCxQmRRcTeqnIYIuR1zPpfJOPYZzkpUt1JwLnhepRSptpqgvJ2w5SbU56ukMU
	fEZEDSHMKdiesqoYPTXf16E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=A6GBpBAvo3toD5HTXPHQZ2trzJSjXVIZNzZciZjcinawVP
	dl1dcYaj86M8HikomBvkXwP+FcuzDdol0+GMU2MIRRLklJCL1ykjXIfYtuRvAWeS
	doLKDhELeePU3idhFpD+T5fRfZeU4x5WIOCNdtC6d+doQ5fwb9GPkQBJElu1c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08BB64218;
	Mon, 18 Jul 2011 19:40:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B1184217; Mon, 18 Jul 2011
 19:40:41 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5928E2D4-B197-11E0-AEED-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177428>

13/-18/48 all look very sensible.

Thanks.
