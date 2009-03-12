From: Junio C Hamano <gitster@pobox.com>
Subject: Re: setting up tracking on push
Date: Wed, 11 Mar 2009 18:11:48 -0700
Message-ID: <7vprgnlf3f.fsf@gitster.siamese.dyndns.org>
References: <buofxhr2vta.fsf@dhlpc061.dev.necel.com>
 <gp9jp7$uc3$1@ger.gmane.org>
 <76718490903111758l4e4bd29et379e975deb8e99bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "John M. Dlugosz" <ngnr63q02@sneakemail.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 02:13:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhZUE-0003bk-9A
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 02:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373AbZCLBL6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Mar 2009 21:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbZCLBL5
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 21:11:57 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57451 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbZCLBL5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2009 21:11:57 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4D5F25A5E;
	Wed, 11 Mar 2009 21:11:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A9F595A5C; Wed,
 11 Mar 2009 21:11:50 -0400 (EDT)
In-Reply-To: <76718490903111758l4e4bd29et379e975deb8e99bd@mail.gmail.com>
 (Jay Soffian's message of "Wed, 11 Mar 2009 20:58:59 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C65B8A68-0EA2-11DE-85DE-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112994>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Wed, Mar 11, 2009 at 8:08 PM, John M. Dlugosz
> <ngnr63q02@sneakemail.com> wrote:
>> On a related note, what exactly does "tracking" mean? =C2=A0I know t=
hat I can
>> push/pull local names that match up with names on the origin, and th=
at the
>> latter are in the remotes/origin subdirectory. =C2=A0Those are what =
I think are
>> called "remote tracking branches". =C2=A0Or is that just a part of t=
he whole
>> story? =C2=A0What is the correct nomenclature?
>
> http://article.gmane.org/gmane.comp.version-control.git/54822/

I do not think the description of remote-tracking in that article is
correct.  We use the word to call remote/origin/<name> that keeps copie=
s
of what we saw over there when we last observed.

The way to mark local branches to merge with/rebase onto something else
by default is --track option to "git branch" and "git checkout -b", and
that is often used to mark them to --track remote-tracking branches but
they do not have to --track remote-tracking branches.  They can --track=
=20
local branches as well.
