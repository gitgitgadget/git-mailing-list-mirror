From: David Turner <dturner@twopensource.com>
Subject: Re: [WIP PATCH 00/14] Protocol v2 patches
Date: Wed, 25 May 2016 12:45:46 -0400
Organization: Twitter
Message-ID: <1464194746.24478.135.camel@twopensource.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
	 <1464130008.24478.134.camel@twopensource.com>
	 <CACsJy8DkMDF85NMS8wS3CsNdt-vDpu6WajY1snxWV0GyeUJ7Vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 18:45:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5bwQ-0004yI-57
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 18:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755708AbcEYQpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 12:45:50 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35151 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755424AbcEYQpt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 12:45:49 -0400
Received: by mail-qk0-f171.google.com with SMTP id h185so11080451qke.2
        for <git@vger.kernel.org>; Wed, 25 May 2016 09:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=/xEgiK6A3nGzeE84OkHxT30osE+LYBkFr4xOTVZec40=;
        b=krjYZ0Ry9O0BV0OM9pr7STOWsE8pdymd6NOqO9dDw3MOrT6E2sYt2vMc6jjNWhLclv
         9ccttaxcXuSZHGc/CDIWikIKcapjrlyuyiLzmGBhwmODb0wmzyFk7eeRkZnFU76W269Z
         scFA3daZTdzg2Jhdw+nTy0UMW9vk1h8O5ZnO5fKr7IMkV+t0KmKSoZtyB/xb4ieOpWgs
         eNPojf0ZtQssFejuap9YT04oeOsFLPBvegUtSh/iE+bqYEhwaINhDNWuOstR5kvf2WAv
         fm9fMxB7h2fTSkwJMnsxXOk9axSQnPUJakPvDANkfdPVxmgYXUZAJtOaS7V04Vr551l3
         ASYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=/xEgiK6A3nGzeE84OkHxT30osE+LYBkFr4xOTVZec40=;
        b=ST00NNCe8uvg6aYV5Ux6FCg+lyK4dURdulAlQyX3aZMePjpn02gNwvgoCzjin5fi+x
         r0GgVMs/57bU8DpR4qxqrlgsg1PqbuqXEMu0qZrCgWDLuT/0nmXZA4peS8CDTL99Rvas
         LejmHed4NPMtrWt7c68+siHFohScXrKFNi7jQG38+tRHjTmJ688lhWGsAc4SAYgJVKnP
         Es6hFGXkosetA8wkBk26u5ulUmJgnpVDThtb6IXWnLXYPfLVkM3Ptcui3mcwE0uS6zq7
         NhhSXEgbzND3FhqxQ5Px4S4zGYfHKPi0CzHpmlBMswyaOpZcwmcxOm8YuhkoVPGgm90S
         eV/A==
X-Gm-Message-State: ALyK8tIM8WUKJfDqFpO6Ftba6tt8pyy06lkATsfnRstqIuwSjz99fotWpcWIVd+riBedjg==
X-Received: by 10.55.163.214 with SMTP id m205mr4572136qke.21.1464194748373;
        Wed, 25 May 2016 09:45:48 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id i131sm2554696qke.48.2016.05.25.09.45.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 May 2016 09:45:47 -0700 (PDT)
In-Reply-To: <CACsJy8DkMDF85NMS8wS3CsNdt-vDpu6WajY1snxWV0GyeUJ7Vw@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295579>

On Wed, 2016-05-25 at 06:03 +0700, Duy Nguyen wrote:
> On Wed, May 25, 2016 at 5:46 AM, David Turner <
> dturner@twopensource.com> wrote:
> > I was looking at this again today, and noticed that it doesn't
> > really
> > address the HTTP case.
> > 
> > The central problem is that protocol v2 goes like this:
> > server: I have capabilities w,x,y, and z
> > client: I want capabilities x and z.
> > 
> > But HTTP goes like this:
> > client: [request]
> > server: [response]
> > 
> > I tried to make libcurl do the receive-before-sending thing, but it
> > doesn't seem to be designed for it (even if you prime things by
> > sending
> > a "hello" from the client first).  My thought was to hook up
> > CURLOPT_READFUNCTION and CURLOPT_WRITEFUNCTION, and have the read
> > function return CURL_READFUNC_PAUSE and then have the write
> > (=client
> > receiving data ) function unpause the reader (= client sending
> > data)
> > once it gets the capabilities.  But apparently pausing only works
> > with
> > chunked encoding, which seems to cause Apache's mod_cgi to fail.
> > 
> > Maybe I'm missing something.  Has anyone else ever made something
> > like
> > this work?
> 
> It simply takes one more round-trip to negotiate. Not the best thing,
> but...

Do you mean that it can be done with libcurl?  Or do you mean that I
should go with the /capabilities endpoint?
