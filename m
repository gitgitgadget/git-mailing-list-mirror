From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/32] nd/multiple-work-trees
Date: Thu, 25 Sep 2014 14:20:08 -0700
Message-ID: <xmqqk34r9z3r.fsf@gitster.dls.corp.google.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
	<1410388928-32265-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 23:20:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXGSf-0007ey-5Q
	for gcvg-git-2@plane.gmane.org; Thu, 25 Sep 2014 23:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752414AbaIYVUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2014 17:20:18 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52523 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752350AbaIYVUR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2014 17:20:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4A3D73D856;
	Thu, 25 Sep 2014 17:20:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g1bmXBv3gZqG/vEVPsAoAd/SOQY=; b=USfl8N
	I26N5yLg2eNAFiBjyyLiO4Ky3MH1RPgLRV1BvFMtGMM+Ao3eC85sFLpgEJqe03Q8
	0G8OYrqbtIMBHqN0glIpkf4X99Z7OV7TrCniFXknxO1bdZ1Sp4oVI8o2hFOkPIpe
	kJCLOnpxmCa12QubumWaSPPuKAflo2jrewOwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JnGqj8Yop5RF0Ffc55Thq20xvTopAT6B
	kgVzcatldk+f647Gq2bMtMSIavVTMmN8bAQFL3C6Edmx6pNdxziODac5ZCRGqse1
	vnFEYVYJW6nusiLMeGksTxCttlboKi0sOCLOtbSzGPuQJBApqdF06mvlWbYMnOkr
	yHfumltdWBs=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F0A1E3D855;
	Thu, 25 Sep 2014 17:20:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A51273D851;
	Thu, 25 Sep 2014 17:20:09 -0400 (EDT)
In-Reply-To: <1410388928-32265-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 11
 Sep 2014 05:41:36 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BAA4C822-44F9-11E4-B6AB-D931C4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257496>

It has been a while since the last review exchanges were seen.  Will
it be time for v3 soon?
