From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: git-tag '-m' implies '-a'
Date: Mon, 24 Mar 2008 13:07:15 -0700
Message-ID: <7v1w5zvqbw.fsf@gitster.siamese.dyndns.org>
References: <47E7BDB2.3030304@dirk.my1.cc>
 <20080324194308.GE14002@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 24 21:08:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdsyL-0000Mh-KE
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 21:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825AbYCXUH2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2008 16:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754261AbYCXUH1
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 16:07:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53155 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825AbYCXUH0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 16:07:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8D3012FC5;
	Mon, 24 Mar 2008 16:07:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BDB5D2FC3; Mon, 24 Mar 2008 16:07:19 -0400 (EDT)
In-Reply-To: <20080324194308.GE14002@coredump.intra.peff.net> (Jeff King's
 message of "Mon, 24 Mar 2008 15:43:08 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78090>

Jeff King <peff@peff.net> writes:

> From: Dirk S=C3=BCsserott <newsletter@dirk.my1.cc>
>
> Described that '-a' is implied when '-m' or '-F' is present.
> ---
> On Mon, Mar 24, 2008 at 03:41:54PM +0100, Dirk S=C3=BCsserott wrote:
>
>> Described that '-a' is implied when '-m' or '-F' is present.
>
> Oh, I see you already took my suggestion before I made it. :)
>
> The text looks good to me, but the patch would not apply here. I thin=
k
> there are some wrapping issues, and it looks like some tabs have been
> mangled to spaces.

Thanks for tidying up.  It makes my life easier.

> Also, it is generally a good idea to:
>   - at least cc Junio on patch submissions to make sure he sees it
>   - sign off your patch (either with commit -s or format-patch -s).

Heh, and you did not sign it off when you forwarded? ;-)
