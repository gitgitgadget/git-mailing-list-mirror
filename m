From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT PULL] vcs-svn housekeeping
Date: Fri, 06 Jul 2012 13:28:13 -0700
Message-ID: <7vy5mwmy76.fsf@alter.siamese.dyndns.org>
References: <7v62b4ksw2.fsf@alter.siamese.dyndns.org>
 <CAFfmPPOWZz8JF_BVKvnAVp0VUDzxPiVSqjG7ATPx3CVztDF=cw@mail.gmail.com>
 <20120607003904.GB4065@burratino> <7vtxynk81p.fsf@alter.siamese.dyndns.org>
 <20120706171040.GA31001@burratino>
 <CAFfmPPOWfYhZyrsvg8eeisdNLb4gyEMJ5kYfVhcSR3KNa-QjCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	git@vger.kernel.org
To: David Michael Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 22:28:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnF8m-0001v8-Pl
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 22:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754114Ab2GFU2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 16:28:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62116 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752684Ab2GFU2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 16:28:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD5F19D7F;
	Fri,  6 Jul 2012 16:28:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b/EDiJ68hXRpTZo0WEHvU1/yLZc=; b=tXfupE
	aYWXFehCnuuNkL0g/5LJnT9joZPA6yDlwZL2pwYja0gBkPkHXrCSEUA4jfIJ9hfp
	mmgibTHNApGHX342Qjjsm6It69aWpICuT1vFaXeTri3tYyvKGeF6fllL5WyOFAoZ
	6QSrP8AzrndoLvWUyGWWuUEIdH7j0sna9iYAA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ctnYwGptENCW6jBzSbYAnfR+L0ejah4+
	9Z2BaNR0EYrvwwn+Op/S9bkuVGu0YUYHhlNn/Z1yn/+TjJaED17ner01oa+VgQL/
	87omSrTaJxKSAZpi5ZfDpaHLMkt5h1stTjL93A6tLf1Lt+SKmzVpv8Tf35lLvFPs
	QI8TSjk/ZyI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4ECD9D7E;
	Fri,  6 Jul 2012 16:28:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38E069D7D; Fri,  6 Jul 2012
 16:28:15 -0400 (EDT)
In-Reply-To: <CAFfmPPOWfYhZyrsvg8eeisdNLb4gyEMJ5kYfVhcSR3KNa-QjCQ@mail.gmail.com> (David
 Michael Barr's message of "Sat, 7 Jul 2012 05:41:51 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1D4763AC-C7A9-11E1-8EEE-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201149>

David Michael Barr <davidbarr@google.com> writes:

> On Sat, Jul 7, 2012 at 3:10 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> ...
>> Some of the patches had to change a little since v2 of db/vcs-svn, so
>> I'll be replying with a copy of the patches for reference.
>>
>> David has looked the branch over and acked and tested it.
>> ...
>
> Thank you Jonathan for doing this. Definitely the result of
> collaborating on a series is gorgeous. I do wish I could absorb your
> flair for polish.

Thanks, both.  Will be pulled and pushed out by tonight.
