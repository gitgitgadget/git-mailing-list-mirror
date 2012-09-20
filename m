From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Disable dumb HTTP fallback with GIT_CURL_FALLBACK=0
Date: Wed, 19 Sep 2012 20:22:58 -0700
Message-ID: <CAJo=hJtx25=5Lb3sgu_o42=VrcXkRE1DF_noPpjqyjE1zuzKJg@mail.gmail.com>
References: <1348109753-32388-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 05:23:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEXMO-0005L9-D4
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 05:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041Ab2ITDXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 23:23:20 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:62665 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360Ab2ITDXT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 23:23:19 -0400
Received: by qaas11 with SMTP id s11so57611qaa.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 20:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rtVnLi/4GRAm8ejLWoUJNu2rAu+SOleojcIgHA18vHE=;
        b=C9E7TY59dT7B58KXZpPXy2wkdJGFbQup2hbbUfdMClzgyUPOwYVFStkwRjPDOJ2XIf
         NS3g4wJSjc2Nz5CVIk7Po3tNZyQ9u4hjBwDdQtIFzAi5AjL0Uz0xQ69RgNfEJxwiYB2u
         /7VMa2rKIBTairxuzm+cj8jinEjrnpOYYru9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=rtVnLi/4GRAm8ejLWoUJNu2rAu+SOleojcIgHA18vHE=;
        b=jpt0HO0/FvqDobFyjVlGjY2FOEuE16bFdmclwBL1v3KUmA8Dwws5YfT9Q1gSWhv2Mh
         FsFL+eLu/BZQ91oYNa8OgDaoPrKttmfLQZ79Gj6bydk/p9lyUdbSl5dfTBd7PeAA6/3A
         Z0LW2D+CTbG4FaelanNH1NMEJu/7JPIEfUHtld3tSqnfOFRftJ51RrBqfblVkYC5/0dR
         MdDXhlu+Bpc9kZNmYCedasP5OWBiADofi1X9FO35I+1Y0O0MnDXaTNvFyFZ/43S6D7iI
         uGqMx7Oh5uQskfSkdwEgnVq8V38sQmClEOfTTDu9MAtuU138v6vCkrpZJm8wxOPnOn5L
         TIjA==
Received: by 10.224.213.198 with SMTP id gx6mr1953848qab.9.1348111398275; Wed,
 19 Sep 2012 20:23:18 -0700 (PDT)
Received: by 10.49.35.75 with HTTP; Wed, 19 Sep 2012 20:22:58 -0700 (PDT)
In-Reply-To: <1348109753-32388-1-git-send-email-spearce@spearce.org>
X-Gm-Message-State: ALoCoQm/WgJI3QtNE5JItBJtkXgwb+AGhqxHeSAPIKWUUz0cvvYIovXDZqTNw+Hx7itwckD7lFrM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206028>

On Wed, Sep 19, 2012 at 7:55 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> From: "Shawn O. Pearce" <spearce@spearce.org>

I can't explain why git send-email did this. I obviously didn't need
the extra From header here. format-patch didn't write it to the patch
file, it was injected by send-email. My .git/config is pretty simple,
the name/email are derived from there:

  [user]
	name = Shawn O. Pearce
	email = spearce@spearce.org

Ick. I really don't want to debug this right now so I'm just going to
pretend it wasn't written.
