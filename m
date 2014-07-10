From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitignore: add .version as this is generated during a make
Date: Thu, 10 Jul 2014 16:19:42 -0700
Message-ID: <xmqqy4w06bu9.fsf@gitster.dls.corp.google.com>
References: <1405032485-26117-1-git-send-email-jacob.e.keller@intel.com>
	<20140710231334.GE12427@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 01:19:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5Nd4-0003Ko-EK
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 01:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbaGJXTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 19:19:50 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53572 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750886AbaGJXTu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 19:19:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1C2AE281C3;
	Thu, 10 Jul 2014 19:19:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BDQRsCTlkkGlqqTgpZs1BKkY/bw=; b=SI7JRv
	xDbORO5KhYEhxvdL4yyBDyREeAug16IZXSS64SkBmzq331PGRGtZyRmyoYLll6Vn
	ZvlQgpbsnECy2OVkqq9oOsiFvyCcvkEQcVjNaR/gC3ZYJSfElt+2crx2mEdoZqSe
	yALvB4AzYYhb/J8sRSpJBGRj2AxwQAp06CRMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=atVwkeOjjcY/tK89pY/clti9XHI4j7+t
	PPXhj48PUZwFOmrjxh9kieMQV0sHt0VTmqF98y1B9yKeiAwmH9ipGOVTXG/6gEJw
	RJhNw6oGDEzUc5qDviYsapeoHsn46aqVSvRchLDHnLs8NSxALCT3/WprI6sr+jRJ
	bvcPBmsYEtE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 12159281C2;
	Thu, 10 Jul 2014 19:19:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D214D281BF;
	Thu, 10 Jul 2014 19:19:28 -0400 (EDT)
In-Reply-To: <20140710231334.GE12427@google.com> (Jonathan Nieder's message of
	"Thu, 10 Jul 2014 16:13:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A40AFC2E-0888-11E4-A08B-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253231>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jacob Keller wrote:
>
>> Subject: gitignore: add .version as this is generated during a make
>
> What program generates that file?  When I build on a Debian machine, I
> get
>
> 	$ make
> 	[...]
> 	    SUBDIR templates
> 	$ ls -la .version
> 	ls: cannot access .version: No such file or directory
>
> Curious,
> Jonathan

We add one for supporting a build from tarball, but I do not recall
writing nor paying attention to a dot-version.
