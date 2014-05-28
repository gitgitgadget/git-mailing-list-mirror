From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.0.0
Date: Wed, 28 May 2014 15:43:16 -0700
Message-ID: <xmqqmwe1bk3f.fsf@gitster.dls.corp.google.com>
References: <xmqqr43dbkni.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Thu May 29 00:44:18 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Wpma1-0005Ww-7t
	for glk-linux-kernel-3@plane.gmane.org; Thu, 29 May 2014 00:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755838AbaE1WoH (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 28 May 2014 18:44:07 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50114 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755778AbaE1WoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2014 18:44:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 25BBA1AF71;
	Wed, 28 May 2014 18:44:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2cxdEGpbOeEox5HYCEcIgha8Hi0=; b=Te17zw
	w6Ue8wt4CoXadww4qIDZjwNmb8cFdUwdZDyehL+l34p26TCX32LzLQSF3lFZKPz5
	rwiow9T0FaOezKv3MMVDq85KeVx/xdsrTfL4JgEkMFCBU7XXLJIMRHvVmTPmRin9
	CWvyFsdGbAhZH22tabGb3POgO/kkKRDQN34N0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e5d9txEmd1lM7nLkIDmQszwhrrhJ+Zkv
	qdiukBYXqQHBHnrZ0JQRore7dr9+1wk9Fci6dnGjVz8roAn6XqWl52G/dXYmBbWq
	6dymhfm1jaADb6gM18Qkm/QRcD+d/mA3CAZ2qSkWgiaMPQq/sYw6KPe5Mo29l2cY
	2Mjwp8ae6hA=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1B8731AF70;
	Wed, 28 May 2014 18:44:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 33E1A1AEE2;
	Wed, 28 May 2014 18:43:18 -0400 (EDT)
In-Reply-To: <xmqqr43dbkni.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 28 May 2014 15:31:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 76792B8C-E6B9-11E3-BBB7-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250342>

Junio C Hamano <gitster@pobox.com> writes:

> The tarballs are found at:
>
>     https://www.kernel.org/pub/software/scm/git/testing/

Heh, I do not know how this slipped in, but the real release tarball
is not in git/testing/ but found at:

     https://www.kernel.org/pub/software/scm/git/
