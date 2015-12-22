From: Dave Borowitz <dborowitz@google.com>
Subject: Re: RefTree: Alternate ref backend
Date: Tue, 22 Dec 2015 09:04:12 -0800
Message-ID: <CAD0k6qT21siw00XMM6fSz2d9dT1yiTMh5ai9_w=fFk9GKin83w@mail.gmail.com>
References: <CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com>
 <56796F37.1000600@alum.mit.edu> <CAJo=hJtPSxY1YZgEt1AA_ukgY9cTA=1tdv_F+nCetv_Ux9E=3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>,
	Jeff King <peff@peff.net>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 22 18:04:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBQMW-0000XR-Ur
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 18:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932782AbbLVREd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 12:04:33 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:34214 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932129AbbLVREc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 12:04:32 -0500
Received: by mail-io0-f169.google.com with SMTP id e126so192663929ioa.1
        for <git@vger.kernel.org>; Tue, 22 Dec 2015 09:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7XCNO9RsYCLdsy7Gq054MQVpovXgk8m7O/lv1miZqxw=;
        b=YVLuxKjv+RoncvTJpxTaekWS3R2p4RqiGVKq7Zlyyh2fPpBGx3Mncl7Dp5vebOcmTI
         urIPcCR5T0Pq5sNc80WWtu4148Rq3kWHT5BkQs3NfURrLMmO1spdb88xyGrMqQxbn22m
         hjCaLp/a2WyZOd+WwhbalcUS2JioVqE9v0azTCpiJHWwPiZgbPpREmfi1CQy3a3IwYZt
         +Y4yzY3Ai9/VRsBzrbZmBPdfSJ6hiLSVBRrF3s5daz9f2IXTnn5tu/vcNQ/8qIyRaeSn
         WiI1Klw4fUvpUX023R9oGFxJcRe//BGHWUZTP984+ixRF0URtJY0+PULdtyyszByHVSp
         Zl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=7XCNO9RsYCLdsy7Gq054MQVpovXgk8m7O/lv1miZqxw=;
        b=KvfBLgcLVrjPn9nfNRQRnj5dgnK6uNLC8zz3GDXkOwQEmw1EOR3JXcZljqF2WDO0ZU
         m2qyfwyoKqE4ikbAClJdJv9eoDyVUyDN1Cdof24NRasSO+2VmpNO0xzk2vhvSLj90Wxp
         12iFAzXy8ZCmTFyQpy6juNYFrRDB/sJROdUvkb1L0PwndUl5Ml8QSnQdjg6XhoGTTciA
         tQ8lL5ASkrYGq7Uiyy21AQbOGKdIV/uRRi6ZKHydR7KpSt1KVL9dOO9uytfFl9u5UwaM
         +rWOel3ugRYrZzIH0oXytj4KMk8raU+6HSBSBQNGoHgYPAQoXURy+9DYFcIjc4ezyHmN
         bZOQ==
X-Gm-Message-State: ALoCoQlEe3m/VKPIW1PVhFfHOTkWbuvqq5ulkP0lagguZiaN7mgq7+EYoTpavcT3A/Subvyt7rPhU9nmln7/bsnPGyqDljQn/dsOT3sZavEW5ysNhKAwrco=
X-Received: by 10.107.62.136 with SMTP id l130mr11228814ioa.28.1450803872158;
 Tue, 22 Dec 2015 09:04:32 -0800 (PST)
Received: by 10.36.122.193 with HTTP; Tue, 22 Dec 2015 09:04:12 -0800 (PST)
In-Reply-To: <CAJo=hJtPSxY1YZgEt1AA_ukgY9cTA=1tdv_F+nCetv_Ux9E=3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282887>

On Tue, Dec 22, 2015 at 8:11 AM, Shawn Pearce <spearce@spearce.org> wrote:
> Yup, and Gerrit Code Review servers often have 100k+ refs per
> repository. We can't rewrite the entire store every time either. So
> its not a flat list. Its a directory structure using the / separators
> in the ref namespace.

I wonder if this might be insufficient in some cases, and additional
sharding might be required (though I haven't thought about how to do
that).

Chromium, for example, has upwards of 10k tags:
$ git ls-remote https://chromium.googlesource.com/chromium/src
refs/tags/\* | wc -l
8733

And I doubt it's unique in this regard.
