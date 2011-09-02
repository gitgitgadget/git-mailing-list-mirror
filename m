From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] fetch: verify we have everything we need before
 updating our ref
Date: Thu, 01 Sep 2011 21:25:05 -0700
Message-ID: <7v8vq7muzi.fsf@alter.siamese.dyndns.org>
References: <7vpqjkw3nb.fsf@alter.siamese.dyndns.org>
 <1314917015-3587-1-git-send-email-gitster@pobox.com>
 <1314917015-3587-4-git-send-email-gitster@pobox.com>
 <CACsJy8C4qX=p6d1v+i7TJanACOqL9R6-pv9AOaU_CM6DNjJfyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 02 06:25:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzLJs-00051w-5e
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 06:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102Ab1IBEZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 00:25:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45909 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750696Ab1IBEZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 00:25:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74AAA5BD3;
	Fri,  2 Sep 2011 00:25:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7mEgKQ7EKEKEJysi+rz/Jbn4sgs=; b=rc3Zws
	TWoBC9fJhSi6BjjLRpXT0cxrfDAR6sroc68aJei75mZ43QLi1OcbJ7X8/fTZo/BT
	o05kp9x2QydYl2Q0w+OFE5/n8ptABg+RVWr/A7jmdMehW7LzWJ52QMlHYtrArv1I
	9ExmGzvviQusgK/15wrvMaRiV9w3kWLZIrrmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FsQqv7FDJcOvSaKTzL9m56MPqrI0qvde
	UMn8KHRp17pkyoH43t+3gwS4clCCsJlFzvFf8k0x83MrAKVFIhyhdGofsxUvu308
	JU/WKcHV7XBK5LTkhVYwexqEMam2Jwr3sG5ds4I6E4CfYxlmC33e32DbcWIo0MBD
	1tcW4Q70mus=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5559B5BD2;
	Fri,  2 Sep 2011 00:25:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0A085BD1; Fri,  2 Sep 2011
 00:25:06 -0400 (EDT)
In-Reply-To: <CACsJy8C4qX=p6d1v+i7TJanACOqL9R6-pv9AOaU_CM6DNjJfyQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Fri, 2 Sep 2011 10:55:33 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 898788CA-D51B-11E0-A56E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180595>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> What about receive-pack? Does it have the same breakage?

I didn't look---you tell me ;-)
