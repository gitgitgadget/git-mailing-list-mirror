From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v3 07/19] refs.c: remove the onerr argument to ref_transaction_commit
Date: Mon, 28 Apr 2014 11:27:15 -0700
Message-ID: <CAL=YDWkEWjeTZi6QOzosiaJ1ZA5p6zcD2asbJ4o8NW=4EHxhVQ@mail.gmail.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
	<1398442494-23438-8-git-send-email-sahlberg@google.com>
	<20140425224714.GF9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:31:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WerGn-0005gf-W0
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933000AbaD1TaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:30:19 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:51626 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443AbaD1TaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:30:16 -0400
Received: by mail-vc0-f176.google.com with SMTP id lc6so8748007vcb.35
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 12:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ANeEEq2FBo85kmrCFdq6ajROWY8xfW+DLSs8VnmzJEE=;
        b=iZXTcmf226V2cXXqH3CQqX/vY9MB5JdtSZ3TcXEfNnqeqiIC8z6rZtWgatDseD4iVq
         IlGaLcXBsUTNT1QlCkWMi9jQHm80qnVi9zzf8Q1T87PYs9uyMA/z7qg7G4Tw0sbwSe6k
         2byMu0WJXMZxVUGhlkIppBJSJyEYCcTyr8ZjUrVzPNSwJw0Suyt+cVQmZNn6q4rCWcQY
         DEqG+V9Dgl/wi6mP4FjXXhL19NF6P66fo3WCZwfhe+SIFvoA1X/NqZDiz47dHgqYVymS
         tJk1hNLQKl7nzSuOqFn2gJQQRbeG4fSos1/1oAeXAPADNY59tycj7cLei1jEAer0k3un
         mUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ANeEEq2FBo85kmrCFdq6ajROWY8xfW+DLSs8VnmzJEE=;
        b=k0p1ww8s/TS8QRHv+yJhRZ/dcqSBwHaPJ44uuw9kiv0ZZznDgGThifXNLD5ku0Urw5
         xR4CxbUtoPrWHw+0befE3h16kpkHiu+rk3Ry11c4DsUm/USv+vBctJWXrqALCjMIlmpR
         2p37dps+xBCaD8ueB9do5PdzuwJ45MJwRvYkVwWzNQvs3tvDCniBXFcD5sC1Y6gQTyVy
         dG5RlPO367EGoJLEW4azHJ/10Ji2isLXFvWMooAL/nlLaRhQhz5AxTtnTYeY33vWotR6
         lsLkLwosmW3Vmi+z1JVv3tsgu6OYA+rizKjLMM2m5rK1d0CQQJ9LEdMYTCLs2YsEydma
         Dcyw==
X-Gm-Message-State: ALoCoQnlFvAuoogpT5n7T+Xhbvfgj14E15FNRjKZulRZyqw2SXN1dk8XZ8hsxy8EN6E9bxa8K3hyAaHjOwzCJhkInqCddK5zCmXyXUApvxFBp57UbsPcSQ+sWosFItanFECdQ5L6xAGQVoJi8QRCLzjtEihbta2+gHaH66fCLw9NkuivpehWprtB+lUbbRK/YTv4OaisPYfg
X-Received: by 10.220.184.72 with SMTP id cj8mr9255950vcb.10.1398709635229;
 Mon, 28 Apr 2014 11:27:15 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Mon, 28 Apr 2014 11:27:15 -0700 (PDT)
In-Reply-To: <20140425224714.GF9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247409>

Thanks.

Reworded it that we remove it since all callers now use QUIET_ON_ERR

On Fri, Apr 25, 2014 at 3:47 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Since we now pass meaningful error messages back from ref_transaction_commit
>> on failures, we no longer need to provide a onerr argument.
>
> Yay!  More precisely, now that all callers use
> UPDATE_REFS_QUIET_ON_ERR there's no need to support any other
> behavior.
>
> Thanks for cleaning up the error handling here.
