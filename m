From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0 RFD] Homogeneous use of short options
Date: Mon, 14 Feb 2011 13:00:02 -0800
Message-ID: <AANLkTim1GUnyqkNbFPhkPEOitGG7PxsW1eeubkN69hf5@mail.gmail.com>
References: <4D594460.1040206@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 14 22:00:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp5Wn-00016w-UH
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 22:00:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694Ab1BNVAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 16:00:08 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46077 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674Ab1BNVAH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 16:00:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EDB334D22
	for <git@vger.kernel.org>; Mon, 14 Feb 2011 16:01:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=mime-version
	:in-reply-to:references:date:message-id:subject:from:to:cc
	:content-type; s=sasl; bh=Vb/Yo2rVCOxcJh/F2W+Qt6CMIvg=; b=FgVH3m
	Zrsc0DujGpxfILMC3ELqVLB0odFWfrc8WbWxR4zAxagwh9LFTRBWp8MIXTGO3AWe
	aBr6/HWiswWJk2fyWeG3IU1+KYLB+QM7sVHO+6edj441nh7m9AKfpadMub97hKL2
	B38TVbGvyK+1PKkHM17EXZwPxnH6sLjevAquw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=mime-version
	:in-reply-to:references:date:message-id:subject:from:to:cc
	:content-type; q=dns; s=sasl; b=P56BY010nOjTZyomA0MWVF3unAcv2vlM
	PtAf5GJ6vQtw8c3NG0t7PSVtNrUc72Tp0QwnoxL6Mvbkusrxdc2gmiiFCrepLFzM
	YR1XXOSwDLgRSFr62IuhDH15PdpnqS2Fo4QLzw83KZ84YmK4sKMoJjSnhUEfnUw7
	goUYWAOIIxo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EB3E04D21
	for <git@vger.kernel.org>; Mon, 14 Feb 2011 16:01:08 -0500 (EST)
Received: from mail-ew0-f46.google.com (unknown [209.85.215.46]) (using TLSv1
 with cipher RC4-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A125E4D1E for
 <git@vger.kernel.org>; Mon, 14 Feb 2011 16:01:08 -0500 (EST)
Received: by ewy5 with SMTP id 5so2554997ewy.19 for <git@vger.kernel.org>;
 Mon, 14 Feb 2011 13:00:03 -0800 (PST)
Received: by 10.216.145.154 with SMTP id p26mr63591wej.11.1297717203065; Mon,
 14 Feb 2011 13:00:03 -0800 (PST)
Received: by 10.216.80.213 with HTTP; Mon, 14 Feb 2011 13:00:02 -0800 (PST)
In-Reply-To: <4D594460.1040206@drmicha.warpmail.net>
X-Pobox-Relay-ID: 8BD62F54-387D-11E0-BE34-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166766>

On Mon, Feb 14, 2011 at 7:04 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:

> add -A: Why capital A? Compare commit -a etc.

IIRC, this was in anticipation for a similar interface to include
_new_ files in the commit in the form of "commit -A", which _is_
different from the existing "commit -a".
