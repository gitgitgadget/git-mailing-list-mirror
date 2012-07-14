From: "Zeeshan Ali (Khattak)" <zeeshanak@gnome.org>
Subject: Re: Support of '^' as alias for 'HEAD^'
Date: Sun, 15 Jul 2012 01:24:18 +0300
Message-ID: <CAAa3hFMNf_wA22ngypSu379jr31r3L3yAjTkvDUd_L-mVwPJkA@mail.gmail.com>
References: <CAAa3hFMgy66W0dVEGv164Zowfa6Q-5DqgkkLz_1paymU_1SHUw@mail.gmail.com>
	<loom.20120714T114718-783@post.gmane.org>
	<7vzk725c86.fsf@alter.siamese.dyndns.org>
	<7vr4se5bg4.fsf@alter.siamese.dyndns.org>
	<CAAa3hFOv39DhuEDTyJUm1pzB-X1gBiV8FXuqW6TidOtQw9CUng@mail.gmail.com>
	<7vmx32590u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 00:24:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqAlF-00086M-CL
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jul 2012 00:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444Ab2GNWYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jul 2012 18:24:20 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59090 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120Ab2GNWYT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2012 18:24:19 -0400
Received: by pbbrp8 with SMTP id rp8so7695352pbb.19
        for <git@vger.kernel.org>; Sat, 14 Jul 2012 15:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=8gGTEeEgiRgZiuilPbOVEmEHbAnuQOcjzrj748hKd+Y=;
        b=a803kEyVWjToCRaZH8uY5cPx0QMw2XO/3QpJa8MiHiCSjMhYm0YUUZ0hNb000qf2NL
         NkdjLyuplIKfHAXcOVrgUqpVHKr9Wzl3TQJEn7twVvA0PUrCgTM+KJBT20O4i37u+6ME
         5VZdyKKYBomZllWhKwvMS+H9tDzrOzg/uo+JIER2tE0Mj4HDByQOmGDbiYr9exahMR9f
         Vuvc3YYzJebK/I8CZE4SHA1Fam752grsD1SXdD6quHSFjAsjBT7tJDJTuzKrKH1b+pZU
         ZOSvIEM/GmjpLmxhNgGhVhUm5EXxpLt8Cmr6qDTdHZsqMBZ1INCCn6Mnp5EF+uKsY+sH
         bStw==
Received: by 10.66.76.170 with SMTP id l10mr11582860paw.57.1342304658745; Sat,
 14 Jul 2012 15:24:18 -0700 (PDT)
Received: by 10.68.231.33 with HTTP; Sat, 14 Jul 2012 15:24:18 -0700 (PDT)
In-Reply-To: <7vmx32590u.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 0rAnKXR63AmAPC-vZt_44yPS_Oc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201462>

On Sun, Jul 15, 2012 at 12:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Zeeshan Ali (Khattak)" <zeeshanak@gnome.org> writes:
>
>> What about '^' and '^^' that I suggested?
>>
>>>> While I see your "~<N>" much distasteful compared to "^", you still
>>>
>>> s/dist/less dist/; sorry ;-)
>>
>> Why?
>
> That "^^" is the most important reason why your "^ is the same as
> HEAD^" is flawed, and goes against my taste.
>
> Think what "log ^^ origin" would mean.  Is it "log ^HEAD^ origin"?
> Is it "log HEAD^^ origin"?  They mean totally different things.

Sorry for my ignorance here but what does ^ *before* HEAD even mean? I
tried playing with different combinations of ^ and HEAD here (e.g
^HEAD^, ^HEAD^^, ^HEAD^^^) with both log and show commands but git
just silently returns on them. Is this ^ before HEAD actually used
cause I have never seen/heard of that before. Google isn't able to
help either.

> Compared to that, at least ~<n> does not have such ambiguity within
> the context of Git (having to quote is an ambiguity within the
> context of using Git with shells that support dirstacks in their
> tilde expansion).

Don't know whats dirstacks support either but that I guess just means
that bash (the shell I have always used) doesn't do that.

-- 
Regards,

Zeeshan Ali (Khattak)
FSF member#5124
