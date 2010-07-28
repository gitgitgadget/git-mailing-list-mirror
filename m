From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 0/3] Updated patch series for providing mechanism to
 list available repositories
Date: Wed, 28 Jul 2010 10:23:41 -0700
Message-ID: <7viq3z4j1e.fsf@alter.siamese.dyndns.org>
References: <1280302984-1752-1-git-send-email-gdb@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jrnieder@gmail.com, j.sixt@viscovery.net, avarab@gmail.com,
	git@vger.kernel.org
To: Greg Brockman <gdb@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Jul 28 19:24:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeAMQ-0003Ay-7E
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 19:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755919Ab0G1RXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 13:23:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755908Ab0G1RXy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 13:23:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F93FC8C79;
	Wed, 28 Jul 2010 13:23:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=nA11kHPb3PKWOzS8YqpYf51JjiI=; b=uLZVlrOliV0kIpTuEV3Wru8
	XleFfPq9utLY27FIz1z19MGU3BDE2ftZrn2ujB6iztL7zqiYCsALqaFWG9PBfeHr
	uTvjE2jTCaKQGzWoVT+n7p6mhQaDUGta7pweMdO1Lxvh0M02ysjH2fR4QhWBmGKy
	JbWaczjvPR3i/jzuoXJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=J8QUZF16ziTy2MN/evf2hWa/UiTSmnN0MhWHPmP0b2p5WTkOS
	n7ECE2iz6Bx2IuLaLSDXgzgWkjFpNR12c0wA4G4DKXHQL3M+Dcc1oJ4HCsM8/v8K
	NdNZWIFwSZMwIhtDFvh1rkSPPUGLmdz5Fh9zmBFRPU3vI++Npl4ERwi1Gw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 17E01C8C67;
	Wed, 28 Jul 2010 13:23:49 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 24BF8C8C4C; Wed, 28 Jul
 2010 13:23:43 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E272554A-9A6C-11DF-94BD-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152110>

Greg Brockman <gdb@MIT.EDU> writes:

> This revised patch series should address all comments given thus far.
> The specific changes made between v3 and v4 are documented in the
> patch emails.

Thanks, all; will queue.
