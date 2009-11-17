From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Make Gitweb behave like Apache mod_userdir
Date: Tue, 17 Nov 2009 14:10:27 -0800
Message-ID: <7vd43gerak.fsf@alter.siamese.dyndns.org>
References: <7fce93be0911150204h259b7424md251c54186d05b7d@mail.gmail.com>
 <7vhbssewm7.fsf@alter.siamese.dyndns.org>
 <7fce93be0911171224r1cfc438ay7b38b81646154a23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Tue Nov 17 23:10:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAWG4-0000uB-F7
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 23:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754351AbZKQWKc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Nov 2009 17:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753666AbZKQWKb
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 17:10:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38629 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014AbZKQWKb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Nov 2009 17:10:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D197F9F906;
	Tue, 17 Nov 2009 17:10:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KXGlcYoGv7kM
	em+3iWhD8hnhAWs=; b=AZoFv5b7EWRYYs+OP8DpJF74EzXquHE64UurUBEqZR5R
	dCy8HGBU1ZNce/OqwHZ+h/7aqURw+owq7IBMIYvVFcWNgkJfyi4v98uTF4eAotr1
	1hp/gEzP/AGq0Itxy0uD6z2NR1HHEp8HVPOFTNqSTTujzqVhy1bIRyumVgy4nuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NnHc4k
	/Egqaq96HcEPuuNZO7HrrprMTHhjEyUER0coyHS7zBjwLSbntErjrwUDJZ3eIrf/
	UtbutcHkjFEGzhZ6bOWsTKMC0VbgUgRMOQZaj+wbIpg6CH49EdcHBX5CULHZUlgV
	D3RQr4QzIA4vncgeTJuNYBGlrR53E0lRmeKV0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9C5B09F905;
	Tue, 17 Nov 2009 17:10:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 181C79F904; Tue, 17 Nov 2009
 17:10:28 -0500 (EST)
In-Reply-To: <7fce93be0911171224r1cfc438ay7b38b81646154a23@mail.gmail.com>
 (Sylvain Rabot's message of "Tue\, 17 Nov 2009 21\:24\:54 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 06A03C66-D3C6-11DE-AF87-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133104>

Sylvain Rabot <sylvain@abstraction.fr> writes:

>> Wouldn't it be a good idea to somehow make this work well together w=
ith
>> the --user-path feature of git-daemon?
>>
>> Perhaps the recommended name given in the example shouldn't be ~/git=
web,
>> but more like ~/public_git, as this is like ~/public_html but for gi=
t
>> repositories. =C2=A0Then the end users will browse
>
> As I said, it's configuration :)

Wrong answer.

Exactly because it is configurable, the document that outlines the
recommended practice should suggest the best convention.  My point was
that it is likely to be tied to "git"-ness of the specified directory
under $HOME/, not limited to "gitweb"-ness, and it is wrong to recommen=
d a
name tied to "gitweb"-ness in this document.
