From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Extract remaining classes from git-svn
Date: Fri, 27 Jul 2012 21:05:36 -0700
Message-ID: <7vfw8cy1gv.fsf@alter.siamese.dyndns.org>
References: <1343348767-86446-1-git-send-email-schwern@pobox.com>
 <20120728004026.GA5363@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, jrnieder@gmail.com,
	"Michael G. Schwern" <schwern@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jul 28 06:06:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuyIC-0000v7-Nf
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 06:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052Ab2G1EFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 00:05:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42491 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750873Ab2G1EFl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 00:05:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26A3584FA;
	Sat, 28 Jul 2012 00:05:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ma5XZhqnxtvweZ4yy/ka1sOSsvA=; b=P6XLie
	UstqWIi0q8G2UGYKmugUhyd8wt8jTTw7PZDFErASg/4Yml52EKo+lMgLrgaFhdRH
	Sy7o0v7OIaAum+sy6zrFcxHzfFNaKpNtkdbwotMbaoQm/Lv2MZhn/qXglJCwiInH
	FWTl/+4GOTw85rqWFsKuOMRox0OZTtWKcT4sU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ws5ie0HXhVp9qrk+YJk2MUr86jc8dg90
	Hsz+Dr11TKGfeBJ/OnGQM1Q8stS7SPaHszZjb0EFp3QMKFqvVTlIVjwp1wmpclSg
	pC3/paq8rpO/zMqcL9aPJRbntpkvrZ0Y/KxZ/sm74gIEivTOnkzSW3DFbrzbLC+g
	7UzIZpLBynI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 124D684F9;
	Sat, 28 Jul 2012 00:05:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8730184F8; Sat, 28 Jul 2012
 00:05:37 -0400 (EDT)
In-Reply-To: <20120728004026.GA5363@dcvr.yhbt.net> (Eric Wong's message of
 "Sat, 28 Jul 2012 00:40:26 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7CD9A5A2-D869-11E1-8F5B-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202401>

Eric Wong <normalperson@yhbt.net> writes:

> "Michael G. Schwern" <schwern@pobox.com> wrote:
>> This series of patches extracts the remaining classes from git-svn.  They're
>> all simple extractions and functionally have no change.
>
> I've also pushed this to the "extract-remaining" series which
> also includes everything that's currently in my master.

Do you mean this should go in 1.7.12-rc1, or your master is for
1.7.12 and this is for post 1.7.12 but you are pushing it out to
help other developers who are working on git-svn as a preview?

I didn't look at these follow-up patches, but if you say they are
fit for the upcoming release, that is good enough for me.  Just
checking which way you want us to go.

Thanks.
