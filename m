From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] rebase: pass --signoff option to git am
Date: Mon, 6 Dec 2010 11:41:35 +0100
Message-ID: <AANLkTinnn_QnBJ8AZT9ZB+ZHVRDZV0tDret=YQeyfa01@mail.gmail.com>
References: <1290856542-6070-1-git-send-email-giuseppe.bilotta@gmail.com>
 <ADC46761-DFF5-486D-B604-05BA8C8631EB@sb.org> <AANLkTindvz=7OmYaL6AL_oAj50U9PLnRrbSpjgR92z7C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Dec 06 11:42:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPYWA-0005wN-Gc
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 11:42:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032Ab0LFKl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 05:41:57 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58066 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854Ab0LFKl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 05:41:56 -0500
Received: by iwn9 with SMTP id 9so66587iwn.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 02:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=JoY78Eqmu8wXV3qD9J0jcPIEnRiSDTVcUr4QDmtA/U4=;
        b=ubrQYyvMvalecSxm5uavfB/JW2IsEQ2AhCaoEfmrb5QNt1C/q236nBILxCFUeE4Zey
         eHt9A0lA76yJsENV4vqGkEq7AZtW3H7xaO3Q7M1tUgea9n1XdJ0M7xa74xrUIQvALQQN
         wH7RX+i0v/NqGsN9sLrG/q/0VMJVTPOlbCsYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=cFB+0ahBQ17KSnOF8hSFzQcJ3GzuaFIWjMdo7TlY9+xOLqI0JZr6frAEtNa+XIXQ+N
         /bdUkJf508nvfvvO/Cuvy25pNEXz3gV9HBFEa0TVCyx4KDPhSPT5I+klp/fG9XI3Dmjf
         Deqm35UQ4AQB2Mk27dVpkGn7yXRQORHAKnXYE=
Received: by 10.231.143.143 with SMTP id v15mr2377371ibu.131.1291632115473;
 Mon, 06 Dec 2010 02:41:55 -0800 (PST)
Received: by 10.231.39.3 with HTTP; Mon, 6 Dec 2010 02:41:35 -0800 (PST)
In-Reply-To: <AANLkTindvz=7OmYaL6AL_oAj50U9PLnRrbSpjgR92z7C@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162990>

On Tue, Nov 30, 2010 at 9:09 AM, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> On Mon, Nov 29, 2010 at 11:57 PM, Kevin Ballard <kevin@sb.org> wrote:
>> On Nov 27, 2010, at 3:15 AM, Giuseppe Bilotta wrote:
>>
>>> This allows people (like me) that forget to sign off their commits to do
>>> a single rebase pass e.g. while preparing the patchset for submission.
>>
>> You're probably already aware, but git format-patch supports the -s/--signoff
>> flags to sign off commits as they're prepared. There's even a config var
>> you can set to make this the default (format.signoff = true).
>
> That works if you're sharing your patches with format-patch, but not
> for example when asking for a pull. Maybe I should extend the commit
> message to include this case.

For what it's worth, somebody on #git just asked how to signoff a
bunch of patches. The answer was to rebase -i and sign off each one of
them. This is exactly the kind of usage that my patch would simplify.
Any chance of it getting merged?

-- 
Giuseppe "Oblomov" Bilotta
