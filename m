From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PULL svn-fe] vcs-svn: simplifications, error handling
 improvements
Date: Sat, 26 Mar 2011 11:36:47 -0700
Message-ID: <7v1v1t4tkw.fsf@alter.siamese.dyndns.org>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300751400-7427-1-git-send-email-david.barr@cordelta.com>
 <20110323003240.GA4949@elie> <7vsjuegzj8.fsf@alter.siamese.dyndns.org>
 <20110326064653.GC20529@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 19:37:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3YMJ-00037U-BB
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 19:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521Ab1CZShE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2011 14:37:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59769 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474Ab1CZShC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2011 14:37:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1EF1E3C65;
	Sat, 26 Mar 2011 14:38:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8cQd6t5zluV8UL95hvE9y7IGoZU=; b=S1ISva
	9aRauzof6DMlxVOgZXbArq2Zh4Z1Qpi+5AN5/VYPQS6w4bTsJTreoLonT1yoA6El
	7ggz9oJzVav9V9sK2ZAlk5g23j1uQyrLo+pljHA2bgKVicfSenGbQ2J59vAWQ3Kx
	0vbXQs5sVvsR9Drh3N6JirwJO2p/+MfI2Dexw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uxFf3JbwqDwgpphJCNEJYvvIyo2BYhEU
	fEDAs67Vldzjo/ExvjbySFiBLKQsVkvIUo+nZg4FGBoPdnXZYnCs47w4ndx7OZen
	XDqMic5jD++7bAZ1qiXmjZJjaVvZmiCE7G1S8vf5y/+VcxgIIJhB+e5jqty7ObYj
	QygYvNpzLO0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D1DD93C63;
	Sat, 26 Mar 2011 14:38:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 870F33C60; Sat, 26 Mar 2011
 14:38:32 -0400 (EDT)
In-Reply-To: <20110326064653.GC20529@elie> (Jonathan Nieder's message of
 "Sat, 26 Mar 2011 01:46:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4379C048-57D8-11E0-A462-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170065>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Turns out that introduced a regression (in handling of properties with
> embedded NULs; thanks to David for catching and debugging it).  Could
> you pull
>
>   git://repo.or.cz/git/jrn.git svn-fe
>
> for a fix and some other improvements in the area?

Thanks.
