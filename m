From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] test: use unambigous leading path (/foo) for mingw
Date: Tue, 17 Sep 2013 09:19:01 -0700
Message-ID: <xmqqd2o71kwa.fsf@gitster.dls.corp.google.com>
References: <cover.1379048276.git.worldhello.net@gmail.com>
	<6533cbb59cd4de1d616ef62898f64a5cd144a561.1379048276.git.worldhello.net@gmail.com>
	<xmqqtxhoijpz.fsf@gitster.dls.corp.google.com>
	<523407AF.9080205@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Tvangeste <i.4m.l33t@yandex.ru>, Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 17 18:19:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLxzb-00059Z-SW
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 18:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058Ab3IQQTH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Sep 2013 12:19:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46656 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753008Ab3IQQTF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Sep 2013 12:19:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25B1640246;
	Tue, 17 Sep 2013 16:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5bimzVbUszv5
	bIprVA/ijkNxB6s=; b=q9oIqEkWRzpjO2yLTPzU7+83EYARjNkQfzMLuBi86NAN
	tKOL1Rz74aG+OCGJqUuTiTCEE64pyJYzlNevHJe4bbQ/Q1IxZWBtxp8vz6HUlDKp
	aE1zA/H2tbDLBC4Cflv5XJXOtnbGdT4UJvWgbh6TWDEP7AWEy/Rhi9lYk0vH5O8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nvtHRl
	I8gBrGx3FFT0c9uWG6L15fabcrCcF6jfafPX9ToK3l2xwDgjOcBOmWuOX0GfzakI
	HIbEl26zFscvWhgB5Acj5+dObw3Cl9/spwHETnThn2Y6q5g15dhR4iS2G+Ih+Nac
	58+nRYli+VJvITzS0J5cZ85A2bAEa14Q9g18o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A82340245;
	Tue, 17 Sep 2013 16:19:05 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62C8B4023D;
	Tue, 17 Sep 2013 16:19:04 +0000 (UTC)
In-Reply-To: <523407AF.9080205@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sat, 14 Sep 2013 08:52:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DED2559A-1FB4-11E3-9A6F-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234882>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Yes,
> there is a directoctory structure in / like this:
>
> /usr
> /bin
> /lib
> Then we have the drive letters mapped to single letters:
> /c/Documents and Settings
> /c/temp

Thanks.
