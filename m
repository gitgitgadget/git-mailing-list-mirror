From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: theirs/ours was Re: [PATCH 6/6] Add a new test for using a custom merge strategy
Date: Mon, 28 Jul 2008 23:39:31 +0200
Message-ID: <bd6139dc0807281439i7f40a914s3cda16a2bdbf6857@mail.gmail.com>
References: <bd6139dc0807280754x76b6ffedg6bf756dfce23f1e3@mail.gmail.com>
	 <20080728185604.GA26322@sigill.intra.peff.net>
	 <alpine.DEB.1.00.0807282008470.8986@racer>
	 <7vproxrcvu.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0807281310j16b4ef5alf9738ec0f3270ba0@mail.gmail.com>
	 <7vljzlrca9.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0807281324k38198fffwd3b586394b354ed2@mail.gmail.com>
	 <7vvdyppv4c.fsf@gitster.siamese.dyndns.org>
	 <7vr69dpu9i.fsf@gitster.siamese.dyndns.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jeff King" <peff@peff.net>,
	"Git Mailinglist" <git@vger.kernel.org>,
	"Miklos Vajna" <vmiklos@frugalware.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 23:40:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNaSY-0005KK-AS
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 23:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759990AbYG1Vjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 17:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759994AbYG1Vjd
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 17:39:33 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:33111 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759990AbYG1Vjc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 17:39:32 -0400
Received: by wf-out-1314.google.com with SMTP id 27so5985782wfd.4
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 14:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=kXjvilP0rMmqURFjzzd70cDT/1Wmb001p7YXpaw1AxU=;
        b=uyIJEoV+SfXVVTcvwKhf6XG0EIt3qML6cAZOWOIHOygm5rBerIw9IAdkNS7BuH1iqg
         rGcTAFaIGNTjWjgtuSTJIHc+VMyrbcFxrb/X0BhpQWowx3u+XpDxMuKxWKDroj2eUP0U
         JF0A5FFWjvsv3SfbY3JbQ8AiYRLNM0awBFopE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=KGTFRJbgsWM44RH2N5i6sY4t/+W4Tj/C8gYE59dIh6SkJnUgZeF/l8mAFCkc9hMe+Y
         bdImufGAQLu8RbqhPKHaKtzoPOefu5ZgCKVpfUljJcIx1WzJEOefX+HH7rBV7TDwvHlJ
         5/ZHyMF0YBUQ3ettlzsaNYIdXJjKKqDJiRyKU=
Received: by 10.143.40.18 with SMTP id s18mr1775828wfj.156.1217281171752;
        Mon, 28 Jul 2008 14:39:31 -0700 (PDT)
Received: by 10.142.104.10 with HTTP; Mon, 28 Jul 2008 14:39:31 -0700 (PDT)
In-Reply-To: <7vr69dpu9i.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90509>

On Mon, Jul 28, 2008 at 23:35, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> The quoted sentence by me in that message was after I explained why "per
>> hunk theirs" aka "-Xtheirs" was not such a great idea I further went on to
>> say "by the way, '-s theirs' is even worse and here is why".

Aaah, ok, now I see where my confusion came from. Thank you for
clarifying that. Then remains the question, what to tell those that
want '-s theirs' not to keep track of their changes, but to keep a
fast-forwardable master?

> Heh, I ended up doing the "digging" myself.   The quote came from this:
>
>    http://thread.gmane.org/gmane.comp.version-control.git/89010/focus=89024
>
> and "tried not to sound too negative" there refers to:
>
>    http://thread.gmane.org/gmane.comp.version-control.git/89010/focus=89021
>
> which _was_ about the "-Xtheirs", not "-s theirs".

Understood, it makes sense now.

-- 
Cheers,

Sverre Rabbelier
