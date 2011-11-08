From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Benchmarks regarding git's gc
Date: Tue, 8 Nov 2011 18:28:50 +0200
Message-ID: <CAMP44s04B0vbecFb0JXmvnBX81A5q-m4ZAab8AxPpCjHpQvQKg@mail.gmail.com>
References: <CAMP44s3E-YCMQQzJAU2wjjD-adpNy6bGb-=iUQ=p=bFTWxm+Ng@mail.gmail.com>
	<CACsJy8DMAdjT8gsoSerkzNRvHgdcBWLaUd+-xHqXkV+hceo9rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 17:28:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNoXg-0001uG-EQ
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 17:28:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141Ab1KHQ2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 11:28:52 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47207 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab1KHQ2v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 11:28:51 -0500
Received: by ywf7 with SMTP id 7so716430ywf.19
        for <git@vger.kernel.org>; Tue, 08 Nov 2011 08:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3XDj/kPL7SUIwvrbShKs4tFAKifH5kVA2ViMsUhybG8=;
        b=kw+/AWQW9q9TQv/8D6VpJo8xaUP6n3/ajeiWXnQJg9+XfmKs97WuXZ9ZvP7S+oi+Dw
         DgzRLcPNBvT6Tl7w40CO6YgOPMk9Dhn0c21uXN6mpe5mVYkJXUcQLQ6reyaq6HUnP4XH
         TzCCkRFOZvU+97bjCgOG1QCi7VvTo6uVg3hvU=
Received: by 10.68.199.163 with SMTP id jl3mr1987941pbc.25.1320769730594; Tue,
 08 Nov 2011 08:28:50 -0800 (PST)
Received: by 10.68.40.69 with HTTP; Tue, 8 Nov 2011 08:28:50 -0800 (PST)
In-Reply-To: <CACsJy8DMAdjT8gsoSerkzNRvHgdcBWLaUd+-xHqXkV+hceo9rA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185094>

On Tue, Nov 8, 2011 at 4:37 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Tue, Nov 8, 2011 at 6:34 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Has anybody seen these?
>> http://draketo.de/proj/hg-vs-git-server/test-results.html#results
>>
>> Seems like a potential area of improvement.
>
> The proportion between time and commits may have something to do with
> reachability test, where we traverse all commits and trees (I think
> twice in git-gc, one when it runs "reflog expire" and one "prune").
> packv4 is supposed to make tree traversing faster. Although it'd be
> best if we could avoid this test.

Is there someone working on a way to avoid this test?

-- 
Felipe Contreras
