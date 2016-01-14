From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [RFC] Malicously tampering git metadata?
Date: Thu, 14 Jan 2016 12:16:39 -0500
Message-ID: <20160114171639.GB25541@LykOS>
References: <20151216032639.GA1901@LykOS>
 <20151218231032.GA16904@thunk.org>
 <20151219173018.GA1178@LykOS>
 <20151220012835.GA3013@thunk.org>
 <20160112182137.GE27334@LykOS>
 <CAGZ79kadpy9N0qEpxK-USVxCmNfYJm1g5xr8ZiFxf7sOVKZnEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 18:16:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJlVv-0007VX-NM
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 18:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756218AbcANRQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 12:16:44 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34409 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018AbcANRQm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 12:16:42 -0500
Received: by mail-qg0-f54.google.com with SMTP id 6so409133718qgy.1
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 09:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to;
        bh=ZIxmVIPM2RRb6oDjJWpV35aDiSnrdNcVJRicwrdtwwA=;
        b=S9XgBjictIDnFF1RYVGPkTTGeAEwrUo0fQul26mwOwof/CT2Zn1B1ccQk6KaSxxT3u
         uv9ceCxouHLcvjaF02VT4pyepGOfVeruW8OnmIWe7vUTH8ouetkQ/KXtot0a2/KVO7zu
         V9gzBLC2yOLJpaEMS1mNO/NxZVwAoEqtDV76BnzCOEq8aL5VJOv6ooy9ALR03HI2V110
         QwqVu/VkC+4/ItJX+qnqufyYDtLSDirrjHTXFAtCDwr1z04ZbSo8wNk6YPWde53cwNo0
         e8iO8lpXNdGyZ8MghQsni0O5gIQok9oq79kxT/zLSNZkN5zk5EZLuYn++95kdHdiYRK4
         j12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to;
        bh=ZIxmVIPM2RRb6oDjJWpV35aDiSnrdNcVJRicwrdtwwA=;
        b=EWHwvXdQJ80+8sz4Ms8Zxc44Ps47mRTB7vQSBCAyqw19bc2Ho+5HAJob0Dl0hor+JW
         uH1A3rSRU6MkV5YxlAbIxKir4c6LAE0pqlna+2fYPghH71mnzipBSnRGAn7rC9BRCtTt
         F8tty9rWpj27IE2HbF9MFyrfoEt4cnGZ29WuA16oDForvd8SH7rmIx7ZKMXLVbWhz51M
         hjShkefWlb65GUi2/ZfaIvTaSzGTdCf/9tV6dIjixmh8on2C8V2e/hFgPoH/UvoOaMG3
         kQB0Xy2p9p7xw2rEfHhayc5XL9JNWwCNYBZT6UBdisjuAQly1sZ6qds9Ewp6aJA9Jj0K
         DoIA==
X-Gm-Message-State: ALoCoQn6qbIVqHaK4e7CRef7s/wscyNJiLnxAlB9z0UfWbQe+NiwiTk+aimEMk30y7fGFm7b7XAW0Q5r43Oqq3EOnyrpxt8EvA==
X-Received: by 10.140.43.116 with SMTP id d107mr6947757qga.51.1452791801582;
        Thu, 14 Jan 2016 09:16:41 -0800 (PST)
Received: from LykOS (NYUFWA-WLESSAUTHCLIENTS-18.NATPOOL.NYU.EDU. [216.165.95.7])
        by smtp.gmail.com with ESMTPSA id r63sm2847331qkr.17.2016.01.14.09.16.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jan 2016 09:16:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGZ79kadpy9N0qEpxK-USVxCmNfYJm1g5xr8ZiFxf7sOVKZnEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284069>

Hello Stefan, thanks for your feedback again. 

> This is what push certs ought to solve already?

Yes, they aim to solve the same issue. Unfortunately, push certificates
don't solve all posible scenarios of metadata manipulation (e.g., a
malicious server changing branch pointers to trick a user into merging
unwanted changes).

> AFAIU the main issue with untrustworthy servers is holding back the latest push.
> As Ted said, usually there is problem in the code and then the fix is pushed,
> but the malicious server would not advertise the update, but deliver the old
> unfixed version.
> 
> This attack cannot be mitigated by having either a side channel (email
> announcements)
> or time outs (state is only good if push cert is newer than <amount of
> time>, but this may
> require empty pushes)
> 

I'm sorry, did you mean to say "can"? 

Yes, this is a possible solution to this issue. The solution I'm
proposing here wouldn't require a side channel though. As long as users'
keys are not compromised, the BSL could either expire (raise an alarm),
or force an irreconcileable fork attack --- the user who submited the
changes won't be able to push until this change makes it through.

> 
> >
> > Furthermore, upon fetching, users with write access also push an entry
> > indicating that they fetched the BSL. This avoids cases in which a malicious
> > attacker keeps older versions of the BSL and withhold changes to other users.
> 
> This would make it a "be malicious to all or none" thing? So the
> attacker cannot attack
> a single target IIUC.

Yes, this is true. The ides is that any attack to a single target is
easy to identify.

> 
> I have a bad feeling about repository modifications upon fetching as
> software distribution is a highly asymmetric workflow (number of
> fetches is many orders of magnitudes larger than pushes), which may
> not scale well? 

Yes, we were worried about the same ourselves. The upside is that, push
and fetch entries in our scheme are also orders of magnitude smaller;
fetch entries do not need to be signed and they can be as little as four
bytes (they might be gc-able also). 


> (How would you serialize parallel fetches into the BSL?)

Yes, this would imply that locking needs to be performed on the server
side. It is important to note that fetch entries are only relevant for
users to have write access (as only they are beneffited by them). For
read-only fetches, like an automated build, this feature could be
disabled.

> 
> Thanks,
> Stefan

Thanks again!
-Santiago.
