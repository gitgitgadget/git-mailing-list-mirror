From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: Are more and more patches getting lost lately?
Date: Thu, 4 Sep 2008 14:30:38 +0600
Message-ID: <7bfdc29a0809040130u21d43a22ncf2e481eefd9ff89@mail.gmail.com>
References: <20080904083343.6117@nanako3.lavabit.com>
	 <7vd4jk8r78.fsf@gitster.siamese.dyndns.org>
	 <20080904172059.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Nanako Shiraishi" <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 10:32:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbAFt-0007dk-8i
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 10:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658AbYIDIam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 04:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752885AbYIDIak
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 04:30:40 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:11530 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbYIDIaj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 04:30:39 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1839321yxm.1
        for <git@vger.kernel.org>; Thu, 04 Sep 2008 01:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=pH+kgDMD3OQyTyr6i0IeVzaFPbw7ubc9pkPQh2gC/1g=;
        b=rKuVDWDx33zu0u8xgI1wjynhr1zvgW3oc2uQxfYdL3lTcxd4dSFly/YVZWQwmKlWdR
         cBprlBH4dLVo2WF6Z+6yDiLCB8kXZ/jRnasFy3649QrRk2c1wJiMTU+6OHKxKzNo5KCK
         M4INd6w7TGkNgpIFA5xj5sIf9xQ9e49nW499U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=wYHst7sThuZqVK7+pNG6kS7KU0/gO7Y5Zt0uotAvM26WaROPUmtvIo4DYvNzlodECI
         lNYJyu+ekptfBxGjt1GURBFL6hDFd9LkLQI5V5xTrB5iQqABdX3r5FTk+iYlsbOcvWbZ
         6wlUplGw2696iPJnMrYp9f2Tvj5Vbk1BuziJ4=
Received: by 10.151.48.15 with SMTP id a15mr14008394ybk.121.1220517038093;
        Thu, 04 Sep 2008 01:30:38 -0700 (PDT)
Received: by 10.150.54.11 with HTTP; Thu, 4 Sep 2008 01:30:38 -0700 (PDT)
In-Reply-To: <20080904172059.6117@nanako3.lavabit.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94905>

On Thu, Sep 4, 2008 at 2:20 PM, Nanako Shiraishi <nanako3@lavabit.com> wrote:
> Quoting Junio C Hamano <gitster@pobox.com>:
>
>> Nanako Shiraishi <nanako3@lavabit.com> writes:
>>
>>> I noticed that recently there are many patches sent to the list
>>> that are left unapplied (and many of them are from you).  Many
>>> of them look useful or at least promising to become useful.
>>
>> Geez.  Well,... thanks.
>>
>> Do you have particular ones in the list that you really want to see
>> in-tree early, do you want all of them, or what?
>
> Your "diff --quiet" and Petr's bash completion.
>
> Also there are many patches that are from *you*.  Did you forget to apply
> them, are they buggy, or are they in any way bad?
>
> From: Junio C Hamano <gitster@pobox.com>
> Subject: Re: [PATCH] Enable git rev-list to parse --quiet
> Date: Thu, 17 Jul 2008 23:10:19 -0700
> Message-ID: <7vy73zd8ok.fsf@gitster.siamese.dyndns.org>
>
> http://article.gmane.org/gmane.comp.version-control.git/88994
>

I actually liked the following 2 patch and since it was Junio I did
not think support was required :-D.

Cheers,

Imran

> From: Junio C Hamano <gitster@pobox.com>
> Subject: [PATCH/RFC] feeding Maildir to git-am
> Date: Tue, 19 Aug 2008 22:25:57 -0700
> Message-ID: <7vbpzotfyy.fsf@gitster.siamese.dyndns.org>
>
> http://article.gmane.org/gmane.comp.version-control.git/92963
>
> From: Junio C Hamano <gitster@pobox.com>
> Subject: Re* [PATCH] git-apply - Add --include=PATH
> Date: Mon, 25 Aug 2008 01:05:31 -0700
> Message-ID: <7vhc99h644.fsf@gitster.siamese.dyndns.org>
>
> http://article.gmane.org/gmane.comp.version-control.git/93604
>
> --
> Nanako Shiraishi
> http://ivory.ap.teacup.com/nanako3/
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Imran M Yousuf
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
