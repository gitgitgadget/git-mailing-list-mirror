From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] t5550: repack everything into one file
Date: Wed, 04 Jan 2012 10:05:26 -0800
Message-ID: <7vty4bpcm1.fsf@alter.siamese.dyndns.org>
References: <7v8vlovavj.fsf@alter.siamese.dyndns.org>
 <1325692539-26748-1-git-send-email-drizzd@aon.at>
 <1325692539-26748-2-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Jan 04 19:05:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiVDX-0004Cl-5J
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 19:05:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756681Ab2ADSFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 13:05:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41649 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754084Ab2ADSF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 13:05:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 163D55D9E;
	Wed,  4 Jan 2012 13:05:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W2H8SOw9qczfS2wnj80NCQklhqc=; b=b9k1d7
	C7+rO0VmJpXStMNJWyjVn4i19G5ZS6qVbY+LlDYbnQa0hyPWrx21CEOXQwnwaw44
	LVW4im6svGkrFYPkapsZJExEOAKaCNABnfEPoI5ZHZq3PbW85skEXKWD+97GqPhE
	hktyG0pI2o8H/r/Au3m6IiNEIWHNibnbQjYW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q7rgmhlzGd59v/pnnlGJjhuRLUSWc+1D
	2IPd8DgVhTEDxlx2bYRPQi3Prm5JxvtGpjiaUu3ESHecfywcChnoA6KFkcxFWCNq
	rVFEkVIOZkdV4M8czhd9f3B4qVGPaECLR0LEOEyrBDnRWvHySb79TGn2D8aQOiOB
	URX47AgQW2g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DBBC5D94;
	Wed,  4 Jan 2012 13:05:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D3D75D93; Wed,  4 Jan 2012
 13:05:27 -0500 (EST)
In-Reply-To: <1325692539-26748-2-git-send-email-drizzd@aon.at> (Clemens
 Buchacher's message of "Wed, 4 Jan 2012 16:55:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AE96ED50-36FE-11E1-9C12-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187937>

Thanks; I assume this is also signed off?
