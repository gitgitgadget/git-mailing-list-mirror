From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: 0 bot for Git
Date: Wed, 13 Apr 2016 18:14:14 +0200
Message-ID: <8546368C-1884-4A56-AAA5-1E6B9C373E9F@gmail.com>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com> <CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com> <vpq60vnl28b.fsf@anie.imag.fr> <CAGZ79kaLQWVdehMu4nas6UBpCxnAB_-p=xPGH=aueMZXkGK_2Q@mail.gmail.com> <vpqoa9ea7vx.fsf@anie.imag.fr> <xmqqmvoypn7g.fsf@gitster.mtv.corp.google.com> <vpqegaa9i89.fsf@anie.imag.fr> <BF053934-BA62-4621-AAAA-11F821B274EA@gmail.com> <vpq1t69669d.fsf@anie.imag.fr>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, lkp@intel.com,
	Greg KH <gregkh@linuxfoundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Apr 13 18:14:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqNR4-0002zT-H9
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 18:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265AbcDMQO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 12:14:28 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38256 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754094AbcDMQOQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2016 12:14:16 -0400
Received: by mail-wm0-f47.google.com with SMTP id u206so87212545wme.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 09:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OLZ5Gh+X7NeGBeG6q/wLjvo22SRAfA4VNOC2v2prFeE=;
        b=lDH7a2Qq96C8EhaZ80hfC52dDt5IUoMtFG0+MQ334S2DWM21CWeVlxac7O6VUSy8pL
         fKJyuC8mwCDO+YpkIuhxFMH6ylXABlWvFHfIj5VBIjXPyg+2vFGVKFnw9n93+L4ldBX/
         T8TTzmdCYyRaz09LOBGfPCFnHmFv1/X6udMdpHYsc3uDDWIXanWBKjxzXD+0l+ADdk6t
         MFwEeZsNPpptUl3Up9jNB0qcV2X5isouM+xrXwOj7UZ3zh0Rk37OSU/pVLHfJjpEssz1
         +XVwIMacu7GSgsbE+AzQEA9Mcs6ekPu5Z6gWJjHQ4K+mJE1eOOTzlAQW3STy5OnXDypY
         M1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OLZ5Gh+X7NeGBeG6q/wLjvo22SRAfA4VNOC2v2prFeE=;
        b=PiiFLd2ro/7oo6US6peWhU0YQeDF2wNzYJKlBezFNoYQWN+Gpo8R2elhxAgIjJkY/x
         e6awrTgaDVhEm0NlpU8YrlTLIDLyKDIj/FYTgqtKq0bs7+NKJQCxXgYuDXL7Q8NDaJPs
         pVA0ndfbmb5bmS2TOOqwLiyzpT0Jg2Y4vRqb69eZ+iu8ZoSKJDhPJX7E7TuapjbpRcxy
         6XCHCX4ZssV97Ex+19Fwq4VmE/j8jz6nHJsfocoayhRX3BEJX+7tHJVTyCHkJ7lbpinb
         62CjRB6tWRACwe8BJ4BwMLyxhgMaGf4q7c6qA5Uo/ljLkW11+LQwrYpw7zRRTiK5wXxI
         Bc0Q==
X-Gm-Message-State: AOPr4FWqdEjSa8yBbD6t8qY93LSnFTJgtQzP0iZZ9ArOskrMO9iQne5WsUnJEULSusjsCg==
X-Received: by 10.194.57.168 with SMTP id j8mr10650852wjq.43.1460564054821;
        Wed, 13 Apr 2016 09:14:14 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id lz5sm39383306wjb.5.2016.04.13.09.14.13
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Apr 2016 09:14:14 -0700 (PDT)
In-Reply-To: <vpq1t69669d.fsf@anie.imag.fr>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291456>


> On 13 Apr 2016, at 14:30, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>>> On 13 Apr 2016, at 07:43, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> 
>>> Junio C Hamano <gitster@pobox.com> writes:
>>> 
>>>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>>> 
>>>> True, presumably the Travis integration already solves that part, so
>>>> I suspect it is just the matter of setting up:
>>>> 
>>>> - a fork of git.git and have Travis monitor any and all new
>>>>  branches;
>>>> 
>>>> - a bot that scans the list traffic, applies each series it sees to
>>>>  a branch dedicated for that series and pushes to the above fork.
>>> 
>>> ... and to make it really useful: a way to get a notification email sent
>>> on-list or at least to the submitter as a reply to the patch series.
>>> Just having a web interface somewhere that knows how broken the code is
>>> would not be that useful.
>> 
>> Travis CI could do this but I intentionally disabled it to not annoy anyone.
>> It would be easy to enable it here:
>> https://github.com/git/git/blob/7b0d47b3b6b5b64e02a5aa06b0452cadcdb18355/.travis.yml#L98-L99
> 
> The missing part would be "as a reply to the patch series". When I start
> reviewing a series, if the patch is broken and the CI system already
> knows, I'd rather have the information attached in the same thread right
> inside my mailer.
I see. How would the automation know where the email patch needs to be applied?

- Lars