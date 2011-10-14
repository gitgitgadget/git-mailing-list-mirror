From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix alias expansion with new Git::config_path()
Date: Fri, 14 Oct 2011 11:13:17 -0700
Message-ID: <7vwrc7zbk2.fsf@alter.siamese.dyndns.org>
References: <4E982B27.8050807@drmicha.warpmail.net>
 <20111014142557.GB13680@laptop> <4E984781.6050601@drmicha.warpmail.net>
 <201110141838.19118.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 14 20:13:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REmG4-0001q2-Lk
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 20:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253Ab1JNSNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 14:13:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63959 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751883Ab1JNSNT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 14:13:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66B4768F7;
	Fri, 14 Oct 2011 14:13:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/63JpZxO5TH2PFOZ3fBdt7bwdU8=; b=karns0
	LHVasK6LSvs9nXctgmji8FzmGF0DyxJASR0ZFte0yp0N2Ye/fMdrhx+NRMujopbN
	jBKhLA6Ivrm/aXRWV1ztZrjLGhBBCUPb+neGEYJBPFkGgZTzwMulqWFcHRIdUwf1
	J8cC5bDCliA1UI3d6iOyCvEDLoq+pKk09sMjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H/tWgHCWPaK1qzLGAf8egpYmmP+KjWaR
	/yS+IbfmS0TM6idGFkc36wlGmgosH3KAM3fUYE4GsRNOmL7uv2PKSe7vq6R5yQ0Z
	gumQ5UvhvzbEUPWaENc5WkcPLaRHmAw2CCABxYAbpIRGzm/w0+BtvO8/uKMsObsy
	P9UDsTOBN8g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E8CC68F6;
	Fri, 14 Oct 2011 14:13:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC6AC68F5; Fri, 14 Oct 2011
 14:13:18 -0400 (EDT)
In-Reply-To: <201110141838.19118.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri, 14 Oct 2011 18:38:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 31A5F4F2-F690-11E0-9DE5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183591>

Jakub Narebski <jnareb@gmail.com> writes:

> P.S. Junio, does t9001 pass for you?

It seems to.

Thanks for a detailed write-up. I'd appreciate a final fix in an
apply-able patch form.
