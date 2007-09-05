From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 5 Sep 2007 21:27:23 +1200
Message-ID: <46a038f90709050227u777ed7b9w23dc3bab13c7b09b@mail.gmail.com>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
	 <20070905074206.GA31750@artemis.corp> <46DE6DBC.30704@midwinter.com>
	 <7vbqchjx9f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steven Grimm" <koreth@midwinter.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 11:27:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISrAZ-0006WM-SB
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 11:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755986AbXIEJ11 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 05:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756031AbXIEJ10
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 05:27:26 -0400
Received: from hu-out-0506.google.com ([72.14.214.226]:28493 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755584AbXIEJ10 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 05:27:26 -0400
Received: by hu-out-0506.google.com with SMTP id 19so1803900hue
        for <git@vger.kernel.org>; Wed, 05 Sep 2007 02:27:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZRnTdxmfvsMW0UZVkC3QQ0nMBVIsZdWkZtkJIv2f9u9M0jzvtQ8deAfd2jcDZZBtsBWkzsd/jCUcIe6SExjdv4khv1nl83y07H3R41TLyYi4HaLpBnKgp3KqUQQ1n4AQ8KCzejWwR3lk2+11DyYJ+1s3Ot4tyPdaEF7NvRycwNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YcDsWQu7P7jvlniPOPT/Z0R9ztNtMbYP/4nw4Qo/+PYi9vs6wVvnbmm51dw586cr3himGbAMVSIF7b6VI20RrYs+pihK7y2UMjJdH7BslzG4eZLZVCm7aB/HglFPuiqSDwbGWZ/OVLEtaRtAYykopYerXiPQIYsK0Fa5axht99Y=
Received: by 10.78.138.6 with SMTP id l6mr3473320hud.1188984443993;
        Wed, 05 Sep 2007 02:27:23 -0700 (PDT)
Received: by 10.67.40.9 with HTTP; Wed, 5 Sep 2007 02:27:23 -0700 (PDT)
In-Reply-To: <7vbqchjx9f.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57701>

On 9/5/07, Junio C Hamano <gitster@pobox.com> wrote:
> [alias]
>         begin = gc
>         leave = gc
>
> That is, the user's manual says 'at the beginning of the day,
> run "git begin" to start the day, and at the end of day, run
> "git leave" to conclude your day', without saying why ;-)

I actually like that one ;-)

Anyway - this is turning out to be a bit of a bikeshed-painting event.
You guys should google earlier discussions on this very same subject.
They have always ended in "automatic=bad", "warning=good", and
"careful or you might be called an idiot" before ;-)

cheers,


martin
