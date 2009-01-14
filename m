From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH next] git-notes: fix printing of multi-line notes
Date: Tue, 13 Jan 2009 22:48:17 -0800
Message-ID: <7v3afm758u.fsf@gitster.siamese.dyndns.org>
References: <496CF21C.2050500@trolltech.com>
 <alpine.DEB.1.00.0901132339270.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tor Arne =?utf-8?Q?Vestb=C3=B8?= <tavestbo@trolltech.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 14 07:49:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMzZT-0005O3-Uj
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 07:49:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbZANGs0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jan 2009 01:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752104AbZANGsZ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 01:48:25 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62417 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbZANGsY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jan 2009 01:48:24 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1AF8F90747;
	Wed, 14 Jan 2009 01:48:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1216190746; Wed,
 14 Jan 2009 01:48:19 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901132339270.3586@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Tue, 13 Jan 2009 23:40:14 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 56D7A838-E207-11DD-89BA-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105590>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 13 Jan 2009, Tor Arne Vestb=C3=B8 wrote:
>
>> The line length was read from the same position every time,
>> causing mangled output when printing notes with multiple lines.
>>=20
>> Also, adding new-line manually for each line ensures that we
>> get a new-line between commits, matching git-log for commits
>> without notes.
>>=20
>> Signed-off-by: Tor Arne Vestb=C3=B8 <tavestbo@trolltech.com>
>> ---
>
> Patch looks good, so=20
>
> Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> For extra browny points, you could add a test with multi-line notes.

Yeah, not just "extra", having tests is a good way to make sure a new
feature like this evolves healthily.

Tor?
