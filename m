From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Random thoughts on "upstream"
Date: Thu, 23 May 2013 05:53:59 -0500
Message-ID: <CAMP44s22V9gETtjpMutmcO9_v1YnwnicAE=3zQfbyPXgUeKmKw@mail.gmail.com>
References: <7vobca6c7r.fsf@alter.siamese.dyndns.org>
	<CAMP44s2t3+yBQMj9uSd_=3w0CgeJsHeAQM051j7Xt+SqVthvzQ@mail.gmail.com>
	<7vobca3465.fsf@alter.siamese.dyndns.org>
	<7vzjvu1jes.fsf@alter.siamese.dyndns.org>
	<CALkWK0=rHFQ14G8baYpY7gYo+Qb+5a0qOKZGBTrp6BamKC2vRg@mail.gmail.com>
	<7vk3mx1rox.fsf@alter.siamese.dyndns.org>
	<CALkWK0mLtc8dmMPOcLMez1agF1+ZMUDAUwtwmiKSxOCfyiW0Bw@mail.gmail.com>
	<7vk3mxze8v.fsf@alter.siamese.dyndns.org>
	<CALkWK0kYKZGhthdrb6-7RD_c2A7E9rscAZU3=JHM-4rYre6w=Q@mail.gmail.com>
	<7vmwrr1pem.fsf@alter.siamese.dyndns.org>
	<CALkWK0=6L529C452MaNGksL5KeVb+cL1SeC=FwA9veS=tNQurA@mail.gmail.com>
	<7vfvxixoks.fsf@alter.siamese.dyndns.org>
	<CALkWK0m1x_qrJfQ2Xw3w_kVuM-JHERFukbfxHyR08ODvxysKzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 23 12:54:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfT9r-00053l-82
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 12:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758098Ab3EWKyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 06:54:01 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:56890 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757825Ab3EWKyB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 06:54:01 -0400
Received: by mail-la0-f48.google.com with SMTP id fs12so3083834lab.35
        for <git@vger.kernel.org>; Thu, 23 May 2013 03:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=p1BlLIihBPGbqROwespE+TqUJVgrvsVXxA0RTtJXpaM=;
        b=vOjKDQvz00OmWGqZc5mQlkDLIaj/8r5jQgZAFbxazkVkZvLgyfLtk/9Rsday00e2Rv
         GLfy/lZWQiZcUPtTT+Ro4cOo1MoNdtX9eTi6jC7aZtv2Rzw6JxlGihKYu3Ry6VEBlHCP
         EsfvDHFp1kQW3WIF72BeR8AApbAvDmuyzSL5DG8zB3vktn5cj00t4PxyywjHc56IrSnA
         HKF9pIa3h9ijWKUhmGABitAHiNJ6btZS0+YcjE38Rg+Vs0vo0zRx9rL/TyRDjwodYW73
         OlkA52hHvZ8b6xwgskvNo/DU2fj6ClOKNVSRdCjhftZf/75UnN5iIqZRUUA59ZShBp7b
         WHfg==
X-Received: by 10.152.45.33 with SMTP id j1mr6157008lam.29.1369306439557; Thu,
 23 May 2013 03:53:59 -0700 (PDT)
Received: by 10.114.174.170 with HTTP; Thu, 23 May 2013 03:53:59 -0700 (PDT)
In-Reply-To: <CALkWK0m1x_qrJfQ2Xw3w_kVuM-JHERFukbfxHyR08ODvxysKzw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225236>

On Thu, May 23, 2013 at 5:42 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Junio C Hamano wrote:
>> And that was done with extensivility your example implied in mind:
>> you may later be allowed to push other branches as well to origin.
>> That is why the refspec definition for 'origin' does not hardcode
>> the name of the branch you are permitted to push there at this
>> moment.  The fact that hot-branch goes to origin is encapsulated in
>> the branch.hot-branch.pushremote.  The rule, under which the name of
>> any branch that goes to the origin is renamed, is encapsulated in
>> remote.origin.push refspec (the introduction of the new mode
>> "push.default = single" is necessary to make this work).
>
> My problem with this entire scheme _is_ the magic push.default =
> single.  Currently, push.default only kicks in when no
> remote.<name>.push refspec is specified (in other words, it is a
> default value of remote.<name>.push for all remotes), and I don't
> think we should change this.  If the user wants to configure the push
> refspec (either for rewriting, or for determining what to push), there
> is exactly one thing to change: remote.<name>.push.  So I can have:
>
> [remote "theodore"]
>     push = master
>     push = +pu
>
> This means that I will always push master without force and pu with
> force, irrespective of the branch I'm on.
>
> [remote "origin"]
>     push = refs/heads/*:refs/heads/rr/*
>
> This means that I will always push all branches without force with
> rewriting, irrespective of the branch I'm on.
>
> [remote "ram"]
>     push = HEAD:refs/heads/rr/%1
>
> This means that I will always push the current branch without force,
> with rewriting.
>
> [remote "felipe"]
>      # empty
>
> This means that remote."felipe".push falls back to the refspec
> specified by push.default.
>
> Isn't branch.<name>.push is completely unnecessary?

No, it's not; 'git push --set-downstream' is not going to configure
that for the user. Nor will the user be able to see the downstream
with 'git branch -vv', nor will the user be able to see the downstream
with 'git rev-parse branch@{downstream}'.

You keep ignoring those use-cases I already mentioned multiple times
because they don't fit your idealistic model.

-- 
Felipe Contreras
