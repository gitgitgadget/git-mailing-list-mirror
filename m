From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] Remove deprecated commands
Date: Tue, 01 Feb 2011 14:16:18 -0800
Message-ID: <7voc6vxux9.fsf@alter.siamese.dyndns.org>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org> <4D4852EE.6080605@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Feb 01 23:16:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkOWU-0006dl-UV
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 23:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062Ab1BAWQ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 17:16:26 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40514 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703Ab1BAWQZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Feb 2011 17:16:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E58814C40;
	Tue,  1 Feb 2011 17:17:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=eOyFguf+L8wQ
	KFFOyA2Mo+U53e8=; b=ihKs6cpnPjma9hJTHdf5KbgdRLoO0FwMhgz6djxULbls
	T5QsZEnjSwp+KMoemoweQHA+04SCtX8F3rIf/xkP1yB191imGTgYA3x3ykmlbfn3
	G0OpaAYx1eV3HMabZxU9hVRZbn15b4lfmLBnSGOearSR+5IQVHAC2eXCTfETHGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UKY62H
	080RQwuu2ePWkqMp2lIewri3ZRfGlj2NCHwo2Ek7imYYZCw+iiO/muLlC/SK+qu4
	P54tKJxFT68S/zGEFjxqoUo5H8x8DPd94keUkR3YhLC3fgYGUZ+ztAQuxtv50W22
	YjaGWLmOgZCWuhzokzrYuccPiLP6uQAShHz54=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C299B4C37;
	Tue,  1 Feb 2011 17:17:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CEC0B4C32; Tue,  1 Feb 2011
 17:17:11 -0500 (EST)
In-Reply-To: <4D4852EE.6080605@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Tue\, 01 Feb 2011 19\:37\:34 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 05EA4A46-2E51-11E0-9BCC-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165869>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> The following four commands have been marked as deprecated in
> command-list.txt for quite some time[*]:
>
>    command          deprecated since replaced by
>    ---------------- ---------------- ---------------------
>    git-lost-found   2007-11-08       git fsck --lost-found
>    git-peek-remote  2007-11-24       git ls-remote
>    git-repo-config  2008-01-17       git config
>    git-tar-tree     2007-11-08       git archive
>
> Let's just remove them.  There's a risk that someone is still using t=
he
> old commands, of course, but they have been deprecated long enough no=
w.

Sounds fine.
