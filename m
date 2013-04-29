From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Mon, 29 Apr 2013 13:24:14 -0700
Message-ID: <7v1u9thyq9.fsf@alter.siamese.dyndns.org>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<7va9ohhzsi.fsf@alter.siamese.dyndns.org>
	<CAMP44s3ghzcfTthEEYZgr7ydJFUeA5xKyAxgR1JUYVtWG7f=qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 22:24:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWucX-0000Bh-RI
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 22:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758773Ab3D2UYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 16:24:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64023 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757950Ab3D2UYR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 16:24:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C39FA1A0E1;
	Mon, 29 Apr 2013 20:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f61RN83//LYXpjdYVwQ5QcNgUVw=; b=OdotjH
	g+aP35VPQJ2gjfXDUxpRdP3WUnckDTWwJZRDbj4+iB7SbkfEq9Dn9eBNd00Waccn
	WO3sjQ4DFDmlYyy9TgAXOIxIr9nFsYf9JMX1yCKvemSzHoW58OrMueVmMg3mg8Ei
	UKJDY7pQQUL784zke3TDREtCxrIa7T4+aIAp8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X0dSCe6HaYJCG0d8G1FQ18BkDgf7+YjD
	VJfhAchvaFQ6ArDJRn0T2krDOTMD/D2zwGM/94JG1t8ByD05EkElBCSxhkBJS2O7
	JLsDE66HGCFQBUq0/mRJAmh7t5ixlZjxT+kEbApPi/nhOIl+uA7IXTIpC2NEhGUT
	1WWxbs8LIV4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B91641A0E0;
	Mon, 29 Apr 2013 20:24:16 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B64C1A0DB;
	Mon, 29 Apr 2013 20:24:16 +0000 (UTC)
In-Reply-To: <CAMP44s3ghzcfTthEEYZgr7ydJFUeA5xKyAxgR1JUYVtWG7f=qg@mail.gmail.com>
	(Felipe Contreras's message of "Mon, 29 Apr 2013 15:14:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C3863CCA-B10A-11E2-87EC-8D009ADAE8A5-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222860>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> But @ is not used just for reflogs, there's @{now}, @{-1}, @{upstream}.

True.  @{now} is a reflog, @{-1} is also but @{u} is not.  It is a
kitchen sink and you shouldn't have to have reflog on a branch in
order to use @{upstream} (I didn't check---I wouldn't be surprised
if the code for @{u} is buggy and barfed).
