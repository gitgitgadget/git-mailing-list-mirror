From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 18/19] index-helper: autorun
Date: Thu, 17 Mar 2016 14:31:07 -0400
Organization: Twitter
Message-ID: <1458239467.9385.21.camel@twopensource.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
	 <1457548582-28302-19-git-send-email-dturner@twopensource.com>
	 <CACsJy8CaWFhCzrH3imz+BRMTESSmyUB4jeAaYUDNk+Tmpj-VrQ@mail.gmail.com>
	 <alpine.DEB.2.20.1603151517590.4690@virtualbox>
	 <1458151880.9385.1.camel@twopensource.com>
	 <alpine.DEB.2.20.1603161923380.4690@virtualbox>
	 <CACsJy8AsJKmsPm8Y1LRZdmyH60n3OT5X=42RGK5GXNBDfn8j8g@mail.gmail.com>
	 <alpine.DEB.2.20.1603171536420.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 19:32:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agciz-0004Ty-P1
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 19:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325AbcCQSc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 14:32:27 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:32969 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966640AbcCQSbK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 14:31:10 -0400
Received: by mail-qg0-f47.google.com with SMTP id a36so47976348qge.0
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 11:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=5IPJg7E7sMxdt7QsK9Lbh8s2WDe0LKZbNAiRZg92kkM=;
        b=m5VSrSSafgKYz1BV5o4rcVr1bgd0rit+NvFuh3SYR8QRyk6NGhshjVuKmP+e/RCNhX
         xn4YOi1ZZRsdmrjZ8/EomStPOM417Tsxht/uhUjJAOcyf8WyGdW8JLjXHJ4bJ/jfa6Q6
         LxvLvzSM14ehXZegX3wy7e14T4eW5X7Fyi5x+kXpGbyQKRyMSgq/Au2I0/QecnzzTysd
         5VBavDYeRFuBbBFO5BVchKJcSVnHuzlN1CK9pi4QqkJ7oHvWrGO6VQJmbL7nqaIlKd0y
         qxEA5EOJ7FBRH34KiwOgdfrM7/0qd+CwS9rbQVzFR7krrROCjUcAUiU2xYlPl2aL3seT
         ALFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=5IPJg7E7sMxdt7QsK9Lbh8s2WDe0LKZbNAiRZg92kkM=;
        b=jZ9uJxCMaW56UgxbaKDTzhy+SuqPZNo7uaRVwWxNvLcMOeFQXohjIgFZtE01uDpwCT
         kiWSTacvVQdEtfnI/n90pLFjt9auGaWMTrk8ElwO6uB+GabFJIiVwbicKZ1tt8cM7Xc7
         Wx7HUEavs4bqwN2LaYHMzfHWvzk1LON6ZNTfl+kEIbVWW70AeELv6yRINDvfjp7iQSLn
         t/9wyq4TYjpFrJ9kwCyZQCIVK+8HvUTixVog5RblDVB0wEmG3dTV66/q0zriKbV9CMXV
         +cQOgfTQos7j7q+3iqryT/MtzRgpZWS6u6l6c0t+9Yh3vgloC1MM2hegbHXsAUlG3Ydu
         wYEQ==
X-Gm-Message-State: AD7BkJLQPCUxoPHuL5u1psv5gxGmZHfgF//sOtHJNTTY8ilUdcsqODjnyV91XrzWstoV4A==
X-Received: by 10.141.4.135 with SMTP id g129mr17668260qhd.31.1458239469223;
        Thu, 17 Mar 2016 11:31:09 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id w1sm4307700qha.3.2016.03.17.11.31.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Mar 2016 11:31:08 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603171536420.4690@virtualbox>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289138>

On Thu, 2016-03-17 at 15:43 +0100, Johannes Schindelin wrote:
> Hi Duy,
> 
> On Thu, 17 Mar 2016, Duy Nguyen wrote:
> 
> > On Thu, Mar 17, 2016 at 1:27 AM, Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > > I am much more concerned about concurrent accesses and the
> > > communication
> > > between the Git processes and the index-helper. Writing to the
> > > .pid file
> > > sounds very fragile to me, in particular when multiple processes
> > > can poke
> > > the index-helper in succession and some readers are unaware that
> > > the index
> > > is being refreshed.
> > 
> > It's not that bad.
> 
> Well, the way I read the code it is possible that:
> 
> 1. Git process 1 starts, reading the index
> 2. Git process 2 starts, poking the index-helper
> 3. The index-helper updates the .pid file (why not set a bit in the
> shared
>    memory?) with a prefix "W"
> 4. Git process 2 reads the .pid file and waits for the "W" to go away
>    (what if index-helper is not fast enough to write the "W"?)
> 5. Git process 1 access the index, happily oblivious that it is being
>    updated and the data is in an inconsistent state


That's not quite how I understand it.  It's more like MVCC.  Writes to
the index go to a new index file.  Index files are identified by their
SHA.  Reads from the index go into a new shm, identified by SHA.  

The "W" is set only once -- it just means "this index helper knows how
to talk to watchman".  It's a compile-time option.

(I'm going to change this anyway when I switch to named pipes).

The watchman data is shared independently; if it's not ready in time
(whatever that means -- it's 1s in the current code), then read-cache
should fall back to brute-force checking every file.

> > We should have protection in place to deal with this and fall back
> > to
> > reading directly from file when things get suspicious.
> 
> I really want to prevent that. I know of use cases where the index
> weighs
> 300MB, and falling back to reading it directly *really* hurts.





> > But I agree that sending UNIX signals (or PostMessage) is not
> > really
> > good communication.
> 
> Yeah, I really would like two-way communication instead. Named pipes?
> They'd have the advantage that you could use the full path to the
> index as
> identifier.
> 
> The way I read the current code, we would actually create a different
> shared memory every time the index changes because its checksum is
> part of
> the shared memory's "path"...
> 
> Ciao,
> Dscho
