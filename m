From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [RFC] Malicously tampering git metadata?
Date: Fri, 22 Jan 2016 13:00:08 -0500
Message-ID: <20160122180007.GB28871@LykOS>
References: <20151216032639.GA1901@LykOS>
 <20151218231032.GA16904@thunk.org>
 <20151219173018.GA1178@LykOS>
 <20151220012835.GA3013@thunk.org>
 <20160112182137.GE27334@LykOS>
 <CAGZ79kadpy9N0qEpxK-USVxCmNfYJm1g5xr8ZiFxf7sOVKZnEw@mail.gmail.com>
 <20160114171639.GB25541@LykOS>
 <CAGZ79ka51e+-24RyMgUGAOUkBYXxnWZb8Pg7vrgjGHvvWU770Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 19:00:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMg0O-0006eX-IG
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 19:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754590AbcAVSAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 13:00:13 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33468 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754276AbcAVSAK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 13:00:10 -0500
Received: by mail-qg0-f48.google.com with SMTP id b35so63141211qge.0
        for <git@vger.kernel.org>; Fri, 22 Jan 2016 10:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to;
        bh=4IbZCsrUk5L/uED25kz5U66sWLRzQ062a1PRRuYxroU=;
        b=cLvUDk1B/y9c2VxNKKkhohM4CHCbB9QwjPj7U3tjXZ4og9+kG4GhrG1Q67AVfUX1m9
         ndoRP6dWr22niDsFJMpPzaVY9aPqInaIWpSqxG33YSkHMB+WCmzRrUO9tR+TWM8uP2ED
         BKKoZ6G8pkHsGMZBrRiU84ITGeIWsJv1ddz2B0CaKM5SfmsyDDPRquS8v5n4I9ZP8Lul
         UZdjLigzazn9JUkKfglbs/8NajRP+XRyxqiEWc6iuSSfY60jiYZcHpPiiaYTxELy0H8S
         WNxgiwSzif/RIL+Qb6SSx7yAQqzW4c0oepFCQYcs9rPPaXO8BNePetjhG5ffIKGjaE0E
         0fpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to;
        bh=4IbZCsrUk5L/uED25kz5U66sWLRzQ062a1PRRuYxroU=;
        b=FuHwmdTrW9G0hduukuXixzKS+/46+/rZtGfdQeeZcqNEWGWL5VF8CoGZiiy4O/26cS
         LJ4CAJRZtYi8971z9OcgobzJ1k9X4cltVNP4ynpXsIIONMzjz6bNsf9ytnerME4OyBKR
         fz+SNauUPLNXSrXNWk1OPP2Nkp3bR7QT4HKlo02MLZSMktkQpP73leohLmASKJUXX6Zd
         2eiImdD+RxHN2hCv/3/7DeeBJKc9ZSpjUqIruYT0mbU6vG1sqyM2xUDMM2LZ2hFLOKdm
         yTWYLqIMXiifYFUh/ojwIHt1m4HBreoj5hxJnmn3LKvevRlLZN9AVhBMZb/x7UMOqPew
         JxnQ==
X-Gm-Message-State: AG10YOTNR7/q2g4xY/16TR2t0HoB2eoMxPNx03LkKPUutbevCjNjPJY5ACiffRAToFTlu+zD
X-Received: by 10.140.228.69 with SMTP id y66mr5624481qhb.78.1453485609929;
        Fri, 22 Jan 2016 10:00:09 -0800 (PST)
Received: from LykOS (NYUFWA-WLESSAUTHCLIENTS-20.NATPOOL.NYU.EDU. [216.165.95.9])
        by smtp.gmail.com with ESMTPSA id l77sm3240377qkh.11.2016.01.22.10.00.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Jan 2016 10:00:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGZ79ka51e+-24RyMgUGAOUkBYXxnWZb8Pg7vrgjGHvvWU770Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284575>

On Thu, Jan 14, 2016 at 09:21:28AM -0800, Stefan Beller wrote:
> On Thu, Jan 14, 2016 at 9:16 AM, Santiago Torres <santiago@nyu.edu> wrote:
> > Hello Stefan, thanks for your feedback again.
> >
> >> This is what push certs ought to solve already?
> >
> > Yes, they aim to solve the same issue. Unfortunately, push certificates
> > don't solve all posible scenarios of metadata manipulation (e.g., a
> > malicious server changing branch pointers to trick a user into merging
> > unwanted changes).
> >
> >> AFAIU the main issue with untrustworthy servers is holding back the latest push.
> >> As Ted said, usually there is problem in the code and then the fix is pushed,
> >> but the malicious server would not advertise the update, but deliver the old
> >> unfixed version.
> >>
> >> This attack cannot be mitigated by having either a side channel (email
> >> announcements)
> >> or time outs (state is only good if push cert is newer than <amount of
> >> time>, but this may
> >> require empty pushes)
> >>
> >
> > I'm sorry, did you mean to say "can"?
> 
> Yes, formulating that sentence took a while and I did not proofread it.

Sorry, Stefan. I didn't mean to come off as rude; I just wanted to make
sure I understood correctly what you were proposing.

Do you have any further insight? I think that, besides the supporting
multiple workflows, maybe synchronizing concurrent fetches might be an
issue to our solution.

Thanks a lot!
-Santiago.
