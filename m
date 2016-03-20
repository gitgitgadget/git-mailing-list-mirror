From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: GSoC Project | Improvise git bisect
Date: Sun, 20 Mar 2016 13:40:26 +0530
Message-ID: <CAFZEwPMoqr_bOBxmm4a-tFjb9+L5tbSOJXqQPReNS=sQTNKRXQ@mail.gmail.com>
References: <CAFZEwPN-oUDNnc_PBeP2Q4msJAHenkiLtE+Oo75R+uTTwUKpYQ@mail.gmail.com>
	<vpqoaaahbvi.fsf@anie.imag.fr>
	<CAP8UFD2fudNtGpUHTYjZKXCErocuRS65E=5tH_+_tsNFbmHCBA@mail.gmail.com>
	<CAFZEwPMeejJEMjYbx1sJsH0UNygDEdtNazceOePo81Abi0dHHQ@mail.gmail.com>
	<56EDCD2D.9040806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Jeff King <peff@peff.net>, Troy Moure <troy.moure@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Kevin Daudt <me@ikke.info>,
	Philip Oakley <philipoakley@iee.org>, s-beyer@gmx.net
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 09:10:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahYRa-0006uB-0X
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 09:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177AbcCTIKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 04:10:33 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35014 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbcCTIK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 04:10:27 -0400
Received: by mail-yw0-f193.google.com with SMTP id d21so3921608ywe.2
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 01:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=q2jOL7oD4rRI8gUs9BM7pmG5n4Tx5AoAfRIZQ4mP8tA=;
        b=Wtlz5bezJiOglSw4hfreQhF7bDAHpuI0FHNq4Rs+2MempJbvmvX09t3oUGRpV+yteC
         zNCCiPM9sxEJZx8lFFWz42lHjvpmoJ6IY9GXi7ajgT1Rmmin9Rj8iTc1JcT+skfeRlkx
         GtS39UAE3GouAJJMXb6ycM3idnYxg7Yxv+wRabsl8KVhDGJkyD8lT9dNp50NI9OI+86Y
         3t8EY2Y+l6/+YPVsjsX/PlpSYqApwikoyikDBVRaYr36rarH7r/XMlx+jRSPm5Sczt71
         4dj1ZEhwjjU96vTTnRCtQUaj1LU7M79CCzKw+l3pugG3KMfbN9XJ5QK0fQGPCb7JfyHt
         J6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=q2jOL7oD4rRI8gUs9BM7pmG5n4Tx5AoAfRIZQ4mP8tA=;
        b=kEDOl1FVx2vVwMabl5N21MYdQ6qQ3YLwAZvnYM2EnWbfz5ngohaEpKID/DosuvowAt
         /jprHyiyMAFpA4+hqgpqmaD6iKTxTxri5Uu1RCu4/9qMOmtmw5r/JfDTDx9hmeO2ZOf0
         yqomXEYJxaJyPUt183vJ5Gi8HlEegB5t10v1F0NZh2ZY0NzJE71XWm+Gh04zn+pSArr3
         zZqhVzcKqPZjR8boSPLS4y3llmYI1y4X603qQw0KPupMY1hRUk9CIE+gTdDiPslkD1lA
         9JBRZ6FiADZEDNKj09XVJeQ3Zmb710nfOcw9QLfsIqnHGGyycP8TuVDTjm9PuB3KXaHS
         +9AA==
X-Gm-Message-State: AD7BkJK6kHXnzG4i08Q4gnW+iI/2OYgV90cPp6hzQ0N63haCzkXyyqe6nZ0Z4ks/MhA7DXshZsr51CzGtaA13A==
X-Received: by 10.37.12.195 with SMTP id 186mr11308221ybm.154.1458461426420;
 Sun, 20 Mar 2016 01:10:26 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Sun, 20 Mar 2016 01:10:26 -0700 (PDT)
In-Reply-To: <56EDCD2D.9040806@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289339>

On Sun, Mar 20, 2016 at 3:35 AM, Stefan Beller <stefanbeller@gmail.com> wrote:
> Once upon a time, a discussion produced this proposal[1],
> which tries to split up the set as good as possible (50:50) instead
> of inspecting the branch/merging structure of the underlying graph.
>

Thanks! This helped me in getting to know how bisect actually works.

> There was a recent series on bisect by Stephan Beyer[2], who is cc'd
> now, maybe he has some thoughts on improving bisect.
>
> Thanks,
> Stefan
>
>
> [1]
> https://docs.google.com/document/d/1hzF8fZbsQtKwUPH60dsEwVZM2wmESFq713SeAsg_hkc/edit?usp=sharing
>
> [2] http://comments.gmane.org/gmane.comp.version-control.git/287513
