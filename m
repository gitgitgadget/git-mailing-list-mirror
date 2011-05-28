From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git show and the --quiet option
Date: Sat, 28 May 2011 10:55:30 -0700
Message-ID: <7vy61qpv59.fsf@alter.siamese.dyndns.org>
References: <4DE12888.1040506@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Sat May 28 19:56:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQNkU-00039Q-EH
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 19:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364Ab1E1Rzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2011 13:55:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46532 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550Ab1E1Rzl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2011 13:55:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8AE26442B;
	Sat, 28 May 2011 13:57:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZI2Enl0c0sX4OLd+JAyNa7/M4jg=; b=dLo6FD
	GwDFTuK8wBe6WbvQsMJR7AFNdgYM1fp91aPMyiZXK0pyR4BS+Pm85PptUDStmhSG
	3oHZglClMXzWGTnxwS+w/6MS9O14qQuNLPpZy6TUMFXdQbpLuzY5Fw+qT+FsLzv9
	OnqsivfgXmE0XxoS0lZaZesRzxnqJS3HZ/C9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F92rYAFU7fCSZMzRfg2c9Kgtt7oMJJWG
	JVWFd1sJ9taD4WH8d5BBbRPwdLkCU8TpQrE1Z1MNLoJZKhEtoZ+HyZcd3b6PpivH
	KcV10YOfZvPo7HRcrrBSReZN5gECnK+mt5bFPjsdJzLmeDHMu6e40M8VNydB+2W+
	EhAuS4CvUEE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3650E442A;
	Sat, 28 May 2011 13:57:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 317BF4428; Sat, 28 May 2011
 13:57:40 -0400 (EDT)
In-Reply-To: <4DE12888.1040506@isy.liu.se> (Gustaf Hendeby's message of "Sat,
 28 May 2011 18:53:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FD9E1C24-8953-11E0-8728-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174667>

Gustaf Hendeby <hendeby@isy.liu.se> writes:

> I was playing around with "git show" lately and realized it has changed
> its behavior regarding the --quiet option, which no longer suppresses
> the diff output as it used to.

The official and right way to suppress diff output from "show" has always
been with the "-s" option, and it should still work. Otherwise please
report a bug here.

Thanks.
