From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* manpage for git-pull mentions a non-valid option -m in a comment
Date: Tue, 14 Jan 2014 11:39:49 -0800
Message-ID: <7v61pm1hfe.fsf@alter.siamese.dyndns.org>
References: <loom.20140114T025825-557@post.gmane.org>
	<xmqqvbxm4dyq.fsf@gitster.dls.corp.google.com>
	<52D5874D.7070102@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ivan Zakharyaschev <imz@altlinux.org>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 14 20:40:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W39qO-0002y0-M6
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 20:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbaANTjh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jan 2014 14:39:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47207 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543AbaANTjf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jan 2014 14:39:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BD4561D6A;
	Tue, 14 Jan 2014 14:39:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NqcBvDy+Bzo0
	oU85XfoMVSF22is=; b=L0ikJZRxPINXboZ8peJduLM++xFfOOgLI/rRIQCDWCjO
	t4EjVRaEEWAO+AS788gSnl/CMeo4ovKFuqyuYo3W+Y8kknWJVQlRSeOlxEUg8H1/
	dWZ/XRXffNNjeEwQF4J4YoR7f6J5SskXoTxZJSs2qjPnq0y8yIzwDUY/z3pVNAY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gIrdUE
	mbY/pg/hAqD0yp1WZDm55ULIcquu2WvC1xMBuR3TfZjwFLcSWQYlUIxW6m1XRSbs
	mzAzMfujKaqgooaWmppvNxhfWmxXAYZ66NyxOFuRc6hefDfWC4lMDh4A10ABkgcy
	O6PntbovRPRXQ+xo4RrERxQMwYHvTK4b47nJg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A31F461D65;
	Tue, 14 Jan 2014 14:39:32 -0500 (EST)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7FB0F61D5C;
	Tue, 14 Jan 2014 14:39:30 -0500 (EST)
In-Reply-To: <52D5874D.7070102@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Tue, 14 Jan 2014 19:51:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: 961A4B76-7D53-11E3-B5F6-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240409>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> Subject: Documentaiotn: exclude irrelevant options from "git pull"
>            ^^^^^^^^^^^^^^
> (Small nit ??)

;-).

They are now a small two patch series, with typofix for the above.
