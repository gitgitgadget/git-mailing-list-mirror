From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/9 v4] difftool: fix regression in '--prompt' options
Date: Thu, 22 Mar 2012 09:57:48 -0700
Message-ID: <7v7gyczi7n.fsf@alter.siamese.dyndns.org>
References: <1332358560-13774-4-git-send-email-tim.henigan@gmail.com>
 <1332381236-16004-1-git-send-email-tim.henigan@gmail.com>
 <7viphxz37j.fsf@alter.siamese.dyndns.org> <871uoljbe9.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Henigan <tim.henigan@gmail.com>, <git@vger.kernel.org>,
	<davvid@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 22 17:58:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAlKq-0003qH-CC
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 17:58:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031014Ab2CVQ5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 12:57:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50954 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031011Ab2CVQ5v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 12:57:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCD5E652E;
	Thu, 22 Mar 2012 12:57:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Prb5k9EWF9vA+NQ8jB71iz7QV78=; b=X1IucV
	sF7cF96amyBwRTKD1Y6kO5jz8WjPGw8bA9nhoJ+TtqFCabgJMFcM/J5x1bZ5oLjN
	MIpdjkyrwu9AtEourSczEXOv1w5k18EjdEtrfS/88knOmZYXI3zLu1QEsCAad1im
	NlnTduWGf8qTCCz1a2+C2exfyGqy6okA6Ew90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BdiwfEly6Zyik/0hTgtZu5Wm3DamVQt1
	7QVgR2ICBGzb6d+PlVVG3MYCGhwA6X4R8vpsWsQ1CWHG+9EyDAybJTyVvbMnzmaR
	RsEF9NyBgEU5Lv2cEUDgbJPEsfgXonr6/7XzgC2A2CM/zR5PtOZGh5kSTYwDDc4f
	SvOniyQlrrc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3CE7652D;
	Thu, 22 Mar 2012 12:57:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21099652C; Thu, 22 Mar 2012
 12:57:50 -0400 (EDT)
In-Reply-To: <871uoljbe9.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Thu, 22 Mar 2012 09:19:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2858F1B4-7440-11E1-8218-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193665>

Thomas Rast <trast@student.ethz.ch> writes:

> Limitations?  You can basically steal code from git-send-email.

Thanks ;-)
