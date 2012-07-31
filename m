From: J Smith <dark.panda@gmail.com>
Subject: Re: [PATCH/RFC] grep: add a perlRegexp configuration option
Date: Tue, 31 Jul 2012 16:35:44 -0400
Message-ID: <CADFUPgfrG75FkSNV6JS22DAciD3CVkNEjKncNJOPkfRQSf41Pg@mail.gmail.com>
References: <1343753854-66765-1-git-send-email-dark.panda@gmail.com>
 <7vehnrkdrq.fsf@alter.siamese.dyndns.org> <CADFUPgfHQCzdnXfby5b+z-pRkt5o6MAVEf_1waWER3iVtM1TZA@mail.gmail.com>
 <7vboivishe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 22:36:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwJAr-0008CY-2q
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 22:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727Ab2GaUgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 16:36:09 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:56991 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405Ab2GaUgF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 16:36:05 -0400
Received: by obbuo13 with SMTP id uo13so11106569obb.19
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 13:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Z83+Hg6lWgRTZYziu9gbFZOQVWzet8pks9eN3SnHgIs=;
        b=VV6Uuf1u5LASrtorAiaKobR1GMO47vnqFDcPgHqUz7ofIHBdRkO3TfHX1FJQRah5ei
         QbLgvio5PfmaloMilTL1Cc2BzadkG+Rx1l0jQ7mgUeEbS8YzBEvy07chEY/KuomI0yKV
         +sCcat9pr6ocMFSa55wSByJmGHfRat6v50iirfkDIaOyxLTVeIZMzBaDhxLzrIJqeF04
         KwpufNGXHYTep8RdtTIxPY7DLQsV1FH9W4qXb133XhKATIk/r4LFL8mxQiUxdpX328Ng
         oO5J+WhdZtKZFSs3Lz1Xf1dAJTQQcPOpNTJs4ikkRHXnL5GjLhG8i9Z7yLhypdNFzdWl
         xppg==
Received: by 10.182.8.6 with SMTP id n6mr25493781oba.39.1343766964806; Tue, 31
 Jul 2012 13:36:04 -0700 (PDT)
Received: by 10.76.168.200 with HTTP; Tue, 31 Jul 2012 13:35:44 -0700 (PDT)
In-Reply-To: <7vboivishe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202685>

On Tue, Jul 31, 2012 at 4:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> J Smith <dark.panda@gmail.com> writes:
>
>> ... For the sake of completeness (verbosity? pedantry?) I also
>> included a setting for "extended" which is equivalent to true.
>
> Good thinking.
>
>> With this sort of change, would a more generic "grep.regexpMode",
>> "grep.patternType" or something similar perhaps be more descriptive,
>> with "grep.extendedRegexp" being aliased for backwards compatibility
>> purposes? I could also add that functionality if desired.
>
> A variable called "extendedRegexp" already reads quite naturally if
> it can have value to say what kind of extendedness is desired, at
> least to me.  So I do not care too deeply either way.

On the flip side, it might be useful to some to have the option to set
the value to "fixed" for the "--fixed-strings" argument, in which case
the option becomes less a type of extended regexp and more of a simple
search string. Were that to be the case, I think "grep.patternType"
would feel the most precise.

I think for completeness at the very least I should work in the
"fixed" value as an valid value, option naming aside.
