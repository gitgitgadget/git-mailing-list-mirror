From: Michael G Schwern <schwern@pobox.com>
Subject: Re: Fix git-svn for SVN 1.7
Date: Tue, 31 Jul 2012 16:28:11 -0700
Message-ID: <50186A0B.9050707@pobox.com>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <20120730203844.GA23892@dcvr.yhbt.net>
 <7v1ujsl8ut.fsf@alter.siamese.dyndns.org> <5017AB63.6080909@pobox.com>
 <20120731200108.GA14462@dcvr.yhbt.net>
 <7vtxwnh6qq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca, jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 01:28:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwLrO-0004jP-Qs
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 01:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756255Ab2GaX2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 19:28:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36432 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755072Ab2GaX2K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 19:28:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 074599430;
	Tue, 31 Jul 2012 19:28:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=Tot4RY6PRS/L
	gOGyxtVhtMSIFKo=; b=YjaacIO4zeFeFM+8fYCR1Kx/N6ttpNaYvwWBaOWS8gEs
	LpjxaIUVpyHLNwhCXO/jWfRYxdUzDJHxghlRr2tDp6JxU6LMLBuRuq0STjFMSXsx
	gcBTUXABL7zrx2aj3zjsOW7tGZcLRI+COV7mFB6CErb0eP2IP/UbYYjoI2ntcTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OkVt0O
	1XsFPl5+K2dm5SmiedP5a9rtt4CRytj17kMdowyROligJGbkC4qCWIwyM95HHsiS
	BAYO1zBRilFldNnkHsSine28C7zGPVppEqvgzdBOaRHdD/k8llHlg7uAzJDAal/D
	7hv//pfSrE+gp9hOvpb0zJGRSyKp2H0quvJtM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E78E9942F;
	Tue, 31 Jul 2012 19:28:09 -0400 (EDT)
Received: from [192.168.0.71] (unknown [168.103.236.213]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7026942E; Tue, 31 Jul
 2012 19:28:08 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vtxwnh6qq.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: 6382C8DA-DB67-11E1-AB5C-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202696>

On 2012.7.31 4:05 PM, Junio C Hamano wrote:
> What I won't accept is "maintainability does not matter".  It does.

I'm sorry, that's not what I intended to convey at all.  My reply to Eric lays
it out more clearly, I think.


-- 
Reality is that which, when you stop believing in it, doesn't go away.
    -- Phillip K. Dick
