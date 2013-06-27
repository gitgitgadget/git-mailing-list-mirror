From: Junio C Hamano <gitster@pobox.com>
Subject: Re: contrib/mw-to-git/Git/Mediawiki.pm
Date: Thu, 27 Jun 2013 11:07:40 -0700
Message-ID: <7vip0zs9zn.fsf@alter.siamese.dyndns.org>
References: <51CC6189.6030701@web.de>
	<CAETqRCgctnVqrYaAYn7uZtv0rvQNawUAi513iTeWPufkZPRgAw@mail.gmail.com>
	<vpq4ncjcxt4.fsf@anie.imag.fr>
	<7vzjubsbqj.fsf@alter.siamese.dyndns.org>
	<CAETqRCif7K3MZiG4oMfnM-jps+KajDMYML4C5Hhy8eE7bj38xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Torsten =?utf-8?Q?B?= =?utf-8?Q?=C3=B6gershausen?= 
	<tboegi@web.de>, Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Beno=C3=AEt?= Person <benoit.person@ensimag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 27 20:07:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsGbk-000369-HE
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 20:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714Ab3F0SHo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Jun 2013 14:07:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35046 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753547Ab3F0SHn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jun 2013 14:07:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F22B02AA0A;
	Thu, 27 Jun 2013 18:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=N48Le3bfSkbE
	kzKgp+t0nlggxr0=; b=FnpPFikRXbLk8M4XQTH7HbARZYmEK0OQNO4bwRyQ21Gz
	AYQVfNdeCS7r5bePdzhCKGTZMIIz6KSEDLCXVwfYrQ1LdHeBEJUZEPgEMIGPsbka
	yQP1iDWVN6o0ZUzi+09nJzH16j6uWXH+9gO2VrlGb9SEEs8tpm7YAAUXtb5wHRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=g7Ubu9
	dA1wZtJPupZMdkmqYWQn9p8DxIim6H0UqDcPC95Fj4jxZqiITutziiBAm43axXML
	hENFbE13HiuFB6xko7jIz5Z3TzWh7ESKkEctv7QIIFM7fASvBgf5XfQEhSTmc/pI
	IEvXT4UnuUUQHVKOrFdcyKRPunE9zL/g0Ypkc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6F082AA09;
	Thu, 27 Jun 2013 18:07:42 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 66DD42AA08;
	Thu, 27 Jun 2013 18:07:42 +0000 (UTC)
In-Reply-To: <CAETqRCif7K3MZiG4oMfnM-jps+KajDMYML4C5Hhy8eE7bj38xA@mail.gmail.com>
	(=?utf-8?Q?=22Beno=C3=AEt?= Person"'s message of "Thu, 27 Jun 2013 19:54:36
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 75FCF4B2-DF54-11E2-B464-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229138>

Beno=C3=AEt Person <benoit.person@ensimag.fr> writes:

>> I just noticed that the script is not strictly a text file, ending
>> with an incomplete line, by the way.
> an incomplete line ?

http://pubs.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap03.html=
#tag_03_194
