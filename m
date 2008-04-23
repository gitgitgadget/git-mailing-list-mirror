From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 22 Apr 2008 17:22:04 -0700
Message-ID: <7vd4ohwhcj.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
 <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
 <200804222251.04559.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 02:23:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoSlO-0008L9-NR
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 02:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756196AbYDWAWU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Apr 2008 20:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754344AbYDWAWU
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 20:22:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58770 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756055AbYDWAWT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Apr 2008 20:22:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2100D24EF;
	Tue, 22 Apr 2008 20:22:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6748324AF; Tue, 22 Apr 2008 20:22:13 -0400 (EDT)
In-Reply-To: <200804222251.04559.barra_cuda@katamail.com> (Michele Ballabio's
 message of "Tue, 22 Apr 2008 22:51:04 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80175>

Michele Ballabio <barra_cuda@katamail.com> writes:

> On Tuesday 22 April 2008, Junio C Hamano wrote:
>> * mv/defer-gc (Wed Apr 2 21:35:11 2008 +0200) 3 commits
>> =C2=A0+ contrib/hooks: add an example pre-auto-gc hook
>> =C2=A0+ Documentation/hooks: add pre-auto-gc hook
>> =C2=A0+ git-gc --auto: add pre-auto-gc hook
>>=20
>> A new hook to stop "git gc --auto" from running.
>
> About "git gc --auto", there was a patch sometime ago:
>
> 	[PATCH] commit: resurrect "gc --auto" at the end
>
> http://marc.info/?l=3Dgit&m=3D120716427130606&w=3D2
>
> Was it dropped?

In the thread, addition of an extra hook to "gc --auto" wasdiscussed.  =
It
was judged conditionally Ok as long as nobody assumes "gc --auto" is
ultra-cheap.  We used to have a "gc --auto" at the end of git-commit wh=
ich
violated that condition, but we do not have that anymore.

The patch resurrects the behaviour that makes the extra hook possibly
unacceptable again, dosn't it?
