From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] Documentation/urls: Rewrite to accomodate 
 <transport>::<address>
Date: Sun, 18 Apr 2010 14:56:55 -0700
Message-ID: <7vvdbov2zc.fsf@alter.siamese.dyndns.org>
References: <1271552047-sup-9523@kytes> <20100418025940.GA2249@progeny.tock>
 <1271566767-sup-7167@kytes> <7vk4s4wqo5.fsf@alter.siamese.dyndns.org>
 <m2pfabb9a1e1004181144x10f6a0f1x2e55bc025aba781b@mail.gmail.com>
 <7vzl10v5mo.fsf@alter.siamese.dyndns.org>
 <w2gfabb9a1e1004181410ia09cc99o1ba807b53744f3ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 23:57:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3cUU-0006eb-MH
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 23:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753791Ab0DRV5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 17:57:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39519 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672Ab0DRV5P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 17:57:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FDA9AC10A;
	Sun, 18 Apr 2010 17:57:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Yid9JFWthpqYa2xZwtsZJpcm7Gs=; b=rPTHzQ
	ZNKZkoZvlIbz4A1hmEsR8U7qIX8GzcAOt4DucIkiqh+QT89VZvmQR/3Iy8LbzYFi
	8LYSPRj7tAB5aFnQfUNRmNckCDrIzgaz0f9YLGId21BOzLARhkRz+usQHguOcdVB
	mUX3/mOA+3u2fpS354IMOJ2jT4z/7zUSaIGho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l3n4k3tnUpas5TjEDvpmCUF6qosa53Dr
	U3d8wyYw9Nu0vJp9tuppD92GLMI1bs2mOBMFPqQRRy2JoKzDt9ffKCgYHkOTPiqy
	7BHv36yk4sYzjED6Rgm29i5z+UlB6v3wee65WcJ7AidseuzV/JLotzkv4W4rnpXZ
	1D5OqxVklww=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2048DAC107;
	Sun, 18 Apr 2010 17:57:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 09619AC103; Sun, 18 Apr
 2010 17:56:56 -0400 (EDT)
In-Reply-To: <w2gfabb9a1e1004181410ia09cc99o1ba807b53744f3ee@mail.gmail.com>
 (Sverre Rabbelier's message of "Sun\, 18 Apr 2010 23\:10\:16 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 541DF79E-4B35-11DF-9BB4-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145252>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Sun, Apr 18, 2010 at 22:59, Junio C Hamano <gitster@pobox.com> wrote:
>> Thanks. The end results look good to me, too.
>
> Hmm. Do we want to get this into 1.7.1? With how much debate this
> series has had I don't see much added benefit from having it cooking
> in next.

I don't think this is that _urgent_, but on the other hand I don't think
this is with heavy-enough impact that needs to be out of the coming
release either.  As long as there aren't any glaring factual errors or
formatting breakages, I think it is safe to merge it and get it over
with ;-).
