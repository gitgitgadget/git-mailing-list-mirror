From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v10 20/20] untracked-cache: config option
Date: Mon, 16 May 2016 14:03:16 -0400
Organization: Twitter
Message-ID: <1463421796.24478.65.camel@twopensource.com>
References: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
	 <1463084415-19826-21-git-send-email-dturner@twopensource.com>
	 <CACsJy8CV4tue8LscUuBcVyu-xnKadtJEajr7+X-q-RhqgdW01g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 20:03:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2MrT-0004CO-MN
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 20:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754415AbcEPSDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 14:03:19 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35712 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754358AbcEPSDS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 14:03:18 -0400
Received: by mail-qk0-f181.google.com with SMTP id n62so89067640qkc.2
        for <git@vger.kernel.org>; Mon, 16 May 2016 11:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=3ZS1lrHmX+Ipc+97JBbwH9Wxf0X3W2ozHZa+SRmBsHM=;
        b=VAQHsx7hdZlnRv1bvSFDn3WeaZA8UrBcgc/ysyIhL8ioUFc8qBL+eI54tmT5N+E6CX
         JCgpUGcCEdsJ+KK01Jm3aE5W541i46DG0I+LkqcblSWbdoN+UnLS7QRFRJsD4rOzp+Cg
         /QE61Vy+A9Mk5tl6lmLKuwgd5SExsjTfrnbFxeR/9ffac/ksnIdBlzWUYR3GSSjr5/hr
         r8blNIOjzfN8jtB8M2xyf8xipE1QG9BnfK59qxaJZbX+Dtb4pXw3VJ+F+hmAdjpdXyV8
         6GLkExaqL1ACeaWEIt5u37dFKK/OXKXKBJYypn0NhlMTR711v8sUihG7TZxu0VqFnTor
         4AhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=3ZS1lrHmX+Ipc+97JBbwH9Wxf0X3W2ozHZa+SRmBsHM=;
        b=bmphXDE98dlKtBZbrYNilHUa/rzEaCNewh+j9EhZpB7XTIQtf5g5C3ko/K3p9Tndln
         NX/UOpr24rndCXSPbsXRVyniO8NezO1H8NQKGGYz3qzaK/ObkCKjtQrwiencP8g98ZNC
         08wRdca4cUKqBe2EtHCCdXdVEeDPt0VMcGQwG4HG5niaJjm97K0TGsOmSq+Gfh8k6kqN
         sN0oyJgGGxhnlelNd9M/riMFm167bZCgG+7Z8wGefa1CW8IwoJ/62VjYjOcpad76TIA3
         vFd5I3b8lpv5c38nJlCtu6dCCkj8mNZkQ27bpOzsnqSBIH5PoTd419YthMM/8XbU8/5N
         DRQQ==
X-Gm-Message-State: AOPr4FWTxp4l0FYf5JJj45P6yVVmEEXUl8jSpaWKy8FhgBR344y/7M8wAez8Tilf9Qnr7g==
X-Received: by 10.55.21.217 with SMTP id 86mr30985713qkv.4.1463421797552;
        Mon, 16 May 2016 11:03:17 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 134sm15102028qkh.10.2016.05.16.11.03.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 May 2016 11:03:16 -0700 (PDT)
In-Reply-To: <CACsJy8CV4tue8LscUuBcVyu-xnKadtJEajr7+X-q-RhqgdW01g@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294765>

On Sun, 2016-05-15 at 16:43 +0700, Duy Nguyen wrote:
> On Fri, May 13, 2016 at 3:20 AM, David Turner <
> dturner@twopensource.com> wrote:
> > Add a config option to populate the untracked cache.
> > 
> > For installations that have centrally-managed configuration, it's
> > easier to set a config once than to run update-index on every
> > repository.
> 
> This sounds like the job for core.untrackedCache. It populates after
> reading the index though (in post_read_index_from) not writing, but I
> think it accomplishes the same thing.

OK, I'll drop this one.

> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> >  Documentation/config.txt | 4 ++++
> >  read-cache.c             | 7 ++++++-
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index 385ea66..c7b76ef 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -1848,6 +1848,10 @@ imap::
> >         The configuration variables in the 'imap' section are
> > described
> >         in linkgit:git-imap-send[1].
> > 
> > +index.adduntrackedcache::
> > +       Automatically populate the untracked cache whenever the
> > index
> > +       is written.
> > +
> >  index.addwatchmanextension::
> >         Automatically add the watchman extension to the index
> > whenever
> >         it is written.
> > diff --git a/read-cache.c b/read-cache.c
> > index 22c64d0..4a1cccf 100644
> > --- a/read-cache.c
> > +++ b/read-cache.c
> > @@ -2472,7 +2472,7 @@ static int do_write_index(struct index_state
> > *istate, int newfd,
> >         int entries = istate->cache_nr;
> >         struct stat st;
> >         struct strbuf previous_name_buf = STRBUF_INIT,
> > *previous_name;
> > -       int watchman = 0;
> > +       int watchman = 0, untracked = 0;
> >         uint64_t start = getnanotime();
> > 
> >         for (i = removed = extended = 0; i < entries; i++) {
> > @@ -2502,6 +2502,11 @@ static int do_write_index(struct index_state
> > *istate, int newfd,
> >             !the_index.last_update)
> >                 the_index.last_update = xstrdup("");
> > 
> > +       if (!git_config_get_bool("index.adduntrackedcache",
> > &untracked) &&
> > +           untracked &&
> > +           !istate->untracked)
> > +               add_untracked_cache(&the_index);
> > +
> >         hdr_version = istate->version;
> > 
> >         hdr.hdr_signature = htonl(CACHE_SIGNATURE);
> > --
> > 2.4.2.767.g62658d5-twtrsrc
> > 
> 
> 
> 
