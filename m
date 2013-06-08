From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sat, 8 Jun 2013 08:32:04 -0500
Message-ID: <CAMP44s1Y++qNEDHHFX2Jhv7rm081SeZ=7bfbo1ZW+ctQgO2QBQ@mail.gmail.com>
References: <1370643409-3431-1-git-send-email-felipe.contreras@gmail.com>
	<1370643409-3431-3-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
	<CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
	<CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
	<CAMP44s2fP4_=HtOsuwmxXG8qmp8CmpgEhz=BJFOFZxsTf_3gcQ@mail.gmail.com>
	<CACsJy8CQRWU0mFLVD6RrpzJiHBH=9zFwf5xDo7UhGW6A-OAzuw@mail.gmail.com>
	<CALkWK0mLoeO5fKezE5S1LEC2LNH9qCwxHnNi_ZJpYzC7rVTqmg@mail.gmail.com>
	<CACsJy8B=m95mpRn1dAwQZAvHRUeJVjKy1hKXv43EKX08ZODsDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Shawn Pearce <sop@google.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 15:32:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlJFc-0000xb-VG
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 15:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585Ab3FHNcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 09:32:08 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:52823 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368Ab3FHNcH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 09:32:07 -0400
Received: by mail-la0-f52.google.com with SMTP id fo12so2636805lab.39
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 06:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fnKcmrZDTl1pXbHY6fEbfFL+GvniDXDiTyG2sa+56Rs=;
        b=hncRsiZnJCZ+A0gPOEKNnEP5k7tXuD2Ny1OcOndBOK+/wR//gXJLmuyEdhAxO58UCS
         I6PSTcNzZHiAN76mPAIgCIJQsJoP2sTiOzxuf8nSL4/roBsil4BRvHsdaAScmi7BkpuN
         KB1zgHJ/uijTKHz5Nzz6AOPb79n4yAAotB6oOHwmP6K4jpdilKOmDnjIebRBgV1MkBbF
         2NnVQXG8OAOV0OLAVKj5DRztgsVnw0GSi4QrnBPUxKSJ09QARjNVegRj7LiRBaHpA2Ia
         0IEfhH6jaOaLqAiaqCfDHrDZ1nt7baLJPSwDXi+XoeJDLZTtCO+FJp/D73D9fF++eYwY
         ylNA==
X-Received: by 10.112.156.5 with SMTP id wa5mr3086977lbb.63.1370698324933;
 Sat, 08 Jun 2013 06:32:04 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sat, 8 Jun 2013 06:32:04 -0700 (PDT)
In-Reply-To: <CACsJy8B=m95mpRn1dAwQZAvHRUeJVjKy1hKXv43EKX08ZODsDw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226820>

On Sat, Jun 8, 2013 at 8:15 AM, Duy Nguyen <pclouds@gmail.com> wrote:

> So instead of redoing it again, I think it's better that you help
> libgit2 guys improve it to the extend that git commands can be easily
> reimplemented. Then bring up the discussion about using libgit2 in C
> Git again.

There's no reason not to move libgit2 closer to libgit.a, and libgit.a
closer to libgit2, both at the same time. I have rewritten a lot of
code using this strategy.

-- 
Felipe Contreras
