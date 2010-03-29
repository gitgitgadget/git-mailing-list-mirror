From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] RPM spec: include bash completion support
Date: Mon, 29 Mar 2010 11:17:35 -0700
Message-ID: <7v7hov56ww.fsf@alter.siamese.dyndns.org>
References: <1269569690-sup-4884@pinkfloyd.chass.utoronto.ca>
 <1269592797-18487-1-git-send-email-icomfort@stanford.edu>
 <1269605445-sup-6122@pinkfloyd.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ian Ward Comfort <icomfort@stanford.edu>,
	Todd Zullinger <tmz@pobox.com>, GIT List <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Mon Mar 29 20:17:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwJX8-0005Rp-Vo
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 20:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754775Ab0C2SRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 14:17:50 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52642 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754067Ab0C2SRs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 14:17:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 076B4A6D8E;
	Mon, 29 Mar 2010 14:17:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=O7saHZFh0/NOq6L28OJvdSHqPV0=; b=DExSzMrnJFtOM/MfDmfG/bA
	1rWZso5Vzuqts5qeWP6Cjzt1+R2ckhgTY6+YGyUD7admPnTN/Jx2l1iqCrN7PYus
	et/kZEd1FqohHvtKXMyc/23CxzlTDBkFySWBupL6PY7P/kHTAMBr1D5iYA/1hcEd
	MMZn+q4NQI6+Mf3kvIJM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Aa/gPn+O6Fa6JDghdkN87z4pf1FGRrS9ozXeW/hePajLwQrEw
	I7d7ToEpMfyzoed0bwlqQ4SuQDM2AyStUY0k6/s6Bjl4W97QRMf8Q27XIPdT2xH1
	FCdFqS6kJwjuEUtUYqovsvT/zlw9VMGrU8Wr0Ko4/L5ILrUyoAEZflXUEg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F06C3A6D83;
	Mon, 29 Mar 2010 14:17:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1FA7A6D7F; Mon, 29 Mar
 2010 14:17:36 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5D6260FA-3B5F-11DF-8F20-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143506>

Ben Walton <bwalton@artsci.utoronto.ca> writes:

> Excerpts from Ian Ward Comfort's message of Fri Mar 26 04:39:57 -0400 2010:
>> Include the bash completion routines from the contrib/ directory in our core
>> RPM, in the de facto standard location.
>> 
>> Signed-off-by: Ian Ward Comfort <icomfort@stanford.edu>
>
> Acked-by: Ben Walton <bwalton@artsci.utoronto.ca>

Thanks all; I'll queue this and expect any further tweaks to happen
in-tree if necessary before the current 1.7.1 cycle goes to feature freeze
in a few days.
