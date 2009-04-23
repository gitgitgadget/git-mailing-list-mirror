From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Wait for git diff to finish in git difftool
Date: Thu, 23 Apr 2009 07:51:28 -0700
Message-ID: <7vhc0fv2xb.fsf@gitster.siamese.dyndns.org>
References: <81b0412b0904220027t7afd1ed7xc57c479ef8cdb6b9@mail.gmail.com>
 <20090422082652.GA32698@gmail.com>
 <81b0412b0904220404o30ce1413kcc4dcea1fa822841@mail.gmail.com>
 <7vr5zk346d.fsf@gitster.siamese.dyndns.org>
 <81b0412b0904221340o6b2f1474oed2ad12e4f68cff3@mail.gmail.com>
 <7v4owgyp8x.fsf@gitster.siamese.dyndns.org>
 <81b0412b0904230033n35f1117fmea4432a2f2140d25@mail.gmail.com>
 <7vtz4fwzaz.fsf@gitster.siamese.dyndns.org>
 <81b0412b0904230252k3e8197d3y8798d5b797a49c39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	charles@hashpling.org, markus.heidelberg@web.de
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 16:53:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx0Ij-0000BZ-2g
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 16:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755975AbZDWOvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 10:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755913AbZDWOvk
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 10:51:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59857 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755026AbZDWOvj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 10:51:39 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 15AB4AC06A;
	Thu, 23 Apr 2009 10:51:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E66FFAC069; Thu,
 23 Apr 2009 10:51:29 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3F82F9E6-3016-11DE-8C66-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117342>

Alex Riesen <raa.lkml@gmail.com> writes:

>>> In plain words: please don't apply MY patches with words "Windows"
>>> or "Cygwin" in message body, unless I beg you to (and even then,
>>> consider me heavily drugged).
>>
>> Hmm, what's the point then for me to spend time looking at them posted on
>> the list?
>
> None. But it still would be nice if you look at them when you're addressed
> directly. Please understand, maybe I'm abusing the list a little, but it looks
> like the best place to _archive_ the workarounds for this obscure platform.
> The code is of little use to general public, but in case one finds himself
> in the same situation as I am in, at least Google can help out. I think it
> happens too rare to justify your looking at them, and especially including
> them in the mainline, but hiding the code on my laptop isn't of any use
> to anyone (including me: I don't always have that laptop).

Actually, I think I probably should have phrased it more positively.

Do you think you are in a so minority situation that your "workarounds"
are valuable for nobody else?  Apparently you see value in letting them
finding your patches in the archive, so you do not expect them to be
"nobody else" but rather "a small minority".

People on minority platforms have smaller number of people in similar
situation to ask help from than people on mainstream platforms, and they
suffer from the minority status of their platforms not only with git but
about many other things.  Worse, their chance of finding solution by
digging the archive is smaller, and they would need to spend a lot more
time, than the people on other platforms.  And you know this a lot better
than I do ;-).

Even though the suffering of these people as a whole may not be much, only
because there are small number of them, as individuals they may suffer a
lot.  If we can help them without having to bend over backwards too much,
it would be a good thing.  I think we should at least try.

For example, I do not think conversion from Perl exec() to Perl system()
is worsening the code in any way in difftool.  Sure, it won't *improve*
things for general majority of people, but as long as it does not hurt
people (that includes me and others who pay maintenance cost), I do not
think we should just bury the patch in archive or in your laptop.
