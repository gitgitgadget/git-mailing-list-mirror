From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 12/13] dir_iterator: new API for iterating over a directory tree
Date: Thu, 09 Jun 2016 09:19:27 -0700
Message-ID: <xmqq1t46jpww.fsf@gitster.mtv.corp.google.com>
References: <cover.1464957077.git.mhagger@alum.mit.edu>
	<38124bd892ac1f4683b7debe721fc69424a347be.1464957077.git.mhagger@alum.mit.edu>
	<CAPig+cRKa2QF9fp0in7wbPBzyY3UQbvNrioFWjxPjQQsoY=F9A@mail.gmail.com>
	<575956FB.9010207@alum.mit.edu> <5759628A.4020704@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>,
	David Turner <novalis@novalis.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 09 18:19:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB2gM-0005qc-Uq
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 18:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbcFIQTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 12:19:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54660 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932270AbcFIQTb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 12:19:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D3F6421F94;
	Thu,  9 Jun 2016 12:19:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9ajXoAEvEhVyTleSpI+6G/DQ8jE=; b=xPhpEN
	GjAoWujNZOCGtnASZWwHmM/s7wKcgQ+nBLWWlM8secLxeRJ0JHy8EB/2xwbnXbWI
	I5Cmd+RTeN04tuO5ept3I+SMsY1Cx6ljNrawzMwIqFUPKccETS+3n2OPHDscscvq
	rDIPZSPFeuVT8V8vRVeMyQ4dRvawYR0p3wxEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iN1nRtigzhEjwI9h4q4P5iH9Fm4CTSCk
	SnG/aMBhHpsJ3tELCpwO+bqUlJuSOwHhiPKf4/YcuaUpjgGesWKEhY0HgX2Mxw7u
	e1b2cPjwAqsJQ/p8fPxvu4J0b355v6s4zzzuUpsPg6MFctGIwKwHtn2ujLB77ERJ
	8cJUDGQ1PXQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CB47721F92;
	Thu,  9 Jun 2016 12:19:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4FD9721F8F;
	Thu,  9 Jun 2016 12:19:29 -0400 (EDT)
In-Reply-To: <5759628A.4020704@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 9 Jun 2016 14:35:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F12659F2-2E5D-11E6-A9F7-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296899>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Given that ref-iterators is in next but also that you will soon be
> rewinding next, would you like these tweaks as a re-roll of the branch,
> as fixup patches to squash on top, or as a new patch series to be
> administered separately?

A re-roll after the pre-release freeze was what I had in mind.
Thanks.
