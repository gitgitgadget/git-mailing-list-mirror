From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-format-patch(1)- add note about creating patch for
 single commit
Date: Sat, 18 Oct 2008 22:33:52 -0700
Message-ID: <7vwsg587y7.fsf@gitster.siamese.dyndns.org>
References: <1224392084-12956-1-git-send-email-dpmcgee@gmail.com>
 <7v1vyd9n3d.fsf@gitster.siamese.dyndns.org>
 <449c10960810182226t5e2ae1ay4b53656a7cac4606@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Dan McGee" <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 19 07:35:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrQwd-0003Dl-Cw
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 07:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbYJSFeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 01:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbYJSFeC
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 01:34:02 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40331 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbYJSFeB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 01:34:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4B09D8C83F;
	Sun, 19 Oct 2008 01:34:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CD55F8C839; Sun, 19 Oct 2008 01:33:54 -0400 (EDT)
In-Reply-To: <449c10960810182226t5e2ae1ay4b53656a7cac4606@mail.gmail.com>
 (Dan McGee's message of "Sun, 19 Oct 2008 00:26:35 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8847C7BA-9D9F-11DD-9AA9-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98593>

"Dan McGee" <dpmcgee@gmail.com> writes:

> On Sun, Oct 19, 2008 at 12:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Heh, a more natural way to say that is:
>>
>>        git format-patch -1 $that_one
>>
>> That uses the first option described in the documentation:
>>
>>        -<n>::
>>                Limits the number of patches to prepare.
>
> Wow, had no idea about that option. :)
>
> Given that I didn't even notice this option when I did go to the
> manpage, what if my above change was instead reworked a bit:
>>> +latter case.  If you want to format only a single commit, say "git
>>> +format-patch -1 <commit>" .

I thought about it, but saw "formatting three commits" example in the
manpage, and stopped there ;-)
