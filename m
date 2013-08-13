From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: ephemeral-branches instead of detached-head?
Date: Tue, 13 Aug 2013 13:05:52 +0700
Message-ID: <CACsJy8Dke6Pezqsdcjzejc_cWCgOGTGs8LifjM2h2TQJy7N4HA@mail.gmail.com>
References: <CA+CP9O6on2NXo6o4_0NoULnT8sgUD3pvvkFZvCTM5xKb38qOeA@mail.gmail.com>
 <7veh9z1gym.fsf@alter.siamese.dyndns.org> <CA+CP9O5fhyQrn3SboafocWJjaAywJHC0T-bw+AXk_8RX53hJ6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Jeske <davidj@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 13 08:06:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V97kS-0006Q8-NX
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 08:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754639Ab3HMGGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 02:06:24 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:48812 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282Ab3HMGGX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 02:06:23 -0400
Received: by mail-ob0-f173.google.com with SMTP id ta17so10079212obb.32
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 23:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2/8Bhp5lS6CJEVZsWdd2+zKhsv04ijmGHMzCkHmH8YY=;
        b=jroblnxD2+e5MXngzEYnanxygDwbIPyX2zjAA4DhJpuKQPiVGQevohpq99SWBefJfm
         R1bWeqvRSaKk2G/+RbhYwLUkk5JiFb9OI4RN7NfSAMvdcT9M/WiCsNYUeu/PuyUonmkp
         0sYHwKZuoGf7exSSM+8bN+Qn3CDKFxsIf4sP6dIeXEuPC6OzH8CW0QBbOpNXgWdLtm+Y
         K/i5m/nb3ftk2MhcOpJvK9J04yp6gd0GM384iLLpLuNRUqg5yyZNzx1FecvCv8N6MF3d
         uELNc2+RdrmANVd/FtcC1JyyRvEXrZkmZuv8J6Otx7SwoJNDfYlkuRUQAK2zFmqtQ1wv
         gN9w==
X-Received: by 10.60.133.233 with SMTP id pf9mr2717491oeb.46.1376373982838;
 Mon, 12 Aug 2013 23:06:22 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Mon, 12 Aug 2013 23:05:52 -0700 (PDT)
In-Reply-To: <CA+CP9O5fhyQrn3SboafocWJjaAywJHC0T-bw+AXk_8RX53hJ6Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232212>

On Mon, Aug 12, 2013 at 3:37 PM, David Jeske <davidj@gmail.com> wrote:
> Is there currently any way to say "hey, git, show me what commits are
> dangling that might be lost in the reflog?"

How do you define dangling commits? When you do "git commit --amend",
the current commit will become dangling (in the sense that it's not
referred by any ref, but the commit exists) and those are just noise
in my opinion.
-- 
Duy
