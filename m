From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: print format-patch usage if there are no arguments
Date: Tue, 13 Jan 2015 15:41:18 -0800
Message-ID: <xmqqzj9mb65d.fsf@gitster.dls.corp.google.com>
References: <1421171662-12164-1-git-send-email-kuleshovmail@gmail.com>
	<xmqq387eed30.fsf@gitster.dls.corp.google.com>
	<CANCZXo7UtCXF_bJe9exT1pUwwsgUuYs5mvHHGtDORoJew_UXnQ@mail.gmail.com>
	<xmqqppaicwww.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYJ+XNktc7_C81xz=BfCP4_hrE=pWW5QGJ1kdXKMf4Jjw@mail.gmail.com>
	<xmqqiogaco3m.fsf@gitster.dls.corp.google.com>
	<20150113224531.GB3144@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Alexander Kuleshov <kuleshovmail@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 00:41:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBB5R-0005Fk-MO
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 00:41:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbbAMXlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 18:41:21 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50563 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751271AbbAMXlU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 18:41:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 760322E82F;
	Tue, 13 Jan 2015 18:41:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QvYHvWaxtHUW6G3VPKgMsma1s20=; b=LChgmG
	5sqYxEAD7ZQ/72DkjYp7MKttQcglb8IxtJZBqNSutXUCpJU1spNX4yAjWXo43u+J
	7JRv0iqLMwxRN8e/LL+idBSSBUFpUlStBmRTf7DambTrBrQ43oOvicd0rAWA5k/H
	G/plp/D8md9/JgeRzIrMwcly4R+Mz2OlgbvUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=USH0VTWlUJ7gIZXWp/fOol098N+FzpH+
	0ynt26nulgMyyHf80O7iKdEuQBZXtsbtGr829elx85JTaGS+tpP+LBPAm48yq5rf
	Im9yzBMxt9JLNhXfn3SNVNvYhFBP9YTf9UIyfsbc9msdUorb/ClJ0L7HD/QJZC2R
	dK1Cg2r2+o8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CA862E82E;
	Tue, 13 Jan 2015 18:41:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF6222E82D;
	Tue, 13 Jan 2015 18:41:19 -0500 (EST)
In-Reply-To: <20150113224531.GB3144@peff.net> (Jeff King's message of "Tue, 13
	Jan 2015 17:45:31 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ACB30744-9B7D-11E4-AC8A-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262363>

Jeff King <peff@peff.net> writes:

> So that is perhaps not asking for the feature (I am already happy with
> my homegrown wrapper), but is maybe an endorsement of it. :)

OK.  A patch to add this should be reasonably clean and trivial, I
would guess.
