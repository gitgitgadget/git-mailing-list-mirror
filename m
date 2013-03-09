From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/19] spell checking
Date: Sat, 09 Mar 2013 11:45:30 -0800
Message-ID: <7vobese4rp.fsf@alter.siamese.dyndns.org>
References: <CALeLG_=R4o1y-kA+n883nnAu+jrjgaA2ys2d+Vo9KasmVKeduQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Paul Campbell <pcampbell@kemitix.net>
X-From: git-owner@vger.kernel.org Sat Mar 09 20:46:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEPiS-0001GF-9e
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 20:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337Ab3CITpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 14:45:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47603 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750840Ab3CITpd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 14:45:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 898BCB91D;
	Sat,  9 Mar 2013 14:45:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bogA5vxQ19io+H/f4BRF+R7Xrs0=; b=YpXo86
	6siPz5Ya+8pDCHQRLo6ecDjp1dO4dUtRT1sXcTYzOnJX86MujyyBM8mg7JWnPFES
	8g4ofzULuephBgUEts+Sat0R1vl8a78ciCxgQhEmR0Fplj5P7go/DFxyhfuySQLK
	rol+Ms3VOCj7Xd03L68QsXtpmqVOWyWGGKxTA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QMVMPJjzFJIxsTwFvaFwdJa+mqtKQBCF
	rpV7EAgh4HSCNY3AxPu6ygBKcZrG8WY2XpTo0zwTN6c8a0QpzazlTD5CMK9HRf5j
	ccMkPH//Blxr81pG0NMPKzOxG51BDpdWTjv10E6L6Z47YUOZRJH2bQUoN2AAo6F1
	PXEvxK6oif0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FCE0B91C;
	Sat,  9 Mar 2013 14:45:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 035C5B918; Sat,  9 Mar 2013
 14:45:31 -0500 (EST)
In-Reply-To: <CALeLG_=R4o1y-kA+n883nnAu+jrjgaA2ys2d+Vo9KasmVKeduQ@mail.gmail.com> (Paul
 Campbell's message of "Sat, 9 Mar 2013 19:19:44 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E719592E-88F1-11E2-BCBC-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217758>

Paul Campbell <pcampbell@kemitix.net> writes:

> From 72fc84b6e5085b328cc90e664c9f85a1f5cde36c Mon Sep 17 00:00:00 2001
> From: Paul Cartwright <paul.cartwright@ziilabs.com>
> Date: Thu, 27 Jan 2011 22:33:06 +0800
> Subject: [PATCH 01/19] spell checking
>
> ---
>  contrib/subtree/git-subtree.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I won't repeat these for other 18 patches, but please:

 - drop the first "From <object name> <magic timestamp>" line which
   is not part of the patch (it is only meant to help people who
   maintain the "file(1)" and "magic(5)");

 - keep "From: <author name> ..." and "Date: " lines for other
   peoples' patches you are forwarding (they can be dropped for your
   own patches); and

 - drop "Subject: " as that is the same as the subject of the e-mail
   message.

 - fix the subject to make it clear that the change is for
   contrib/subtree.

   "spell checking" [*1*] in the output of "git shortlog v1.8.1..",
   together with other 600+ patches' titles, will not help the
   reader to see how much activity each area had and who worked in
   what area.

 - have the authors sign-off their patches, and then add yours as
   the person who is forwarding other peoples' patches (see
   Documentation/SubmittingPatches).

 - Cc the area maintainer (I thought it was David Greene?)

if these patches are meant to become part of git.git eventually.

Thanks.


[Footnote]

*1* Besides, a patch can never be "spell *checking*".  It would be
 "typofix" after the author did a 'spell checking' ;-)
