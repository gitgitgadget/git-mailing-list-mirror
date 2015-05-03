From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] blame: CRLF in the working tree and LF in the repo
Date: Sat, 02 May 2015 19:02:25 -0700
Message-ID: <xmqq383exvta.fsf@gitster.dls.corp.google.com>
References: <55436852.3030002@web.de>
	<xmqqbni4xlt7.fsf@gitster.dls.corp.google.com>
	<5543CC97.4080702@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, kasal@ucw.cz
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun May 03 04:02:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YojEr-0005XO-Vw
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 04:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbbECCC3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 May 2015 22:02:29 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51341 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750955AbbECCC1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 May 2015 22:02:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C6834E5A9;
	Sat,  2 May 2015 22:02:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wLwx6hQmZ31m
	NJEZUc6JNy+QT2o=; b=o5bwmjalQPVqhRkMvQDbCRym11cF1WVD0/srK5yx2A8H
	q+LpMDF/mTpgEjZIePvGyvQIsx+2dByqjpPIimNJ13bqJq0eTkDsnY4gYRHBUEEX
	r2r9IsjPL3RSMce1O7o6l53Xjo9UCBMwxMXoc5e3QehZJNtz9XkIkSgqMLSd0wE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=B3GMQc
	Y1lgYPqGz6nzdHLYf/l5jWRMnEaZupj1zls5hRPbMtz+DO1njIuphY+o3AHC7P5j
	Clty4ZCwqovonewugnAULEI8UwgtH1Lk0ca7+9CerdrVBzN70h62EvReQgc/mSpD
	6ZHxJXNS0MjAt2RTrjclT9aLzlUnBbVqvJ/Ws=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 20BF54E5A8;
	Sat,  2 May 2015 22:02:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C01E4E5A6;
	Sat,  2 May 2015 22:02:26 -0400 (EDT)
In-Reply-To: <5543CC97.4080702@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Fri, 01 May 2015 20:57:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7253EB34-F138-11E4-BFE7-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268247>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> And is there a chance to correct my mis-spelling ?
>
> s/A typicall/A typical/=20

Well, I didn't intend to keep an amended old version, especially
when you are actively working on polishing it to submit an updated
series.  Please make sure you have that correction in the rerolled
version, which separates revert and other things.
