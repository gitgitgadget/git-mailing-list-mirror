From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/2] Move sequencer
Date: Sat, 8 Jun 2013 09:05:01 +0530
Message-ID: <CALkWK0nbC3jfapvJKuh=m3s1n+GWfTYbhb5DWEjNrFDimQF-KA@mail.gmail.com>
References: <1370643409-3431-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 05:35:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul9wP-0008FU-Uc
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 05:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249Ab3FHDfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 23:35:42 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:44133 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927Ab3FHDfl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 23:35:41 -0400
Received: by mail-ie0-f170.google.com with SMTP id e14so12502307iej.15
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 20:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4W4lPdMZCrKrzOxDR63FWfrRBSFrF0tffaNEXUDPw+E=;
        b=0jbVAtvngC46MMTOD0xOzEWzkVZjU3vPmknWQGUQ0893CHqDvw6/7fLfubw/wfFpjt
         kZJ254SH9cSJXpI/FzFicfyVbvId27bahPzobqXCpXfzLPtd2UwLZtubvE9Jl2rRbyuL
         Q2Oj1lL43nAGcvJ/6PIlojIBdLDR7ysTFSvo18DmfL7XRiwmElz5cOR88KRY6c6SOFdQ
         wUlWmfdvCEgT2NUJJld6XuioPhOnH/nraSuVy/8s2XZrXbK9pmqNsgh6IxIqd6i3GitF
         yjpD0vcwUyk7ZOFUBzKbPFQaKkqoM7LLbrhj7s6cMqMFfDKYMAHMlFdkjNv9A1IHDhTz
         3GGw==
X-Received: by 10.50.107.6 with SMTP id gy6mr216880igb.57.1370662541212; Fri,
 07 Jun 2013 20:35:41 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Fri, 7 Jun 2013 20:35:01 -0700 (PDT)
In-Reply-To: <1370643409-3431-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226784>

Felipe Contreras wrote:
>  sequencer.c => builtin/sequencer.c | 160 +-----------------------------------
>  sequencer.h => builtin/sequencer.h |   4 -

Why exactly?  The plan was to unify continuation semantics, and get
all the continuation-commands to use the sequencer.  That clearly
hasn't materialized, but I don't know what this move buys us.
