From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] pack-objects: do not accept
 "--index-version=version,"
Date: Thu, 02 Feb 2012 16:31:44 -0800
Message-ID: <7v7h04vjtb.fsf@alter.siamese.dyndns.org>
References: <1328017702-14489-1-git-send-email-pclouds@gmail.com>
 <1328109440-9510-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 01:31:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt74C-0007XH-2R
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 01:31:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119Ab2BCAbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 19:31:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40661 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753852Ab2BCAbq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 19:31:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D7F76315;
	Thu,  2 Feb 2012 19:31:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=oXgLGBOcdb9Xpp5VEeyXJkrjAFc=; b=EG2dy/XVgmAoN28n1lfY
	9/oj0NZFdenwyCcUYL/GfKV5G5JN7nbU643kZisCsQnlmhxwMvDYn+6TkC0fcGJb
	5a/77/d3w4XGq4mI0fqMbppDQMQD6iBEwC3OfwH5hHPVGtHgg7GjiSKTOcXeNXMR
	SqIV0+wj/nGgY4n+aRdcmU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=f12rgzxSwgz5n3PnSHc2ndoLX1H++eNFrrUA+kKagBSz97
	iimO4lDNGy6sFfAaumi9Juyhx9hgGz205xq6EndPp1OOmXinYnw+I1iL4Wxh1ZtL
	5Bd8KIU12fa6I5lXvySMdamtbhHwOeSBPi7dT8vwgdKdihWdG0gjdEdK3XD28=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13B0F6313;
	Thu,  2 Feb 2012 19:31:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A025D630E; Thu,  2 Feb 2012
 19:31:45 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 73BDEB7C-4DFE-11E1-9E71-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189723>

Thanks; will queue all three in the series.
