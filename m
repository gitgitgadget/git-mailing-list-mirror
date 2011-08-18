From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] Move write_shallow_commits to fetch-pack.c
Date: Thu, 18 Aug 2011 11:01:26 -0700
Message-ID: <7vty9ea437.fsf@alter.siamese.dyndns.org>
References: <1313593326-12077-1-git-send-email-pclouds@gmail.com>
 <1313670578-2939-1-git-send-email-pclouds@gmail.com>
 <1313670578-2939-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 21:54:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu8fE-00025K-AN
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 21:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088Ab1HRTxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 15:53:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43798 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777Ab1HRTxu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 15:53:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23D654B5D;
	Thu, 18 Aug 2011 15:53:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=O5SIfDb/Gs9nfhZSMP7nf271eTw=; b=vDfSqDcqfk/zvpsRoxAH
	Qw4xnT2XY3DsqBmYAyYuJ/wzCE7V7WtxRxpojLzbSyTvZu582YMLv7Jc8g/ZQ/G8
	BCuOpnZQ3MUptbVcedqv7LbWzdGor57GaNHLI3b1sFFtF1FibCwbwHnfIzO5BubI
	ofI+0LOszd2mvnvdX043n8U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=lxmSwNvAXu/fPKfD81vLrL7zChIooyvZ1aeNrKe8tEw/BY
	iO1ZFHjajBTnz1AgTuGdaVtjClq2gGNn8TfvMd8+2G6aCFIc2rZDdsHovb6siKFf
	iiV6MPwsyuuvrBuOM7RmEvOVdnGcStummyGUTnZ2fjvGd+02pe0zbsq5bvcMA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A2834B5C;
	Thu, 18 Aug 2011 15:53:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6B1C4B5B; Thu, 18 Aug 2011
 15:53:49 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CAAFFFBA-C9D3-11E0-98B7-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179619>

Nice; thanks.
