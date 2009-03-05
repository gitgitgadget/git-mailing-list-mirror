From: Junio C Hamano <gitster@pobox.com>
Subject: Re: notes, was Re: What's cooking in git.git (Mar 2009, #02; Thu,
 05)
Date: Thu, 05 Mar 2009 11:23:54 -0800
Message-ID: <7vwsb3zsc5.fsf@gitster.siamese.dyndns.org>
References: <7vbpsg2sgx.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0903051204010.6524@intel-tinevez-2-302>
 <2c6b72b30903050440k6f9533bbq605d5f06161dff92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 20:25:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfJCd-0005LB-Ek
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 20:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754418AbZCETYI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2009 14:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754068AbZCETYG
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 14:24:06 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60820 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098AbZCETYD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2009 14:24:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 94EC79FF75;
	Thu,  5 Mar 2009 14:24:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 529949FF74; Thu,
  5 Mar 2009 14:23:56 -0500 (EST)
In-Reply-To: <2c6b72b30903050440k6f9533bbq605d5f06161dff92@mail.gmail.com>
 (Jonas Fonseca's message of "Thu, 5 Mar 2009 13:40:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2E2BE346-09BB-11DE-AD40-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112327>

Jonas Fonseca <jonas.fonseca@gmail.com> writes:

> On Thu, Mar 5, 2009 at 12:04, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> On Thu, 5 Mar 2009, Junio C Hamano wrote:
>>
>>> * js/notes (Wed Feb 18 11:17:27 2009 -0800) 14 commits
>>>
>>> Rebased and then kicked back to 'pu' to give the author a chance to
>>> rearrange if necessary. =C2=A0I might do some trivial squashing mys=
elf.
>>
>> Will do.
>
> Although laziness should not be rewarded, this might be something tha=
t
> you could squash in as well.

Whose laziness are you accusing?  Me giving Dscho a chance to make triv=
ial
clean-up of his own series instead of doing it myself???

In any case, I won't be squashing "oops - fixup" patch(es) in the origi=
nal
series to the early parts of the sequence that introduced the "oops"
myself, as it would likely end up Dscho and I stepping on each other's
paws.  I won't be squashing this patch in myself, either.

> --- a/Documentation/git-notes.txt
> +++ b/Documentation/git-notes.txt
> @@ -43,4 +43,4 @@ Documentation by Johannes Schindelin
>
>  GIT
>  ---
> -Part of the gitlink:git[7] suite
> +Part of the linkgit:git[7] suite
