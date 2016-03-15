From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-p4: map a P4 user to Git author name and email address
Date: Tue, 15 Mar 2016 09:52:56 -0700
Message-ID: <xmqqbn6f8yzb.fsf@gitster.mtv.corp.google.com>
References: <1456829396-38659-1-git-send-email-larsxschneider@gmail.com>
	<CAPig+cRwEKjGaDA-jy8KJSAhTheJYDmxtPq8SdVs0LA2f9-9Yw@mail.gmail.com>
	<CAE5ih7_EAjMtdNQ6ab2wrN4LMSBBZ=T7w-fPKLtdRqfvFUhzFQ@mail.gmail.com>
	<61210CAD-D3D2-40AC-88F9-02169619F5F6@gmail.com>
	<CB4CAAEA-0036-483A-9F2C-89B95E04037E@gmail.com>
	<CAE5ih79aKHM5yim-U_sauZ7ChgWR82CAre4EC3j5HQ8CCG=w_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue Mar 15 17:53:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afsDY-00050b-6i
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 17:53:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbcCOQxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 12:53:07 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55554 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753188AbcCOQxF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 12:53:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9EC094C701;
	Tue, 15 Mar 2016 12:52:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2hqE8OMtM22jd8A4q8rgcfjsNhk=; b=gctmlw
	38je9XaetHDmY78YdjD9BIlnBmGM4XEkO/QSidyShblPOOhJ/8Ohq4LK6LXyFd59
	Nr3J7MYd5c1kN0fpNaa06kO+YB0dEYnwtBhMUIfL+bzd2gN1G0aqmrUFfC1/CXft
	tborZXC2Z/JsyXOHeKw2+j7NMmaY/+9jIV9UM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qNPIMM/NNuC5k8zNx67143SPlVr91xYy
	L15871HuyzEEE2p9VmcBbb3uW2dXXkHwaFS2Ptm6iHNT92OPO/n9pWr/QQzb+Jjf
	D1Jp25/PmwmwPHF9tY0vUvZ3XSwIfSHlV+LZukcWx2XzTiMymQslQWN+pfwjj088
	gE+YALE93nE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 96C624C6FF;
	Tue, 15 Mar 2016 12:52:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 01EAE4C6FE;
	Tue, 15 Mar 2016 12:52:57 -0400 (EDT)
In-Reply-To: <CAE5ih79aKHM5yim-U_sauZ7ChgWR82CAre4EC3j5HQ8CCG=w_Q@mail.gmail.com>
	(Luke Diamand's message of "Tue, 15 Mar 2016 07:19:12 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5EDB0EEE-EACE-11E5-9B03-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288881>

Luke Diamand <luke@diamand.org> writes:

>> Is the patch uninteresting for git-p4 as it handles only an occasional
>> exception or did the patch get lost in the noise? :-)
>
> I thought it was useful; I hadn't realised that it was needed for deleted users.
>
> Luke

So..., should I just pick it up and queue with your Reviewed-by:?

Thanks.
