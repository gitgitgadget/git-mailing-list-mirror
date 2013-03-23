From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 0/6] Support triangular workflows
Date: Sat, 23 Mar 2013 18:12:38 +0530
Message-ID: <CALkWK0=fOxuWvXKL4fQ9cd0Rs2S71_9GB=eP8PXbwk_+Ke8wtQ@mail.gmail.com>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
 <26A2BE0824FE4C999592D392FCBEF988@PhilipOakley> <7v7gkz8nyf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 23 13:43:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJNnC-0008N0-6g
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 13:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910Ab3CWMm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 08:42:59 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:58199 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab3CWMm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 08:42:58 -0400
Received: by mail-ie0-f182.google.com with SMTP id at1so1898320iec.41
        for <git@vger.kernel.org>; Sat, 23 Mar 2013 05:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=XrEyd4LcDfTQurZ3WtacHsL5HE8UOknsMVINpxz45Sw=;
        b=Mj9P03gs1RRby271/WmQfk+fDr1FlSIk0nsFDx1dSs7YFCwmhYlcc9gq8WOlCAzylp
         u5cmgQ2NYq9Na5O7qfHw3PD/EQI5TJQJIcC8Ex+rudaS5+7kMUT0dPC5+nSFpL4Brygd
         w3wBkbGsMAbgfHOqD/aO6K6/uLxbzyFgQoGThtlggRn5MsSCAGmT7q2IU70V5xsGd5dY
         +xHGos6e1AUFt0StthE6J0qucDrZu1o4Lm4uFjswE1Ir6NMd2VZF/cBYtUKbTisbybOC
         2QAAhdMw4KWgwp4bkh4ERKqhXMVpq025MDwI7ccZuho2Wfb1ZCeHCK40sgTLM88nQEuw
         wN7g==
X-Received: by 10.50.17.71 with SMTP id m7mr3547356igd.14.1364042578142; Sat,
 23 Mar 2013 05:42:58 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Sat, 23 Mar 2013 05:42:38 -0700 (PDT)
In-Reply-To: <7v7gkz8nyf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218911>

Junio C Hamano wrote:
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> Shouldn't Documentation/gitworkflows.txt also be updated with the
>> triangular workflow and its configuration?
>
> What is missing from gitworkflows documentation is actually a
> non-triangular workflow, where people pull from and push into the
> same central repository.
>
> The "merge workflow" part in the "distributed workflows" section
> teaches:
>
>  * fetching others' work from <remote> and merging it to yours;
>  * publishing your work to <remote>; and
>  * advertising your work.
>
> and it is written for the triangular workflow.
>
> Two triangles are involved.  The maintainer may pull from you but
> pushes to her own, which is one triangle, and you pull from the
> maintainer and push to your own, which is another.
>
> As to your suggestion, I do think it is reasonable to clarify these
> triangles with an illustration, and to even add descriptions for
> short-cut configurations as a side note.

I think the gitworkflows document should be rewritten with focus on
setting up remotes and configuration variables for specific workflows.
 Once these are set up, pushing/ pulling (git pull is currently
broken, although I'm working on fixing it) should Just Work.  To push
to a different remote/ refspec, the user can read the manpage of git
push/ git pull.  A workflow is about setting up good defaults that
work 90% of the time with no additional effort.
