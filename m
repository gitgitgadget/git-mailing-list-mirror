From: Michael G Schwern <schwern@pobox.com>
Subject: Re: Teach Makefile.PL to find .pm files on its own
Date: Wed, 25 Jul 2012 13:26:35 -0700
Message-ID: <5010567B.1060907@pobox.com>
References: <1343186471-1024-1-git-send-email-schwern@pobox.com>
 <7vhasvdbk9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 22:26:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su8AS-0001wx-Vm
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 22:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341Ab2GYU0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 16:26:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46594 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074Ab2GYU0j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 16:26:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4368C6328;
	Wed, 25 Jul 2012 16:26:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=v7KRPcHQ8rjU
	pgKXTix/LHqnmeE=; b=fgk0WLVrM+55EVAjI0+CchvWm2CaPg49zg9VDX7s5Cmd
	fmRJEy6dzWkUNWLJHLADRltpsWvUdHGjuisxNAlSAh2PyHsAZHXlhlr1Z4lTRn8O
	p7DPBOBBEp7CKZ4Q1bSZ46gjFFxidkqvDlJD+mBvJPFytBqqJiqQa43Zwcvvasw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JsfxjF
	mTtiUYSbS6Nuui+ESGjxJSoCFl901Ag75r7zUsbB97t8fPnL0qG+I1gGL8a27VCu
	mP++GTyqOBhrlB9CmRKCLDzmwaK7Qj4oEXCds4fm94tqnU0Ha3Tg9B4oA7HIhSbx
	9VVozyh3MNsBM5MYpzUPZanVeBOVTLeRQHfDs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 306026327;
	Wed, 25 Jul 2012 16:26:38 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE8566326; Wed, 25 Jul
 2012 16:26:36 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vhasvdbk9.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: 090812AE-D697-11E1-A5E7-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202191>

On 2012.7.25 9:56 AM, Junio C Hamano wrote:
> Looks sensible.  Will queue.
> 
> Thanks.

Thanks!

What's the lag time on it showing up in the repo, and which branch will it
appear in?

Also I just realized I've been basing my work on master.  Should I move to maint?


-- 
If you want the truth to stand clear before you, never be for or against.
The struggle between "for" and "against" is the mind's worst disease.
    -- Sent-ts'an
