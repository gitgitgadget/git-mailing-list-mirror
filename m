From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Mark gitk script executable
Date: Thu, 06 Jan 2011 18:34:55 -0800
Message-ID: <7vlj2x8mr4.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.02.1101061943140.6372@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Fri Jan 07 03:35:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pb2Ac-0006lJ-GS
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 03:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137Ab1AGCfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 21:35:05 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42678 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753953Ab1AGCfE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 21:35:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2422B3055;
	Thu,  6 Jan 2011 21:35:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SCA6+coVGR2Xvy6Y9TRuH3uM3IQ=; b=fBcjFC
	dAR7ZYpsqVHm8tTKN+Uft5j5MuuN5w2VjcIzjad73Qb+NG0o0UPawFEzTUAUwY5D
	c2/xBxpo9WICROzWc9QRRO9fZm0GPB+GK43NZaJvPM3EQoFhrfLc0OCYSsdArXfq
	xvKc/jIXbCpV7NIqX+QQCqOBgr+pYg/dsm6mI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jI11livjnroodVyMqYJA47gzmiuwuNVt
	S1EspxyuUxwsrv5wZh8iMtxIz12ChP1u6fve1zUSouIAoCiJBTnssSFo5lXppxu/
	XkAartBLGpDdPIMA1Q9JOpRCiBOxDqDOxefj+PMBFIJAXqW2xsKO9sCIIO57LBse
	NZs/BahL1ZI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 028173052;
	Thu,  6 Jan 2011 21:35:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 23123304D; Thu,  6 Jan 2011
 21:35:35 -0500 (EST)
In-Reply-To: <alpine.DEB.2.02.1101061943140.6372@dr-wily.mit.edu> (Anders
 Kaseorg's message of "Thu\, 6 Jan 2011 20\:14\:41 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D067C35C-1A06-11E0-B763-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164694>

Anders Kaseorg <andersk@MIT.EDU> writes:

> The executable bit on gitk-git/gitk was lost (accidentally it seems) by 
> commit 62ba5143ec2ab9d4083669b1b1679355e7639cd5.  Put it back, so that 
> gitk can be run directly from a git.git checkout.
>
> Note that the script is already executable in gitk.git, just not in 
> git.git.

It did not lose the bit by accident but 62ba5143 pretty much was a
deliberate fix.  "gitk" is a source file, and its build product,
gitk-wish, is what is eventually installed with executable bit on.
