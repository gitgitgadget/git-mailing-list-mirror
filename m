From: Junio C Hamano <gitster@pobox.com>
Subject: Re: make install rewrites source files
Date: Mon, 23 Jan 2012 12:52:14 -0800
Message-ID: <7vaa5e87lt.fsf@alter.siamese.dyndns.org>
References: <hbf.20120123bz2f@bombur.uio.no> <4F1DC2F7.2070502@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Mon Jan 23 21:52:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpQsJ-0002qZ-0J
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 21:52:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479Ab2AWUwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 15:52:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56318 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181Ab2AWUwR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 15:52:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4A6E62D6;
	Mon, 23 Jan 2012 15:52:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VRhU61FYCGEg1ZXgIOKCfuAJzZk=; b=C3LxVH
	Db4Nohi18l6gvyWj3FXpNb/L5IuFLQWTMgQOf2tm0b5M+Zuip7F1Yf3WPHRqaNTC
	WPwcQwNUNvMbecPI2RO0No9zWfAKPGbxi+dQCD6nPB502Gts3/kN6Yft65OqTwqd
	WHinqakr3kXYAq+ywVmhGtifA7X2iLOGECzpI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jJocBKydFabdDNtUo0/COJn84TlziDfJ
	qMILlYhd7xoV26JUsIJGBtcG01O+rBeOnDWcJL3i2scFPrJXBWwwwbI6tDeleLPo
	49/MclzCwnx5BPea9HUMsv2KzXf89yq7GUlxe42DA8NnGJ//y8Wo9/8J+2xvko6g
	XI3cqK4zt7w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCDB562D4;
	Mon, 23 Jan 2012 15:52:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62F3962D3; Mon, 23 Jan 2012
 15:52:16 -0500 (EST)
In-Reply-To: <4F1DC2F7.2070502@ubuntu.com> (Phillip Susi's message of "Mon,
 23 Jan 2012 15:28:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 22204E9C-4604-11E1-BF0E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189012>

Phillip Susi <psusi@ubuntu.com> writes:

> On 1/23/2012 9:18 AM, Hallvard Breien Furuseth wrote:
>> INSTALL says we can install a profiled Git with $ make profile-all 
>> # make install prefix=...
>
> prefix should be an argument to configure, not make.

What are you talking about?  Use of ./configure is entirely optional, and
our Makefile _does_ support giving prefix on the command line.
