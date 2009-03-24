From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] Documentation: git-format-patch.txt rewordings and 
	cleanups
Date: Tue, 24 Mar 2009 16:36:15 -0700
Message-ID: <780e0a6b0903241636j4749daf3xddb6e4c200c00820@mail.gmail.com>
References: <1237803683-14939-1-git-send-email-bebarino@gmail.com>
	 <20090324220913.GN19389@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 00:37:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmGBo-0005KN-8o
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 00:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555AbZCXXgT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 19:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753229AbZCXXgS
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 19:36:18 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:47766 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753888AbZCXXgR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2009 19:36:17 -0400
Received: by wf-out-1314.google.com with SMTP id 29so3691941wff.4
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 16:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dDrKfyKYFYulM6JzECiJ5LeF+VpoRdNE3ZjOi8OYfGo=;
        b=LsV8ngaO3hSMwEyg3Z5VAvhdtIQf+S3d/9VfFRVZpY2YZRHUnXBFXbOlrwL57I0uhV
         i/O/JUFQ8EVWcmBIFEDu10VP6npqNitBY19QCRuBN7/to+rl+gwxL4hj9XCRrK4K5M/g
         +U0Y8snGuqhArVQTesC2hC+Zis4lSu0T/WsPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=obutiTtVRXJj73qBeY1RF1YklciHQiMs5jzy5XYNh+ew03cUOCzEhxYWsokf7IysKZ
         L494kYe1YF9XIuDEEEs52jgArJMBa4hs1U1nWULrNR/+UO4hkhULHoP85+wMhfjrpRFO
         ROVT+/jdVAY/DPEOrkBG9pS32P1LZhD1tW/I4=
Received: by 10.143.15.11 with SMTP id s11mr3605355wfi.283.1237937775669; Tue, 
	24 Mar 2009 16:36:15 -0700 (PDT)
In-Reply-To: <20090324220913.GN19389@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114515>

On Tue, Mar 24, 2009 at 3:09 PM, J. Bruce Fields <bfields@fieldses.org>=
 wrote:
> On Mon, Mar 23, 2009 at 03:21:23AM -0700, Stephen Boyd wrote:
>> =C2=A0+
>> -Note that you would need to include the leading dot `.` if you
>> -want a filename like `0001-description-of-my-change.patch`, and
>> -the first letter does not have to be a dot. =C2=A0Leaving it empty =
would
>> -not add any suffix.
>> +Note the first letter is not required to be a dot, you will need to
>> +include the leading dot `.` if you want a filename like
>> +`0001-description-of-my-change.patch`.
>
> That's a comma-splice, trivially fixed by changing "dot, you" to "dot=
;
> you".
>
> Better?: "Note that the leading dot isn't actually required if you do=
n't
> want a dot between the patch name and the suffix."
>
> (Though personally I'd strike the whole sentence, since a) probably
> nobody cares, and b) the 1 in a million person that does actually wan=
t
> to do this can figure it out easily enough on their own with a quick
> test.)
>
> --b.
>

I don't think documentation is meant to point the user to trial and
error. Even if the error is fairly harmless. Although you could be
right that nobody cares.

How about a sentence with no negation?

"Note that the leading dot is required if you want a dot between the
patch name and the suffix."
