From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] generate-cmdlist.sh: avoid selecting synopsis at
 wrong place
Date: Mon, 01 Dec 2008 06:11:33 -0800
Message-ID: <7vtz9oq92i.fsf@gitster.siamese.dyndns.org>
References: <1228042478-1886-1-git-send-email-pclouds@gmail.com>
 <1228042478-1886-2-git-send-email-pclouds@gmail.com>
 <alpine.DEB.1.00.0812011505551.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 01 15:14:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L79Wu-0007RK-J2
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 15:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbYLAOMV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Dec 2008 09:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbYLAOMV
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 09:12:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46382 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578AbYLAOMU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Dec 2008 09:12:20 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B364917E37;
	Mon,  1 Dec 2008 09:12:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D677717E2C; Mon, 
 1 Dec 2008 09:11:35 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0812011505551.30769@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Mon, 1 Dec 2008 15:10:38 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 10C21580-BFB2-11DD-B2F5-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102038>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 30 Nov 2008, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> In "common" man pages there is luckily no "NAME" anywhere except at=20
>> beginning of documents. If there is another "NAME", sed could mis-se=
lect=20
>> it and lead to common-cmds.h corruption. So better nail it at beginn=
ing=20
>> of line, which would reduce corruption chance.
>
> I have no idea why you put this into the sparse checkout patch series=
=2E

That is because a documentation that triggers the misfortune this patch
fixes is introduced in the series.  I actually scratched head myself,
though, and come to think of it, I should have complained that this pat=
ch
should state that because it does not look like it has anything do with
the main topic of the series.

> As it is, the patch series is _already_ hard to review (as it is larg=
e not=20
> only in term of number of patches, but also individual patch size),=20
> _especially_ given the fact that there is no clear, precise and short=
=20
> description of why/how the sparse checkout is implemented.

Hmm, can you really tell the lack of such description without reading t=
he
series, I have to wonder...
