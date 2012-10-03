From: PJ Weisberg <pj@irregularexpressions.net>
Subject: Re: erratic behavior commit --allow-empty
Date: Tue, 2 Oct 2012 19:10:01 -0700
Message-ID: <CAJsNXTm9ADZv4SbabAR_WzGrZO8wDjvk+9Lsis0STHGo1EhqwQ@mail.gmail.com>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
	<506AA51E.9010209@viscovery.net>
	<7vzk449449.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
	<7vhaqc7in6.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 04:10:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJEPj-0000Uw-1X
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 04:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212Ab2JCCKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 22:10:05 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:47410 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153Ab2JCCKD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 22:10:03 -0400
Received: by lbon3 with SMTP id n3so5757454lbo.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 19:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=oPN7IYApZO5yQScgXAlRMBepq7EfKZ2iq+KExNosdlo=;
        b=dm010bzVUxjrn+fkgu56NmSvtmLZ/1LfxkIWvq9GSrYrQZOp3WDzpKpeEqigZETChr
         VFD/zey0Gd7ecpxo7MQoZYXQQfsSv1YYmRnYFS6Ek0sXwVB+SK7bGapPL9FOIHAc524a
         WlfNRkcEOehBkNXR5J/mPMz32MrpGbyQ/XqpHkUvc3A2wHoCGmQhIqq0AfNcUEJAni9T
         06kjRjtpsu09t2sSUkEFfJgRiXzVx8DevjwxXZ1eANj+nRZwto7ON3W+hxZiOIS9QVK7
         6m7ZhLfW8W+ZbXHUG07HCDeLjHSYovJlmeheRs8mzSfzVXoK/aliuayBhJCn40dqXv7f
         MYEQ==
Received: by 10.152.148.162 with SMTP id tt2mr485104lab.10.1349230201813; Tue,
 02 Oct 2012 19:10:01 -0700 (PDT)
Received: by 10.112.87.6 with HTTP; Tue, 2 Oct 2012 19:10:01 -0700 (PDT)
In-Reply-To: <CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com>
X-Google-Sender-Auth: nsYNwvzNygYFswkd3Ir2cL2VuS4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206856>

On Tue, Oct 2, 2012 at 2:56 PM, Angelo Borsotti
<angelo.borsotti@gmail.com> wrote:
> Hi Junio,
>
>> It does create one; it just is the same one you already happen to have,
>> when you record the same state on top of the same history as the
>> same person at the same time.
>>
>
> No, it does not create one: as you can see from the trace of the execution
> of my script, the sha of the commit is the same as that of the other,
> which means
> that in the .git/objects there is only one such commit object, and not two with
> the same sha. The meaning of the word "create" is to bring into being something
> that did not exist before. There is no "creation" if the object already exists.

It's also impossible to create two identical files in Git.  If you
try, you'll find that they both have the same SHA1, and thus are
represented by the same object in .git/objects.

You have a script that creates two commits that are identical in every
way.  What practical difference does it make whether they're
represented by one object or two?

-PJ

Gehm's Corollary to Clark's Law: Any technology distinguishable from
magic is insufficiently advanced.
