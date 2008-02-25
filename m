From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] clone: support cloning full bundles
Date: Mon, 25 Feb 2008 11:30:54 -0800
Message-ID: <7vlk58j0k1.fsf@gitster.siamese.dyndns.org>
References: <1203934349-12125-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 20:31:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTj38-0006Ki-D6
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 20:31:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185AbYBYTbF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2008 14:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755220AbYBYTbF
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 14:31:05 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46347 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755185AbYBYTbE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Feb 2008 14:31:04 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7999C2B67;
	Mon, 25 Feb 2008 14:31:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id ECB7C2B63; Mon, 25 Feb 2008 14:30:57 -0500 (EST)
In-Reply-To: <1203934349-12125-1-git-send-email-sbejar@gmail.com> (Santi
 =?utf-8?Q?B=C3=A9jar's?= message of "Mon, 25 Feb 2008 11:12:29 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75053>

Santi B=C3=A9jar <sbejar@gmail.com> writes:

> Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
> ---
>
> Hi *,
>
>   while waiting for the C port of git-clone I've updated my patch to
> support bundles in "git clone".

I do not recall the v1 round of this patch, but it does not look
too bad.

I was hoping, however, if we can replace "git fetch-pack" there
with "git-fetch" so that you do not have to have the if
conditional based on "$repo"'s type.  Isn't "git fetch" capable
of fetching from a bundle already?
