From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/19] Add git-list-files
Date: Mon, 01 Dec 2014 12:02:34 -0800
Message-ID: <xmqqbnnnp291.fsf@gitster.dls.corp.google.com>
References: <1417337767-4505-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 21:02:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvXBB-0002fn-H7
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 21:02:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbaLAUCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 15:02:37 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62248 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932101AbaLAUCg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 15:02:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ED4BB20C4D;
	Mon,  1 Dec 2014 15:02:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Elz+D+MwZbAH74dllxSiYFC9+ww=; b=wWkcC1
	j/AUH2y6ncgwyHnCqSCiTWBwIr8wIn1fN2UYFU3pPFOtIK9hh/n2VHl+/FSWE7Ms
	SDKVZXaheJPjv4ERfovhzNR6aM/n+Z74u69bZz9ri++87e5IjzSNAWxyFAMb7PEZ
	n0Szs6IJGRTg9dWj4QADJvakjrHndv1UrzqfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GqMoglF4t/QBBePxO9uUSJZvHb7bO0sD
	ztQb+XVYEtQyzFUCQFpmEc/4AkYFkqQe0BCzxR8agjqcCkMRNFztRzCKnxxComqV
	K4ZsCkRmQeHi+4En3I3OT70QjJpFFUwH/XRfB0oqmVcDzRhG6IjUODq3LDnfjob4
	J7sjpwexzb8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E3C2D20C4C;
	Mon,  1 Dec 2014 15:02:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 69C3C20C4B;
	Mon,  1 Dec 2014 15:02:35 -0500 (EST)
In-Reply-To: <1417337767-4505-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 30
 Nov 2014 15:55:48 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FE2CE41A-7994-11E4-892C-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260509>

Does this contain a lot of borrowed code or something?  The style
violation in the patches are unusually high, even compared with your
other series.

I've tried to fix it up and will push out the result on 'pu' if
things work OK, but this does not even have tests, so it is unlikely
that it would break anything but itself ;-)
