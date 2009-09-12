From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Issue 323 in msysgit: Can't clone over http
Date: Sat, 12 Sep 2009 10:31:05 -0700
Message-ID: <7vvdjof4ti.fsf@alter.siamese.dyndns.org>
References: <be6fef0d0909080610j89c0a4bkf1cb0119b9b11db@mail.gmail.com>
 <0016e6470f36315b8a0472bc75a8@google.com>
 <20090904212956.f02b0c60.rctay89@gmail.com>
 <7v8wgrbb9e.fsf@alter.siamese.dyndns.org>
 <be6fef0d0909062253p1b86628et8a9f979952eebb00@mail.gmail.com>
 <7vocpn44dg.fsf@alter.siamese.dyndns.org>
 <20090907172751.6cf38640.rctay89@gmail.com>
 <7v7hwatw0v.fsf@alter.siamese.dyndns.org>
 <20090909203350.e3d7e5dc.rctay89@gmail.com>
 <7veiqdzwrk.fsf@alter.siamese.dyndns.org>
 <be6fef0d0909120301r79072d5ase0d4b174753af9b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Tom Preston-Werner <tom@mojombo.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 19:31:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmWRd-0002hW-Um
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 19:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbZILRbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 13:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752210AbZILRbT
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 13:31:19 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55441 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbZILRbS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 13:31:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2D6B34E7A3;
	Sat, 12 Sep 2009 13:31:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MthNW9dm/bm6gPisfYe/A4dRL3k=; b=IzB5VC
	4U4Qv6Uxp0MKhuH7kR3KPD0lMg77SogGO0LUslXP+RljZrCEgAXtDdMUbmyJl0Nu
	hC0laOBYgWFSqdJZVRyg248bRSW8V4bSMvdcyn6MJGHwFdVJoQxNSz1LN59sduGb
	VOZn9IWQZ9WpedYiXyG9XVnblPjVqFhJaUxjU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jKQ4aBmhl+/fHwbdHXbrV7Fw+W4awNyp
	bMWblW5rwotr7JfOy7xvmFoa+Dy7hxNVN4SiQ6hYdYDGpMuZ9hzHKr263bbbi/Vh
	+T3E7PtXA8VkYD5o0Xp42XY/TAEfuTAGfNvflNFrj3BjnyQb2aT6Bsd1VyHSbWrl
	MKhbGMtIWH0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DE4A24E7A2;
	Sat, 12 Sep 2009 13:31:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E6F274E7A1; Sat, 12 Sep 2009
 13:31:06 -0400 (EDT)
In-Reply-To: <be6fef0d0909120301r79072d5ase0d4b174753af9b5@mail.gmail.com>
 (Tay Ray Chuan's message of "Sat\, 12 Sep 2009 18\:01\:06 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 11CA4CEA-9FC2-11DE-B2AF-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128272>

Tay Ray Chuan <rctay89@gmail.com> writes:

> PS. The above was solely based on my reading of the code, no testing done.

That matches the understanding I had from reading the code.  I just wanted
a sanity check by another person who looked at and worked on the code more
deeply than I did.

Thanks, so the patch is a go.
