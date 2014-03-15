From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/6] Fix misuses of "nor"
Date: Sat, 15 Mar 2014 15:56:03 +0700
Message-ID: <CACsJy8C2Qainuix2CXy7P71BxE1ajrzfxYMmNAyVa04mfSJJ-A@mail.gmail.com>
References: <1394872922-2000-1-git-send-email-jlebar@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Richard Hansen <rhansen@bbn.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Justin Lebar <jlebar@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 15 09:56:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOkOj-0002Cf-Cn
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 09:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097AbaCOI4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 04:56:36 -0400
Received: from mail-qa0-f47.google.com ([209.85.216.47]:39805 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbaCOI4e (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 04:56:34 -0400
Received: by mail-qa0-f47.google.com with SMTP id w5so3525325qac.34
        for <git@vger.kernel.org>; Sat, 15 Mar 2014 01:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HQQa2odXQtDn5gyEjxBtDHQ6kSOWgfgZFMnlTSRHYtc=;
        b=vBMbu6DEwisCKVjouXc2sZwCk2VONRYyPsY80rhrtXoCmdhTZxBRgAerX2+UWE5tkQ
         Y0IatkrKkQfJd6SlHsZpyrsuwTnDvGVSDJBjuX7G8RQHWgd2HS9qmHcrv9F0a14fQf3X
         fCeS07MqpfmmzbMojBiub0LkAQX7Hu8r0zTJghic0VyCeZ8vUnzAXC6YfM7E10djOTkF
         9FlZQBFSorf8WcTT58YzcyoA+WxWi6Ou0dzrlXUoIHP0z7mf/GPepCyBADXEQPYzkIDi
         0f2yaeyHrLYQIUfc3egRXi7IS6TEgbAyVyNHLMdkGoWy7f0nnrUrOtlabIjJBQjXZ+c6
         Mh9Q==
X-Received: by 10.224.80.134 with SMTP id t6mr15379828qak.34.1394873793579;
 Sat, 15 Mar 2014 01:56:33 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Sat, 15 Mar 2014 01:56:03 -0700 (PDT)
In-Reply-To: <1394872922-2000-1-git-send-email-jlebar@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244149>

On Sat, Mar 15, 2014 at 3:41 PM, Justin Lebar <jlebar@google.com> wrote:
> I got annoyed by git's awkward use of "nor" in man pages and in git add -p, so
> I went ahead and audited all uses of "nor" in the tree.  One might be able to
> argue that some of the uses I've changed are technically acceptable, but that's
> a pretty low bar to set for ourselves.  I aimed to make everything both correct
> and idiomatic.

I guess I'm cc'd because I made a few of those or/nor mistakes. Being
a non-native English speaker I'm not really qualified to review this.
But I suggest that you merge "Fix misuses of "nor" outside comments"
and "Tests: Fix muses of "nor"" into one. Otherwise you break the test
suite at 5/6 (and 6/6 fixes it, but breaking the test suite at any
commit is not very bisect-friendly).
-- 
Duy
