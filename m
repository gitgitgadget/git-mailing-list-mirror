From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/4] glossary: define committish (a.k.a. commit-ish)
Date: Wed, 19 Jun 2013 09:49:37 +0530
Message-ID: <CALkWK0mo2SG+Eh1Qmy58Xo-taG_EGEj9RSx65EYhvs2CLK9dUA@mail.gmail.com>
References: <1371607780-2966-1-git-send-email-rhansen@bbn.com> <1371607780-2966-3-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 06:20:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up9se-0006Vq-3V
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 06:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866Ab3FSEUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 00:20:19 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:54386 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778Ab3FSEUS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 00:20:18 -0400
Received: by mail-ie0-f175.google.com with SMTP id a13so12123034iee.20
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 21:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SkUzwDmiPFbk05ZXE9ebffDLD7DI2xUybEwYb86jTCI=;
        b=jqzteGW8gtWX/EcafzQvSapWCQv2FWRy1uHdQlaHkOX3aTT1zNf6Rnoi/cJh+CQ7yI
         u7nB5JNMUExXSGEzsHVNEdYsNamFj5X2+y+Bj3Tc23DBD2ThTEJqv6nN3rQTQaNaNX1E
         qZ9JaBTU6Ivt7cSFXASAiJxoP/4vEK3qRdnZqXPfmP6JOLni7OhQocrjDcw5CsltWzlN
         F7Cee4a60O0qfM6FCR9YAiK/Qt7JFG7ZDdILhX005vVfQ/+CvCaWHId5Xp7CJySiBrA+
         P55PqV4cBjgNiBC4kWjboR/JSo0xvAKTT7BLg3ThW1chDmMx1qckj+YmJ/bm6NC2v4as
         e8yg==
X-Received: by 10.50.25.194 with SMTP id e2mr388996igg.111.1371615618083; Tue,
 18 Jun 2013 21:20:18 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 18 Jun 2013 21:19:37 -0700 (PDT)
In-Reply-To: <1371607780-2966-3-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228337>

Richard Hansen wrote:
> +[[def_committish]]committish (also commit-ish)::

Good.

> +       A <<def_ref,ref>> pointing to an <<def_object,object>> that
> +       can be recursively dereferenced to a
> +       <<def_commit_object,commit object>>.
> +       The following are all committishes:
> +       a ref pointing to a commit object,
> +       a ref pointing to a <<def_tag_object,tag object>> that points
> +       to a commit object,
> +       a ref pointing to a tag object that points to a tag object
> +       that points to a commit object, etc.

Is master~3 a committish?  What about :/foomery?  Look at the other
forms in gitrevisions(7); master:quuxery, master^{tree} are notable
exceptions.

Thanks.
