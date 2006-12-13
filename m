X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [RFC/PATCH] runstatus: restructure visual appearance
Date: Wed, 13 Dec 2006 10:27:37 +0100
Message-ID: <8c5c35580612130127y1b094dbbq34c06376704b0506@mail.gmail.com>
References: <11650882251452-git-send-email-hjemli@gmail.com>
	 <8c5c35580612120330n36bcdd00p57b2a7cd1d6c801@mail.gmail.com>
	 <7v3b7koc6b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 13 Dec 2006 09:27:45 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k5sIgelWg3WDkoZ7xOo2a9Ence9Uuwy7AnW3RkOIJ5bAQ7m2UBRkR2mtIIy8gT4M0BKJTuVE3akNlXsncG0Fd+fu1ja1Pw9NCcFHQzIL7uSDqDu+PBKFWoeK8rpqj8fOLtGq4tW0r7l4hFsVyrTW5IQyb/81GlcQ+AnX5/aKjhY=
In-Reply-To: <7v3b7koc6b.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34189>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuQOt-0005dB-Gy for gcvg-git@gmane.org; Wed, 13 Dec
 2006 10:27:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932636AbWLMJ1k (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 04:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbWLMJ1k
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 04:27:40 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:45944 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932633AbWLMJ1j (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec
 2006 04:27:39 -0500
Received: by nf-out-0910.google.com with SMTP id o25so479656nfa for
 <git@vger.kernel.org>; Wed, 13 Dec 2006 01:27:38 -0800 (PST)
Received: by 10.82.167.5 with SMTP id p5mr112906bue.1166002057488; Wed, 13
 Dec 2006 01:27:37 -0800 (PST)
Received: by 10.82.171.10 with HTTP; Wed, 13 Dec 2006 01:27:37 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 12/13/06, Junio C Hamano <junkio@cox.net> wrote:
> "Lars Hjemli" <hjemli@gmail.com> writes:
> > Just wondering if this patch got dropped or simply overlooked...
>
> I looked at the patch, and I was neutral to slightly negative
> (but only slightly.  I thought M vs M+ was too subtle and
> cryptic until the user gets used to them).

Hmm, yes, I agree it's a bit subtle. But whenever the '+' or '-' is
added to a state symbol, the big warning that is printed should make
it less so (the warning should also mention git-rm, btw).

And of course the man-page for git-status should be updated to
describe the different state symbols, the meaning of +/-, and how to
'resolve' them.


> I however did not see overwhelming support from the list, so I
> did not further think about it.

The silence was earth shattering


> One thing that was mentioned in the past on the list about the
> output from git-status was that we do not make mode changes
> stand out, and people can mistakenly do something silly to
> change the -x bit and the current git-status would only say:
>
>      modified:       git-foobar.sh
>
> which would not help them notice the mistake, as a result,
> accidental mode change can get committed.
>
>If we are designing a new format to make git-status output more
>compact and easier to understand, I think it should also attempt
>to address this problem as well.

Excellent point, I'll use it as an excuse to refine and resend the patch.

-- 
