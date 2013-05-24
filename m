From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [QUERY] How do you sort completions?
Date: Fri, 24 May 2013 23:56:09 +0530
Message-ID: <CALkWK0k=yGmAvOsGO+4hS6bU=Y4mJoCq6QqVoSNajBYHaPxGng@mail.gmail.com>
References: <CALkWK0k=nVHOBe5SgRH9xQK1+yAYBzbNMqsWxhYPo0MTZPp63g@mail.gmail.com>
 <20130524161243.GB2104@goldbirke> <CALkWK0n8iuwNHfxV4AHUV+721pqLUOPhM6h+e0_opmkVuOV_4A@mail.gmail.com>
 <CALWbr2xxND4xz49jmwXUTTr1f=Z3nmHCTQd+bBcK_Etv5oB0Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 20:26:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufwha-0005AT-Uy
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 20:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757322Ab3EXS0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 14:26:51 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:33398 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178Ab3EXS0u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 14:26:50 -0400
Received: by mail-ie0-f182.google.com with SMTP id a14so13213578iee.13
        for <git@vger.kernel.org>; Fri, 24 May 2013 11:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sBVYq3xS/Rfuzm6XodrcGrx8jX2Lwl8GeXUtPT1iGyI=;
        b=NoWIqSkfYRIsxy0w8FNED8/kiRGVpY/XiSD8Jn8atG8nVXd4wIFpSRxhkqL5JQ8L1X
         7gXxsnmSEeYps8lwkipI/CHQB/++iRyNhycxdHix8rHelC+qS9T69YtJmfTNyGY3dUP3
         5YeYX4s1Pw+zsueu+kV+uOTEaDQ0yQN6Ib2Ta4fNTHflkPlfAFsmBDKvYJMD7acfTtPd
         6KDJYad9HngAxtKKnm6dPyoH4aMNa8dbcQDjcXlrl1WHhMdbU5ZVKWGim/VV2NW2AyZy
         8vIlrVolc2lokrbDU/WFb2Z7MMl2knJIaZtlfmcK5WMlnUPhc459Ua7arXGaZz1FuCiQ
         BeDg==
X-Received: by 10.50.33.19 with SMTP id n19mr227305igi.44.1369420009869; Fri,
 24 May 2013 11:26:49 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 24 May 2013 11:26:09 -0700 (PDT)
In-Reply-To: <CALWbr2xxND4xz49jmwXUTTr1f=Z3nmHCTQd+bBcK_Etv5oB0Fg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225394>

Antoine Pelisse wrote:
> I think sorting is required for faster look-up, most likely with
> dichotomic search. Otherwise it would have to search the whole list
> each time.

Oh, it's probably keeping just one copy of the completions in memory
(which has to be sorted for search); this is also used to display.
Makes sense, although I would have expected the shell to keep two
copies: a sorted one for searching through, and another preserving the
original order for displaying.  I suppose they didn't think of it.
