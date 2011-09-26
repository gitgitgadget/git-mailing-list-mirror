From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: Use args as pathspec to unmerged files
Date: Mon, 26 Sep 2011 09:40:14 -0700
Message-ID: <7v4nzz5kb5.fsf@alter.siamese.dyndns.org>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org>
 <7vipox2wd6.fsf@alter.siamese.dyndns.org>
 <D3CA81F2-647B-4AD0-A4FC-4C22772FD791@JonathonMah.com>
 <7vsjnysuyl.fsf@alter.siamese.dyndns.org>
 <C5AD8BFC-DA48-4CE9-B821-D0076825F33C@JonathonMah.com>
 <7vaaa4fdix.fsf@alter.siamese.dyndns.org> <20110925004459.GA19780@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathon Mah <me@JonathonMah.com>, git@vger.kernel.org,
	Dan McGee <dpmcgee@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 26 18:40:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8EEB-0003Bg-Ph
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 18:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018Ab1IZQkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 12:40:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61171 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751896Ab1IZQkR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 12:40:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A93375502;
	Mon, 26 Sep 2011 12:40:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BQJ0diJrTcAxV7oDwc+ufx4LPW0=; b=ur58QJ
	5LBzZ6M7hlLFgqH61qYrHamDAsYcLzDrpKJ4/S7X9ThrBOpMzBwUw1Tna7wlRyWV
	pssaXKVLDOvrImBgT98w+8pPT2UygMNGjjL6rcXGyGyhEM1+574n4JeKrpVOMrOv
	Kx+vBfEXmBpodqYRayAMcFWexQ8C5q3731AMg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IQJuKxidBfNScAntBHgDtpv5kZ6UviU1
	OEAAXkOSYtj10nlHrcTCldmvLuEBuGj2Ipd8Ebeo8VtJ+QFsjJZIXzl1oA7xfqRa
	+2T0zy4Fw776Y4zLcv6MVUg3YVtkkcNOxQHR9zPxQRSn63kUdryryjoHgwHlqo+x
	E/9wVYK9C/g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F92B5501;
	Mon, 26 Sep 2011 12:40:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 366F15500; Mon, 26 Sep 2011
 12:40:16 -0400 (EDT)
In-Reply-To: <20110925004459.GA19780@gmail.com> (David Aguilar's message of
 "Sun, 25 Sep 2011 02:45:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 36A329C4-E85E-11E0-86AB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182130>

David Aguilar <davvid@gmail.com> writes:

>> Ack from mergetool/difftool folks?
> ...
> Acked-by: David Aguilar <davvid@gmail.com>
>
> Being able to do "git mergetool -- subdir" is very nice!
> Thanks guys,

Thanks.
