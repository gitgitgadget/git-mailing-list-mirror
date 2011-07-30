From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: gitignore design
Date: Sat, 30 Jul 2011 20:22:14 +0700
Message-ID: <CACsJy8DcFJUK91cJm3EmHn8BMyA78gzu_pMtqJ0z9oO1RF+suw@mail.gmail.com>
References: <1311934832699-6632987.post@n2.nabble.com> <m3pqktql6s.fsf@localhost.localdomain>
 <4E32B637.1030201@viscovery.net> <201107292339.51753.jnareb@gmail.com>
 <CACsJy8CurvKd_=hdRQyjjzWLvKF0jbWOQhbLSsmk1BqB_dK3og@mail.gmail.com> <CAA01Cspv4yShnKBKFFrf8K1tbARahyYf7KZPqbiDFrvFsX9hwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	llucianf <llucianf@gmail.com>, Ferry Huberts <mailings@hupie.com>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 30 15:23:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qn9W3-0006DO-42
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 15:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360Ab1G3NWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 09:22:46 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48564 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870Ab1G3NWp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 09:22:45 -0400
Received: by fxh19 with SMTP id 19so3092144fxh.19
        for <git@vger.kernel.org>; Sat, 30 Jul 2011 06:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=p1m7TdV4KVoOCWoTWowHZ+vXE1nP9rF11jI5kyoghEg=;
        b=ovr1k/gmkVeK3ULOtIej0QmYsNK/NpUV20/hnQnFRvZ5sU7R7cAlPXH0G35LTfPVU7
         sXaIHCf6H2HRd3P/DqXgg6k8q9NOp+C9jFWWxWb3HtKApe0E3cVF9ImTVHCvcmNjEEGm
         aYKUZnpGuM/5bkYW9sIxBnY99zueAyPMGFp1s=
Received: by 10.204.132.9 with SMTP id z9mr646213bks.348.1312032164147; Sat,
 30 Jul 2011 06:22:44 -0700 (PDT)
Received: by 10.204.121.142 with HTTP; Sat, 30 Jul 2011 06:22:14 -0700 (PDT)
In-Reply-To: <CAA01Cspv4yShnKBKFFrf8K1tbARahyYf7KZPqbiDFrvFsX9hwg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178192>

On Sat, Jul 30, 2011 at 1:45 PM, Piotr Krukowiecki
<piotr.krukowiecki@gmail.com> wrote:
> I was using assume-unchanged for some time but stopped after some
> weird problems during updates. I'm not sure if this was caused by this
> or by sparse-checkout (and I use git-svn too). Anyway, after stopping
> using assume-unchanged and sparse-checkout mysterious problems
> disappeared.

I'm interested in the problems you had (even better if you found a way
to reproduce).
-- 
Duy
