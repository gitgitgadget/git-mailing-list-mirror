From: Daniel Mack <zonque@gmail.com>
Subject: Re: Suppressing auto-cc for specific addresses
Date: Mon, 8 Aug 2011 09:24:02 +0200
Message-ID: <CACTFLAOhApGVNZ7JsWhoHBEaQ_87stXjxkXvadmauNfhSuPD1g@mail.gmail.com>
References: <4E3EF38A.9010307@gmail.com>
	<20110807234634.GA3236@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Greg KH <greg@kroah.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 09:24:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqKC1-0007K1-Qh
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 09:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399Ab1HHHYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 03:24:06 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:37073 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583Ab1HHHYC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 03:24:02 -0400
Received: by pzk37 with SMTP id 37so7851228pzk.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 00:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Vg1Ax9tJIOGt8ZFlpdy+eqm6D7qqYxD5GOqhBfWXX9U=;
        b=hEph6oe6LccYlqT5ZG/TMOJTZsUHuYQe4ls4Sgl0gR51kCKlWBq7xvI1IpmB4FLuRh
         nKzdy2aSg8S8hCpoKk1pM4Nz+aNCeGJrhUhnr0ACEjcQ+PjNylDEok2u9+9QahJ7N9OR
         FjwHQQ5SlZVsN4X+jyAClSN2LUaSpIoY+b1H4=
Received: by 10.142.48.10 with SMTP id v10mr5599803wfv.185.1312788242269; Mon,
 08 Aug 2011 00:24:02 -0700 (PDT)
Received: by 10.142.194.11 with HTTP; Mon, 8 Aug 2011 00:24:02 -0700 (PDT)
In-Reply-To: <20110807234634.GA3236@kroah.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178943>

On Mon, Aug 8, 2011 at 1:46 AM, Greg KH <greg@kroah.com> wrote:
> On Sun, Aug 07, 2011 at 10:20:26PM +0200, Daniel Mack wrote:
>> I'm looking for a way to suppress certain Cc: fields that are
>> normally automatically added for addresses mentioned in Cc: lines
>> found in patches.
>>
>> In particular, the kernel rules for marking patches for stable
>> release inclusion wants users to add a "Cc: stable@kernel.org" line
>> in the patch itself but to not actually send a copy of that patch to
>> that address. It will be picked automatically once the patch was
>> applied upstream.
>
> There is no "rule" that says you can not send a copy of the patch to
> stable@kernel.org, in fact that happens a lot and is fine and I have no
> problem with that at all.

Ok, thanks for explaining. In fact, I've done it that way ever since,
and never thought that there is any problem with it. But the topic
came up lately on the ALSA ML (and was continued off-list later), and
reading Documentation/stable_kernel_rules.txt again, I became aware of
the fact that sending it to stable@ is not actually necessary (while
at the same time, it doesn't seem to be frowned upon).

Anyway, I found it strange not have a way in git to achive this, and
maybe this new feature has other uses, too?


Thanks,
Daniel
