From: Dan Zwell <dzwell@gmail.com>
Subject: Re: [PATCH] git-config --get-color: get configured color
Date: Wed, 28 Nov 2007 01:58:59 -0600
Message-ID: <474D1FC3.50108@zwell.net>
References: <200711231904.53551.jnareb@gmail.com>	<7vabp4u40y.fsf@gitster.siamese.dyndns.org> <7vir3mal9u.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 14:23:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKvB-0004A0-MZ
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 12:17:37 +0100
Received: from mail-mx9.uio.no ([129.240.10.39])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxHyD-0000a4-GX
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 09:08:33 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx9.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxHx6-0006xT-7R
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 09:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbXK1H7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 02:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbXK1H7i
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 02:59:38 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:4204 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbXK1H7h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 02:59:37 -0500
Received: by py-out-1112.google.com with SMTP id u77so2756358pyb
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 23:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=R+/FAvBJOzhSJf+hlPqbEv1XRKaO0v0ZSeD2c09uQeU=;
        b=CdC5AxwfAH+tru1yfN6u3q09MzLcYLjLZl5RMf/S2adDRF5JopPqAyDlsoKVL1cb6vrddbadBXR0203w0uA0zGE8SE73X7BXqoIZxKugP98aROTW1GpvSUNNXuxjlOe15l1yKzrIRjq04ABTImRx8K5/+Jx48xY+D2UzudZ9QyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=qiTG+7t8ugzFTNpW3hFj3ncZ2OBjIwNekEpgSxluruyQ3p7xgdGESE0GftX8+TcfsJDLImls0q0eKo+xOJI+/ZvVHYDyMSaDpbhM4ThK9Gqqaq1F/O4/PxBDxHLeDjpOPuBH04NJhRHOSl7acwNWoPwp72XP62FSN74vZvhW5pU=
Received: by 10.35.36.13 with SMTP id o13mr5833346pyj.1196236777009;
        Tue, 27 Nov 2007 23:59:37 -0800 (PST)
Received: from ?143.44.70.185? ( [143.44.70.185])
        by mx.google.com with ESMTPS id f45sm835540pyh.2007.11.27.23.59.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Nov 2007 23:59:34 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (X11/20071121)
In-Reply-To: <7vir3mal9u.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: 7D0DBD2DD8FD4892F8E0A11C1CEB6F2250400BF5
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 200 minaction 2 bait 0 mail/h: 13 total 724084 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66322>

Junio C Hamano wrote:
> +--get-color name default::
> +
> +	Find the color configured for `name` (e.g. `color.diff.new`) and
> +	output it as the ANSI color escape sequence to the standard
> +	output.  The optional `default` parameter is used if the
> +	configuration for `name` is missing.
Perhaps you could mention here that the second parameter is a normal 
string, not an ansi code? Just adding 'for example, "blue"' would 
probably help.

 > +RESET==$(git config --get-color "" "reset")

This is a typo, no?
+RESET=$(git config --get-color "" "reset")

Dan
