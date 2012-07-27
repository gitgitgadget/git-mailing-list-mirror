From: Michael G Schwern <schwern@pobox.com>
Subject: Re: Extract remaining classes from git-svn
Date: Thu, 26 Jul 2012 17:27:38 -0700
Message-ID: <5011E07A.807@pobox.com>
References: <1343348767-86446-1-git-send-email-schwern@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 27 02:27:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuYPB-00052v-GJ
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 02:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881Ab2G0A1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 20:27:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37265 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610Ab2G0A1k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 20:27:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C8F89D48;
	Thu, 26 Jul 2012 20:27:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=m8UPfpdAHb7q
	Q75YHzzd5GsEvmY=; b=uInWhzAFXIQcXFldCiAxjLT43PmjCv39OFne6s81UOav
	/3jICxjHNZdR4SYXi33Hch/PDgqn1YJWPHI2/1yLhg41guwR1h0opMxPn9VhTrKa
	51X3AP97Psoif8hQs/zvVFup9EorhVJOm0/98fOsWPn5yz9uxApqjcGIYorblR8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FyiQsq
	qrK46xZiitDlSbgQdYqAtwHFT2wc0VUdIc/Upt5h7EQ0zyvdOdqXXVtluc0nJoPw
	6Jzk4pCQj0hncpPRRQ+bdI9sw2TIN7ncXQxwKgE0T0KNK5Tad1EC5jqdcaBZmxUI
	iRYsYDjf/ErvpH2AWdehnX5s2Z8PYkg3+r7bU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89C349D46;
	Thu, 26 Jul 2012 20:27:39 -0400 (EDT)
Received: from windhund.local (unknown [76.105.239.160]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 94D989D45; Thu, 26 Jul
 2012 20:27:38 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <1343348767-86446-1-git-send-email-schwern@pobox.com>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: DF1E8A68-D781-11E1-86BA-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202330>

On 2012.7.26 5:25 PM, Michael G. Schwern wrote:
> This series of patches extracts the remaining classes from git-svn.  They're
> all simple extractions and functionally have no change.

PS  This is on top of the previous Git::SVN extraction patch series.


-- 
100. Claymore mines are not filled with yummy candy, and it is wrong
     to tell new soldiers that they are.
    -- The 213 Things Skippy Is No Longer Allowed To Do In The U.S. Army
           http://skippyslist.com/list/
