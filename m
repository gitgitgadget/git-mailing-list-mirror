From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why do dates in refspecs require the reflog?
Date: Tue, 30 Dec 2014 12:55:48 -0800
Message-ID: <xmqqppb0rh63.fsf@gitster.dls.corp.google.com>
References: <CAHd499Cvy=zi=9utoZ2bEgdSUTjkveHMP2OvVFPBHq7W2MuoZQ@mail.gmail.com>
	<54A310AB.7050701@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Dec 30 21:55:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y63pc-00025Q-3Z
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 21:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbaL3Uzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 15:55:52 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52009 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751321AbaL3Uzv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 15:55:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DC442AE36;
	Tue, 30 Dec 2014 15:55:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JzSAg4jECPPuWbrwojRD9n2ViSs=; b=xys8A4
	o6EtdwoIAGEaVWSgVWlzY9m45c7R3bpAK9/6Jt7jzPa7t8V4O/9D30fhhtY/ed1x
	3NTEOzQKnM8GfGv6CaL5TXxXIx7CCLbLb2JWXyvFz0YrSAGIk9yvrm2+V1gmHOWA
	wseNTrOLvzX8OXXi8SbVtK+cYL9N3zNb6syAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y1BIzM16eeHiiyY7ve8BZVwQQpFhGWL6
	fgEePo0N0rFKNZN1YU2R+PGsNZi/Fr759CBxcbwOobFcb8n1Isxw/jIfGH17M2CF
	T//W7KF0bhmOLCmHW4eNIstStYEzyzrwtT5LzuEkNhUbCZOb3cUFvv3T7bJRVtee
	Tun7Othav7U=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 04B6D2AE34;
	Tue, 30 Dec 2014 15:55:51 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7FBFE2AE33;
	Tue, 30 Dec 2014 15:55:50 -0500 (EST)
In-Reply-To: <54A310AB.7050701@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 30 Dec 2014 21:52:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3C93C98E-9066-11E4-BA26-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261946>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> There is yet a third similar question: "What is the last commit that is
> currently on the master branch that was *authored* at least one year
> ago? Please note that this question is even subtler, because author
> timestamps are often out-of-order even on a single branch (whereas
> commit timestamps are usually in order). I don't know of a simple git
> command to answer this question.

--author-date-order?
