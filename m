From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/12] Allow reference values to be checked in a transaction
Date: Thu, 12 Feb 2015 11:44:29 -0800
Message-ID: <xmqqfvaasyn6.fsf@gitster.dls.corp.google.com>
References: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 12 20:44:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLzgj-0002Yc-VT
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 20:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbbBLTod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 14:44:33 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59815 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752549AbbBLTob (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 14:44:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A1B85375C3;
	Thu, 12 Feb 2015 14:44:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vLmL3phhTbOeE33m3Of6oDQPlP8=; b=T+6PBS
	kNrAkhHglusXVDhEXl29LzIk1cGKOORzTZqeQjm7QTowu+xo3W8XJpQWLBox2fPH
	j2mq373CwCUIjoY7Htkna4CCPidsu2z7hfOrCNHe8V0vw/Eg1DNlHHlWFNrYpzhj
	GhyNPj3CvLw5v/I7ydtRFLp1rm6tFEXCThYxU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QoyrH8YV2j6fU9SsN0w+EDrskribQeml
	DQ1OdM06lJMND/qJkBJQbb0WTOOuSwEUCF1rJ15srqk5NW8n05Z9FoBIidtz2JoJ
	UbO4eeEi0jsJ5Db2G4Xv85HxQAsqz3x+5zBzDK6hnWBTTh/SDerf4ZLNUbKgNhbU
	GOfiZzssqoY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 977BC375C1;
	Thu, 12 Feb 2015 14:44:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 17F0D375C0;
	Thu, 12 Feb 2015 14:44:30 -0500 (EST)
In-Reply-To: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Thu, 12 Feb 2015 12:12:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8F76012A-B2EF-11E4-A521-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263755>

Modulo minor nits, this round looks nicely done.
