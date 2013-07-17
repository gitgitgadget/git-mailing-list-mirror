From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] apply, entry: speak of submodules instead of subprojects
Date: Wed, 17 Jul 2013 13:34:38 -0700
Message-ID: <7vhaft53j5.fsf@alter.siamese.dyndns.org>
References: <87bo631odi.fsf@hexa.v.cablecom.net>
	<8df0d41caa10a38e46783bebd3148a7b8445dd47.1373966389.git.trast@inf.ethz.ch>
	<20130716180739.GK14690@google.com> <51E5997E.2090607@web.de>
	<8738res1yc.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>, <git@vger.kernel.org>,
	"Ralf Thielow" <ralf.thielow@gmail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jul 17 22:34:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzYQv-0006gx-Sp
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 22:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033Ab3GQUem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 16:34:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45293 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751985Ab3GQUel (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 16:34:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 557953147E;
	Wed, 17 Jul 2013 20:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hjMzzV469gcTEBkMUOy8UpYC3ho=; b=i7JDSp
	7BOXZHFJzbcMfCkqqWjjOBMum7fq+xMxR8fx0fWQnsT3j3nxBzpgWRcb88U7t1rq
	Kzsx7pWCEydcMowsmQQDfwQ8tNfUtsFtA+g5i3ghfHm8VvPoNGe7nUgueuQW1Jsr
	nSlim9TdkgCkSyZ5ysDoIss3+KDzDTp+PR4iU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uMX7DzMIIvLvjVb165QLFMLnZlIZNffT
	//HYk0FlY2Em58JCbx6dZzsUdsnYuqk7Bgh9FYCkhs0dqSXRcMRiNo9+J0sgurEz
	znfPFC/2NhGo37pqUGJCNgU6gZfC7I/91wLlaL0CEOywvh3C2gqBeW7m51Ogbf6b
	lmWlweWmIKk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 463543147B;
	Wed, 17 Jul 2013 20:34:40 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9AED931477;
	Wed, 17 Jul 2013 20:34:39 +0000 (UTC)
In-Reply-To: <8738res1yc.fsf@hexa.v.cablecom.net> (Thomas Rast's message of
	"Tue, 16 Jul 2013 22:07:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4DC41904-EF20-11E2-8240-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230648>

Thomas Rast <trast@inf.ethz.ch> writes:

>> But a 'git grep "corrupt patch for sub"' shows some files in the po
>> directory still containing that string on current master. Shouldn't
>> they be changed too or is this just a sign of me not understanding
>> the translation process?
>
> I haven't checked any guides, but I imagine that the resulting manual
> translation update is what prompts the translators to also check if they
> need to adapt the message.

I would suggest to leave the *.po files as they are.  I suspect that
some translations might already use a translation of "submodule",
and others use "subproject". All of them should make sure their
translation is appropriate when *.pot is updated.
