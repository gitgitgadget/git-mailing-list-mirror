From: Stefan Beller <sbeller@google.com>
Subject: Re: Looking for a solution
Date: Fri, 1 May 2015 11:03:32 -0700
Message-ID: <CAGZ79ka=jabDgE2LO5YLAZFyWwKneomwoA59aPiG7SF1y_gNtw@mail.gmail.com>
References: <CAFX4i8EyQ=0EV=XMCQ42GfYzjbAXc5ELSCFqEejS5ObYioqBEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Yuvi <myuvarani@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 01 20:03:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoFHl-0003OX-UQ
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 20:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbbEASDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 14:03:34 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:33658 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbbEASDd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 14:03:33 -0400
Received: by iecrt8 with SMTP id rt8so94065160iec.0
        for <git@vger.kernel.org>; Fri, 01 May 2015 11:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sZ8w+jRngxK7JqMcrHWyFGAX8gDR3t3ksyWYQfrrrgE=;
        b=Szj4VPFi5NjgM6+mElGpH1giSOu0wh9MjDspM+DITRfKGr39RoD643VYLZVqY/X2UB
         xWY3z9FB7E54WBmH4HFVzp9JzHwoPfTLpdAHXpbQ/ZA4wFjApoxHqfv6yiozJIxRY40y
         ZOmz611SVqo72wccGscAILCRnP6SwFTV2Gc2qHYFn+XvocLa2f98zzaja2AgSjRjGdwn
         Qw1QTo/rol/xPiUyprr/JNdPBFRenolSJ4eE0cTEILjDhYj11O87hTIDGZ6h2xjG/ZN9
         pvWjpTNqSyOoV53gelvcTU5ijQubgGrds+MOoVGk81z8C4Fxus861i7s1y+ay4SjFnVu
         7oaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=sZ8w+jRngxK7JqMcrHWyFGAX8gDR3t3ksyWYQfrrrgE=;
        b=eXs+woUOXlML7qrdjMRFXHB3FwuLwXoiOBPRO5rCJH/3ecoKbcqKrrek3zlZwyskB/
         N0p3FjprDdhNm2e6oIZoJOA28YQWVgVxsdRZZlcdfB5o9C5qtfC8Edfc9uWwF4QrHN/6
         NPbCC6LMyTRlRh6R5WSDQaih2oQgt2OAJKibLzUDAAKdQBBOWV2mmPrhiEvYBA1hXBZP
         P1B2Tm305CzbP1BZ575Isx/Kji1e9ta1iq2pHJIm+wd1zsL0iYhmv0bB+oquW1yRrT9V
         pkAgRIMQJKLOJV1gBWpwW1kh4UmWeGevnizN6RDjjqX3QiUlGt3qGtfgf1aVuK1ov5vT
         /v/A==
X-Gm-Message-State: ALoCoQmT/jXjHvkWHH2Xxch5PwAWSC0GfQfc8hYm3IqRdYQUdQbEAoYYR/MsdCLCC2E3hDul9MNF
X-Received: by 10.107.170.135 with SMTP id g7mr14074142ioj.2.1430503412729;
 Fri, 01 May 2015 11:03:32 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Fri, 1 May 2015 11:03:32 -0700 (PDT)
In-Reply-To: <CAFX4i8EyQ=0EV=XMCQ42GfYzjbAXc5ELSCFqEejS5ObYioqBEg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268169>

On Fri, May 1, 2015 at 9:07 AM, Yuvi <myuvarani@gmail.com> wrote:
> Hello There,
>
> Here is the problem I am running into.
>
> I pushed the committed changes into GIT repository sometime during end
> of Jan. I realized that the changes are not existing. I suspect
> someone has reverted them.
>
> Wondering is there anyway around to get the changes back or can I see
> who reverted the changes on a specific file ?
>

Look at http://git-scm.com/docs/git-log
