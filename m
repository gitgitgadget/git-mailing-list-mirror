From: Martin Langhoff <martin@laptop.org>
Subject: Re: [PATCH v1 1/2] Remove 'git archimport'
Date: Tue, 13 May 2014 14:01:24 -0400
Message-ID: <CAAhxitED0iV+Pcird2kZzt3nSnr83+isBDZF2Czmh0LzNzQf8g@mail.gmail.com>
References: <1399599203-13991-1-git-send-email-felipe.contreras@gmail.com>
	<1399599203-13991-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Martin Langhoff <martin.langhoff@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 20:01:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkH18-0002H5-6b
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 20:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060AbaEMSB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 14:01:26 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:49117 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbaEMSBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 14:01:25 -0400
Received: by mail-ig0-f173.google.com with SMTP id hn18so5541743igb.6
        for <git@vger.kernel.org>; Tue, 13 May 2014 11:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XzfdkKHw+Cg4eubGB0tYab+K7fu4EmTiVe1gTfrjGoM=;
        b=VKSi8GovoAVID+fTYxPkNWzdiFRVhQfUg4wzzct0JvpBMpoyDCzVqBSjY75SfTbiGG
         vouG6iUgCDnrphdHE0uAmXZF4BILHB05XQPEy1981fm8BzEv3wtvPi4bYS4I7YrzQ6rR
         gZybIm9h5Vtg1o5NeOuEhgGrQLT66/hjvyuQk0SxpsQQKM2MtuD7Qn3HB6O8QH/HaNku
         pizH7+jkDXjwQ6gZ9PLEk4465Mo+y+o7AbzFVCMxQsfZE+B0v0O1nOrJqq+2Tekw+cto
         LnTnYdbiJkcBj3LDeWafhvyS4YZYCD/rdUz2ELna4SEA7cnKbUbEkxXgF1XpbO9v701K
         ZSEg==
X-Received: by 10.43.58.19 with SMTP id wi19mr826583icb.53.1400004084798; Tue,
 13 May 2014 11:01:24 -0700 (PDT)
Received: by 10.64.11.100 with HTTP; Tue, 13 May 2014 11:01:24 -0700 (PDT)
In-Reply-To: <1399599203-13991-2-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: kIjjTawQpdGzss8MKVNn2YXnFqI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248793>

On Thu, May 8, 2014 at 9:33 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> No updates since 2010, and no tests.

NAK.

IMHO, this is quite unfriendly.

Is this removal based on your opinion, or Junio's position (or
consensus from maintainers from the list)? If there is a clear
consensus or direction for old code such as this, please let me know
(but copy martin.langhoff@gmail.com, not just my very old address!).

> Plus, foreign SCM tools should live out-of-tree anyway.

Says who? Is there consensus on this?

It's generally the privilege of the maintainer -- in this case Junio
or perhaps Linus -- to take harsh stances like this.

Junio, what's your position?



m
-- 
 martin@laptop.org
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
