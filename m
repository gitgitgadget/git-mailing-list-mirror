From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 00/18] remote-bzr: massive changes
Date: Wed, 1 May 2013 13:35:38 -0500
Message-ID: <CAMP44s0n28ihRXf4f25Sx0jkg2u-eROR93bkO0Nm6X00tmkVMA@mail.gmail.com>
References: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
	<7vppxb8d9k.fsf@alter.siamese.dyndns.org>
	<CAMP44s3zf0Hbx4-KHVH7+wCm_czTigJo2y=wqD5Ai-9cKxZcug@mail.gmail.com>
	<7vli7y8xia.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 01 20:35:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXbsV-0001MG-Ug
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 20:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369Ab3EASfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 14:35:40 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36792 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703Ab3EASfj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 14:35:39 -0400
Received: by mail-lb0-f174.google.com with SMTP id t11so1702257lbd.33
        for <git@vger.kernel.org>; Wed, 01 May 2013 11:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=jZGNSisZc6SoMFSzSp3NyQ5gQ4my645HhGNs28Yez2g=;
        b=jprZmAvfQQZnC8l727QJLkoHahtkGTa9y1NA7I9FmbUVWANye+fpmYCgb/bWEM8Dyk
         ujZk6s6NE4HkC3UF43CSl3w9Z0caJ42QTvsyYNkoMUSh14EjErfNWHLZt5UbOzwoIaM/
         6vFUGPrh/KSkdfDXKLLYhK2f59n+HDZIsEM+0HxnIEICNcmIIwTVVnMmWHJsaif/YDiK
         XfRvGIBljwVwgXw+e/TDuUkFo0qwZj1pOg7JJcXsjWeP9X0NYtGN6j7sNBSH1laVzkH8
         FXBWevmLTZSaQdEhu5lBA1VXX2szfd8JGJGDsFXCzz2abUYmjcApD5vi4YFjv5v4Dl81
         EQmQ==
X-Received: by 10.112.22.198 with SMTP id g6mr1500354lbf.135.1367433338096;
 Wed, 01 May 2013 11:35:38 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Wed, 1 May 2013 11:35:38 -0700 (PDT)
In-Reply-To: <7vli7y8xia.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223114>

On Wed, May 1, 2013 at 11:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> So let's go ahead and apply these directly on top of 'master', once
>>> we hear from Emacs folks and they are happy with it.  I'll queue it
>>> on 'pu' so that I do not have to go back to the list archive when it
>>> happens.
>>
>> I already heard that everything seems to be working correctly, except
>> one feature, the biggest change, which I screwed up with a one-liner
>> commit. That's why I added a test. Anyway, I've fixed it in my github
>> branch and in this patch series, and I've told them to try the fix.
>
> Let us know when they make progress on that front.
>
> If Emacs decides to switch to Git and decides to use this version of
> remote-bzr for their conversion, or at least a nontrivial group of
> developers favor to do so, without seeing concrete technical points
> that say remote-bzr is not yet ready (e.g. "the conversion is still
> wrong and X, Y and Z needs to be fixed"), that would be a very
> welcome solid vote of confidence in favor of us going ahead with
> this.

Seems unlikely for political reasons (isn't it always for GNU?), since
RMS is heavily involved in the decision.

-- 
Felipe Contreras
