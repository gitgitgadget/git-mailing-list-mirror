From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: Improve client path detection when branches are used
Date: Sun, 19 Apr 2015 22:32:19 -0700
Message-ID: <xmqq383vnz4s.fsf@gitster.dls.corp.google.com>
References: <xmqqsic44rw5.fsf@gitster.dls.corp.google.com>
	<1429399445-11024-1-git-send-email-vitor.hda@gmail.com>
	<xmqqk2x9ndcs.fsf@gitster.dls.corp.google.com>
	<20150419115949.770008db@pt-vhugo>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 07:32:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yk4Jn-000621-0l
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 07:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981AbbDTFcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 01:32:22 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60750 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751459AbbDTFcV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 01:32:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2054B3BF2E;
	Mon, 20 Apr 2015 01:32:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2YxYpTAyplNNPUS3J7LlJSUo1vI=; b=Kuk4bJ
	BwUU6OxQfhwTNz+BglsCNJPCQR4lIcAJt03IvWTprgOJisj3WdoucXz+tOqePlat
	0+gbs+EPGRcSMHzJcLfrLuHORI36bYtNd9X9edYmxm/xpAYhOa5H5XkdCxY5Zd8e
	vhyRJK83Si24gY9FBuLRhL/2Ngq6gFlTSDffg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FEzCPJhzA3tsCyfTJd/SnWUdQwbI5/HF
	TBEv9PJI2zN/1YwT+GZ6MOmPrOebnWGZLYXdLvGKbcihBCiwMNh33BKx4K0SrE82
	SDl29m5LQFlzONjqi3yrExmDRbtgqLf+qcenb6h8bR7Q05fMGEF/JzvFnGEdRzcc
	jv+GtKhtflU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 18C4C3BF2C;
	Mon, 20 Apr 2015 01:32:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 91A2B3BF2A;
	Mon, 20 Apr 2015 01:32:20 -0400 (EDT)
In-Reply-To: <20150419115949.770008db@pt-vhugo> (Vitor Antunes's message of
	"Sun, 19 Apr 2015 11:59:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9D8A6F86-E71E-11E4-ADDE-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267450>

Vitor Antunes <vitor.hda@gmail.com> writes:

> Hope I got everything right this time :)
>
> Thanks for your help,

Thanks.
