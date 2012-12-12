From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/6] git-remote-helpers.txt: document invocation
 before input format
Date: Wed, 12 Dec 2012 15:03:34 -0800
Message-ID: <7v62463mbd.fsf@alter.siamese.dyndns.org>
References: <1354057407-83151-1-git-send-email-max@quendi.de>
 <1354057407-83151-2-git-send-email-max@quendi.de>
 <CAMP44s3vO9b4-XxqatEc2w3KJLqLGgyjPuKpQkAXHQwTJJEQTg@mail.gmail.com>
 <839EECE2-4459-4358-B7E8-5D64374A0540@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Thu Dec 13 00:04:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TivLG-00071v-NP
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 00:03:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755499Ab2LLXDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 18:03:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58991 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754013Ab2LLXDh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 18:03:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AD72A07E;
	Wed, 12 Dec 2012 18:03:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=focMJM0XxZp8vJbCJajmobMKhCY=; b=s60WpK
	hIQG6RqVi0UbJTt1bXKK5siN3IUaMZAZS0aNMnQOAaqPnNV2l/gnzZhdeV22iaLg
	TKQrjdZ07WZDw61wb3YribOSzb0NgkB/4d8twsHOXk7mQIDNkhPXa5BhxbTh8Q/B
	uhz784N6ZogtU5By0PzzOFL9p5vLGuzdCQ15c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NvlBh3G4RFWr2P+ZUlpPXEJYfi9lDDBb
	dHrKuSjVZgHZ2STUXezV7UXh+HBifqCuBgj7jbYaL1Ai2u+tYWUnc8NhYDiyI3e1
	PfxiZ+0HQh9pxAmuhtB4QH7xBGJ41lT1mixOX7KFrQ8SVzJ4xnj9KTiZnnmeslgg
	LY/+wUeo8Ms=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56558A07C;
	Wed, 12 Dec 2012 18:03:36 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D021CA078; Wed, 12 Dec 2012
 18:03:35 -0500 (EST)
In-Reply-To: <839EECE2-4459-4358-B7E8-5D64374A0540@quendi.de> (Max Horn's
 message of "Wed, 12 Dec 2012 23:58:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 287ABBD2-44B0-11E2-BD88-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211411>

Max Horn <max@quendi.de> writes:

> Worth a thought yeah -- but beyond the scope of this patch: I
> merely moved this text around, but did not touch it otherwise.
> ...
> Yeah, I also thought about that, but as above, deliberately did
> not touch it here, but only moved it around. I'll be happy to
> revisit this on a future date, though.

That sounds like a sensible approach.  So what's been cooking on
'next' is OK, it seems.

As this is merely a doc update, I may be tempted to merge it down to
the 'master' branch before the next -rc.

Thanks.
