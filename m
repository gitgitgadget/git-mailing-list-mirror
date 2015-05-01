From: Stefan Beller <sbeller@google.com>
Subject: Re: Patch that modifies git usage message
Date: Fri, 1 May 2015 08:51:07 -0700
Message-ID: <CAGZ79kY1ZoYrVwVVqfyB+uMGsJo59qDxbDLgyo5qygSm=CUVhA@mail.gmail.com>
References: <CAKB+oNtYbJXNb2wGzJCdQ5Ru5fq3HzcapSqiTVC_34=xDnTb7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Alangi Derick <alangiderick@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 01 17:51:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoDDe-0004Br-AJ
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 17:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956AbbEAPvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 11:51:09 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36357 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753543AbbEAPvI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 11:51:08 -0400
Received: by igblo3 with SMTP id lo3so41444910igb.1
        for <git@vger.kernel.org>; Fri, 01 May 2015 08:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jduHRXUJfucWxIZONRa6eIO/hNCgfc7R4/4aypr/fas=;
        b=VGtiOasPF68QZasV2ZHFVslyyhRSCIyPxdbED8U3lV+Gpmgj5UeRbysVYOFg3AB6s0
         fLvynickJ8oCRQj97J6iPzJhg57oUAQmb/xDAtcen/j3DGgGCXT1O9P85dRxWpZRu0TN
         8BoZBNGtwVZZkzuWvyaXiRUnsXTgoRBObeZvXnikvYTRzkFw54FMFiL6GPZMd1mPZ9iP
         YKeBvGdX6Wg9V3Wkmk1GWxFc0RaOUStCUAVTJONd78X9oI8mQOlQ6a28jEPyt1zC61qP
         rIk3oEG1cwtHS0eE9u1VMPR10rarKyQawdb8R0DB6knh6fyW2PmCTWAi4UMLIr0/bCkq
         DL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=jduHRXUJfucWxIZONRa6eIO/hNCgfc7R4/4aypr/fas=;
        b=gY5orqy8XSuFUMStMAl/woDeYhdn/VeUnPk57cg1Q2tZV7qVvi6COzFxplu9eVv5WI
         pmmst4mLFrJ3l52lld/AL8s+HexHdov8L+ujYh0dxs9Q9DbnqfGrDH2kgOqfdLbUDpy+
         MgQSe6URKehSk4YPoO5Pe6KMmvLim4kh8bLhuCc/CSOMyYUgLKGVG6JtaJ5YWEasU9gr
         32O3AIap6yfmmFQ0HZTvwmKLLYxpcOVkvdHXpdZAuNlpZbj3frB3Fmyd13N5qqPVtOkb
         pQJku/lMb1NHqH/3no2PYqgnhdISbPMeZHEWZnFby1Gh4WPCb9wHU31WtPZAc2Z/jNut
         yacA==
X-Gm-Message-State: ALoCoQlBF3H9vDWD0ynH/gdazxaWFcIEOWlzJ5QffP6yXGGh5SA+cr2klv1+Se5+ZXUZLbu8cSfw
X-Received: by 10.50.138.71 with SMTP id qo7mr11063827igb.10.1430495467421;
 Fri, 01 May 2015 08:51:07 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Fri, 1 May 2015 08:51:07 -0700 (PDT)
In-Reply-To: <CAKB+oNtYbJXNb2wGzJCdQ5Ru5fq3HzcapSqiTVC_34=xDnTb7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268150>

On Fri, May 1, 2015 at 4:01 AM, Alangi Derick <alangiderick@gmail.com> wrote:
> This patch just modifies the "usage" word to "Usage" which enhances
> readability. Below is the patch
>
> Regards
> Alangi Derick Ndimnain

It's easier to have the patch in the email itself, this looks it's
some form of attachment.

Checkout Documentation/SubmittingPatches (protip: get "git send-email"
working, it will
send in the preferred way by default for nearly any open source
project using email based
workflows.)

There are also some resources on the web, how to send patches,
although it should be
all covered in our Documentation,
http://alblue.bandlem.com/2011/12/git-tip-of-week-patches-by-email.html

For the patch itself:

$ grep -r usage *.c builtin/*.c |wc -l
551
$ grep -r Usage *.c builtin/*.c |wc -l
3

The community agreed (maybe subconciously) to prefer lower case
for the 'usage' string, so I don't think this is an improvement.
