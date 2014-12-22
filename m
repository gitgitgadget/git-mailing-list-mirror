From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/18] fsck: support demoting errors to warnings
Date: Mon, 22 Dec 2014 14:50:01 -0800
Message-ID: <xmqqtx0n710m.fsf@gitster.dls.corp.google.com>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
	<cdd5730d0003a7220f659804e9e286e77619b57c.1418055173.git.johannes.schindelin@gmx.de>
	<xmqqzjavgym5.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222319370.21312@s15462909.onlinehome-server.info>
	<xmqq38878gao.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222344250.21312@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 22 23:50:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3Bno-0008DH-1A
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 23:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968AbaLVWuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 17:50:05 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50923 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752805AbaLVWuE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 17:50:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7CDDF29F5C;
	Mon, 22 Dec 2014 17:50:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mgMOrjtsbeNMEak4satYk99LZzY=; b=Bdsybb
	aCcaTSU4LyMEzaZ1e4QD6V4oyR70Iq+Xfq4ToPQ/LiS4sfxZgbkJgRsj5JqRjU9y
	Al/DjZfJO1bVFVL9GUaHITqaviyq1sTJqLfbybipzSWl936Bn10Z2vUmNkaGeOJ8
	XAlwhvzG6khqDp+PcF2D4O5Ww0Q+6LoWX1NB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JEvdswmE+ut0jE2AYUZzN90yfu/+oRcq
	RIxc0sFfygGCNvQRVwvql2FFjddokb0RW24+nfwPO+yhG7B5lTkpujx6/SbmNg0p
	XwxrtGpymd1Vq9oRFooXKoscQZ7ZCFl3ZS5V/8nuooPY+2U5VlCqaKssc0rb9yTH
	kSvqYT9CzMg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7319529F56;
	Mon, 22 Dec 2014 17:50:03 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EA27A29F55;
	Mon, 22 Dec 2014 17:50:02 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1412222344250.21312@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Mon, 22 Dec 2014 23:46:32 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DDA4EBD6-8A2C-11E4-99AF-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261691>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Of course you can say that! ;-) The problem these ugly messages try to
> solve is to give the user a hint which setting to change if they want to
> override the default behavior, though...

Ahh, OK, then dashed form would not work as a configuration variable
names, so missingTaggerEntry would be the only usable option.

Thanks.
