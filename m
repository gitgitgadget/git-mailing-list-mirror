From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH/RFC 6/6] clone: send refspec for single-branch clones
Date: Tue, 19 Apr 2016 17:24:24 -0400
Organization: Twitter
Message-ID: <1461101064.5540.118.camel@twopensource.com>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
	 <1460747949-3514-7-git-send-email-dturner@twopensource.com>
	 <CAPig+cRGDsBn4EKWn7Vqqmt_ZhZbYgUh9Tg-rgQPchn015SNMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 23:24:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asd8P-0001B6-8Y
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 23:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932937AbcDSVY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 17:24:28 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:34796 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932903AbcDSVY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 17:24:27 -0400
Received: by mail-qg0-f49.google.com with SMTP id c6so17697013qga.1
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 14:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=2aSmNPTAl1sjNxlLAC7sSkhw4Aj3/evSFasSQCTlYRs=;
        b=F7FvzM6koGsd9vE0ceVdu2a88DkUHxPuQxPrwSyefLll6c1s92hIR0qD16c6Bm+n0W
         DgE+8NOt5XlusFTCRAXYCgouF7HKzeJGVVXGq3rfc6EKXlz4eAfaM6tPefYnwoSUMzFZ
         GwprExk6HLhKNtBYRVS1levwQm06u2l0VXXXZL7rfn25duPSHEGjlUT6LW+yrI4v87MO
         mZfts0VRknRprNoA4G9J/dRJ0Ih2MLmrW7JY3upmCfj8x8YC01D9SFf1yjvkkc03zMhT
         75L02ikE8AgBoVdgKpD96xB9v2ansy1yIIUkZ+SEABk60WSa4CkWw83Ra28HL9O6biUm
         8qyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=2aSmNPTAl1sjNxlLAC7sSkhw4Aj3/evSFasSQCTlYRs=;
        b=HITKwyPM16M5lz0NH6jWHkTLFNzRXx/q+joQN07F75zzxunD1ssItqQHT7ZMNhXUmG
         zRZ4YkEZJ/ZT6MbyFvtkPOl1cWmcmCRYgYZKEU1C/DtGM9sjSHV1DbkVYiq/88ZRWLOE
         LBO2FlEBQp3eaai6E9U/d1HzJ0XeavI/G03cN2dFGzqcOpHtsefzW02RgvJYXMZKG2q2
         USHlCzbuhzcuxPNftEdC/OHgMLhDzJ33ZMgsoLJ7jbDmo6jass5/PaqHOQmmbSZLMtIJ
         kmA9e3xYfz0QC+luxCeuVSMiNsifZ1qlqlyshvBDI7jaeUnfhEfqA0HoFzusy4OYVBsn
         ISiA==
X-Gm-Message-State: AOPr4FV6iRBsQHVeJJGLOlUQ2LoV7ybZqtqHAMB6doFwCCMtk3kxGOUrVH+NdZWr0UHf3g==
X-Received: by 10.140.30.247 with SMTP id d110mr6485160qgd.43.1461101066565;
        Tue, 19 Apr 2016 14:24:26 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id i67sm29547493qhi.45.2016.04.19.14.24.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 14:24:25 -0700 (PDT)
In-Reply-To: <CAPig+cRGDsBn4EKWn7Vqqmt_ZhZbYgUh9Tg-rgQPchn015SNMw@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291928>

On Sat, 2016-04-16 at 22:36 -0400, Eric Sunshine wrote:
> On Fri, Apr 15, 2016 at 3:19 PM, David Turner <
> dturner@twopensource.com> wrote:
> > For single-branch clones (when we know in advance what the remote
> > branch name will be), send a refspec so that the server doesn't
> > tell us about any other refs.
> > 
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > @@ -1010,7 +1010,21 @@ int cmd_clone(int argc, const char **argv,
> > const char *prefix)
> > +       if (option_single_branch && option_branch) {
> > +               struct refspec branch_refspec = {0};
> > +
> > +               if (starts_with(option_branch, "refs/")) {
> > +                       branch_refspec.src =
> > xstrdup(option_branch);
> > +               } else {
> > +                       struct strbuf buf = STRBUF_INIT;
> > +                       strbuf_addf(&buf, "refs/heads/%s",
> > option_branch);
> > +                       branch_refspec.src = strbuf_detach(&buf,
> > NULL);
> 
> branch_refspec.src = xstrfmt("refs/heads/%s", option_branch);


Will fix, thanks.
