From: Dave Borowitz <dborowitz@google.com>
Subject: Re: An option to sign the push by default
Date: Thu, 13 Aug 2015 15:02:25 -0400
Message-ID: <CAD0k6qRh=E12kbpcwW-_GLQ9AmTNsfhnEgE4QtH7v50Zbn5_Fw@mail.gmail.com>
References: <2404018.OElJjohJ7Q@arcadia>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Agostino Sarubbo <ago@gentoo.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 21:02:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPxm6-0004hW-TU
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 21:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862AbbHMTCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 15:02:46 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:35975 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474AbbHMTCp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 15:02:45 -0400
Received: by iodv127 with SMTP id v127so46347401iod.3
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 12:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=G/0yBBvxZnwehcMhHRaRGDm25o6erTjUlNeEFo718Tk=;
        b=KRSjT/0dtWKfu5uSbEV6JHca1jDA16KiA6lcfDD3dkzawHKnOJUd44muS2HtLhbDF4
         K4hwgRpugrmZMYpmowlPvnxZhXuKfRpCZO+0IYrhfgDqifSQWloOQPz1tehCPMMJYR6A
         m/D/DVYivuX7jD0tz0e6mTA7+u10QVV45I/fghzh2tdK1KHVfYO6vQkKLp2NyAIRtGpb
         h93ousnj4gr62BJ6i17zbP4/L8W9kh3tlHEA0XyWwKiSl/n4oDm3v2sxmW057fXYF/NO
         ECTYNyMNcfj9hiHnTcn1F+oafIMQyiWcKJs1y2gnyoS1HUAnogFxxqKa6gqJo0heKD1+
         NEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=G/0yBBvxZnwehcMhHRaRGDm25o6erTjUlNeEFo718Tk=;
        b=YlrQM76ejUFbBeBpJfqe0ydNBxkiI/4LDjcmHXlA71FlfNubt0xACg2cxXlIPrSVb+
         ddQHTrx1VSN3GZuy24vQmqMfOLw8EQqUVZH0OQMs5E+QC5k6qmPrNDQ0+IPjrWWqkNqg
         LdG/JCYH+rz9BRqrEVGR8qWR5ULn0d8eijBScwpIrupDLOj2DjABMCUnhrZ25orAynWA
         3haLvgBG/nUmMRdOC6KRN5AnEmiGsKplg7fe/g/TNOgrAaq3o6QBe5LXMj6mIRJVnySt
         RDNO0MyRfUxjSrQbAW2XKNueHOR+EvAizLwruv+FcrCFSYsJYMrXFSv+HGhVYyoXd8i7
         8zTQ==
X-Gm-Message-State: ALoCoQkW0mkd+KXAxVuCeBdGWNqSt2/QrEh9Zygt6I36U2+n4j/OhCRR8i0Qc/spEcap4VONcXGq
X-Received: by 10.107.160.197 with SMTP id j188mr44763688ioe.194.1439492565012;
 Thu, 13 Aug 2015 12:02:45 -0700 (PDT)
Received: by 10.107.4.201 with HTTP; Thu, 13 Aug 2015 12:02:25 -0700 (PDT)
In-Reply-To: <2404018.OElJjohJ7Q@arcadia>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275884>

On Sun, Aug 9, 2015 at 12:57 PM, Agostino Sarubbo <ago@gentoo.org> wrote:
> Hello folks,
>
> during the configuration of git, client side, to sign all commit I used:
>
> git config --global commit.gpgsign "1"
>
>
> Since at push time I use:
>
> git push --signed
>
> I'm wondering if there is a git config option which put something in the
> config file and avoid to type --signed.

I agree this would be useful, and that's why I just implemented it today :)

> If there isn't this feature, I'd like to know if it is a reasonable feature
> request.
>
> Thanks in advance.
>
>
> --
> Agostino Sarubbo
> Gentoo Linux Developer
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
