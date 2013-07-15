From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Mon, 15 Jul 2013 08:37:08 -0700
Message-ID: <7vfvvfdecb.fsf@alter.siamese.dyndns.org>
References: <7vy59biih4.fsf@alter.siamese.dyndns.org>
	<51E0F93A.8050201@kdbg.org> <7vwqougwec.fsf@alter.siamese.dyndns.org>
	<51E1B5DB.9080904@kdbg.org> <7v61wdgdd1.fsf@alter.siamese.dyndns.org>
	<51E3084D.2040504@kdbg.org> <20130714203403.GE8564@google.com>
	<51E31131.3070005@kdbg.org> <20130714212800.GA11009@google.com>
	<7v4nbwfooj.fsf@alter.siamese.dyndns.org>
	<20130715044454.GA2962@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 17:37:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uykq0-0005Bu-Es
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 17:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932911Ab3GOPhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 11:37:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60194 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932535Ab3GOPhN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 11:37:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A99243031D;
	Mon, 15 Jul 2013 15:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wzFmXNQA1TveHE1yysE53dlDNWY=; b=sPzwCR
	gc4IAsiQ18RlVBQLOgRHvACN+ebzSV+YZXULWU0YG5UiUHQT53Sh3nxdJ30W+/lf
	Gzxru09/JXj4nCHWcg097C05dbRxDSIxst+aTZ895BPqnKSb1ZsL4Tk2LqaQdeDK
	6LVBG6ANuuGIB8PoqOl2tBhvXlLMnSjMcNIno=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EHCzKBJv3W6szZdMM+9U8UNvlIpDL3Lg
	o8j/rbVSoiyC+5LbbDOegZ6yWw1/2WAlH5MDpJKVzg3XFKRzTAOmZNh769Vr5GqS
	A5pdXDJUtpdSa/sI6Yjf5OhAghRW7XR6z5Z/SYRehqLyvAsx4k/+Az7KIh5qP7Ux
	xRsnGvpA2PM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E0A03031C;
	Mon, 15 Jul 2013 15:37:11 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E1DE530311;
	Mon, 15 Jul 2013 15:37:09 +0000 (UTC)
In-Reply-To: <20130715044454.GA2962@elie.Belkin> (Jonathan Nieder's message of
	"Sun, 14 Jul 2013 21:44:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 69A3B52A-ED64-11E2-9997-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230482>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Now suppose my relay has some downtime.  That's fine --- I can still
> maintain the mirror by running the same commands on another machine.
> But when the old relay comes back up, "push --lockref" will fail and
> "pu" and "next" in my mirror are not updated any more.
>
> That is why I said that --force is more appropriate than --lockref
> for this application.

Sure.
