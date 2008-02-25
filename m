From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] clone: support cloning full bundles
Date: Mon, 25 Feb 2008 13:00:32 -0800
Message-ID: <7vk5kshhu7.fsf@gitster.siamese.dyndns.org>
References: <1203934349-12125-1-git-send-email-sbejar@gmail.com>
 <7vlk58j0k1.fsf@gitster.siamese.dyndns.org>
 <8aa486160802251229x778c7427nd51093bc23ec6c8c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 22:01:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTkRu-0003pO-Ob
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 22:01:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbYBYVAq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2008 16:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbYBYVAq
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 16:00:46 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54592 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbYBYVAq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Feb 2008 16:00:46 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CF468181D;
	Mon, 25 Feb 2008 16:00:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 23CD7181A; Mon, 25 Feb 2008 16:00:40 -0500 (EST)
In-Reply-To: <8aa486160802251229x778c7427nd51093bc23ec6c8c@mail.gmail.com>
 (Santi =?utf-8?Q?B=C3=A9jar's?= message of "Mon, 25 Feb 2008 21:29:22 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75069>

"Santi B=C3=A9jar" <sbejar@gmail.com> writes:

> ...
> you need to reorganize other things (not the same output, to download
> all the refs you need to write a config with refs/heads/*:..., "git
> fetch" does not have a --no-progress), so I opted for
> a minimal path (and not break the most used path :-).

That sounds like a sensible explanation.  As the external
interface won't change even if we later do so, let's take this
version for 1.5.5.

Thanks.
