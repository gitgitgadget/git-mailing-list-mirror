From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git pull not ignoring the file which has been sent to the temporary ignore list
Date: Fri, 23 Jan 2015 11:31:40 -0800
Message-ID: <xmqqiofxqoo3.fsf@gitster.dls.corp.google.com>
References: <3278910.5D06XWKxyS@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Arup Rakshit <aruprakshit@rocketmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 20:31:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEjxO-0003GV-JC
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 20:31:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754411AbbAWTbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 14:31:47 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55804 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752890AbbAWTbp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 14:31:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DCB030A3A;
	Fri, 23 Jan 2015 14:31:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/aQUMuT8EvWKyxS6B2fSrZ6z7O0=; b=QrkJQR
	EgpC4mhJ+FkbGwHFMmGUWNeawiVIJXnsMTsv4Mu/yeqDxdHyR4B/Pvm5vyaUs//v
	v+xLUkv6eKvULlMItYXivEu5nxvMYSnutUs/8ixJyiNVkKS8rh7IWsuo6ZIZjNvZ
	jZELJkgaJFHSisInqxf+pYkRXRyac0DSXRD2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yXzrA1xKndSKLktzRv5THmakfYwop57+
	owOqjVUzjaf81BUqZs2VVFN2xrei0egwHlsFJoodbhD3DqJGbBhTlyOX+xpBRigE
	iaTohq/EmLC+gNM3PT1hK3B4rN6+wjbeGGL0YcC1SXfAVU3eUbE38nIsvVwCUS7k
	h+gP5g6ECRg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 003E830A39;
	Fri, 23 Jan 2015 14:31:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9828030A32;
	Fri, 23 Jan 2015 14:31:41 -0500 (EST)
In-Reply-To: <3278910.5D06XWKxyS@linux-wzza.site> (Arup Rakshit's message of
	"Sat, 24 Jan 2015 00:57:30 +0630")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 751C81FA-A336-11E4-B70A-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262949>

Arup Rakshit <aruprakshit@rocketmail.com> writes:

> I asked git not to track any changes to the file .gitignore. To do
> so I did use the command - git update-index --assume-unchanged
> .gitignore.

You are not asking Git to do anything. You promised Git that you
will make no changes to .gitignore, and then broke that promise.

Assume-unchanged is *not* "Ignore changes to this path".
