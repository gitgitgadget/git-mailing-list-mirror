From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Weird behavior of shell variables in git aliases
Date: Tue, 22 Mar 2011 10:36:32 -0700
Message-ID: <7vk4frkqfz.fsf@alter.siamese.dyndns.org>
References: <d9c38309-c433-476c-bba3-f2c5b7e94a89@k15g2000prk.googlegroups.com>
 <20110321215310.GA2122@sigill.intra.peff.net>
 <7v8vw8nmh2.fsf@alter.siamese.dyndns.org>
 <7v4o6wnlxm.fsf@alter.siamese.dyndns.org>
 <20110322111844.GA32446@sigill.intra.peff.net>
 <20110322132820.GA14559@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Dun Peal <dunpealer@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 22 18:36:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q25Vk-0000IH-2v
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 18:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756496Ab1CVRgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 13:36:48 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58046 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615Ab1CVRgr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 13:36:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 876FE46E0;
	Tue, 22 Mar 2011 13:38:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=77hOCa0aXlAz8A6KJc+/uvqGOqk=; b=QWipIs
	S5WEJMRXoMR5wh1j1VKq9+zN7k9uaQp+KVjuEmk00A/QVhBzHkbbqJWjhDwIi89B
	/QLuwqIarVlgMM01ACeXWvRCP1TzZ/JRRl95qqJxwGDyORJRi8wFpl8Gdn/j5Q3R
	dcEXPTOZmWX2Ul2guEz3gc8r4UpWoNQsNKQz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DjNVOv0BLZNBSCIF/xyMKKj9O3cQBDIG
	mfXOCmpNdO2DwAr+ESDlPTWXUOoAFh4EN2UxQvSeLD/L83pWemsrJQKJIVIFyLrP
	d/l+vmmNXVV7VHTyByh8/JjLhj3akzu351apKn+sJp0/cYj/ZZsFOExQIYQRGEq5
	uiU/xD0Kld8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 44DDA46DB;
	Tue, 22 Mar 2011 13:38:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0316F46DA; Tue, 22 Mar 2011
 13:38:12 -0400 (EDT)
In-Reply-To: <20110322132820.GA14559@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 22 Mar 2011 09:28:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2C631F24-54AB-11E0-8D03-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169753>

Jeff King <peff@peff.net> writes:

> ... q&d hack to grep for $1 and the like without really parsing...
> But I think that is a little too magic for my taste.

Let's not go there.
