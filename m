From: David Barr <davidbarr@google.com>
Subject: Re: What's cooking in git.git (Mar 2012, #02; Sun, 4)
Date: Tue, 6 Mar 2012 10:11:35 +1100
Message-ID: <CAFfmPPPa=s8NAYDxoSa5SR91Y_tgRLUVo_bzgViE0wV5g0Ld3g@mail.gmail.com>
References: <7vk42z32jo.fsf@alter.siamese.dyndns.org>
	<CAFfmPPNWXG2iP4jg0v0EoMuGb6eNoEvFuserc7vtP9EeLFp1CA@mail.gmail.com>
	<7v1up6zmwr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 00:11:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4h4A-0002xV-Kx
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 00:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757604Ab2CEXLi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Mar 2012 18:11:38 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47735 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757590Ab2CEXLg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2012 18:11:36 -0500
Received: by yenl12 with SMTP id l12so1981235yen.19
        for <git@vger.kernel.org>; Mon, 05 Mar 2012 15:11:36 -0800 (PST)
Received-SPF: pass (google.com: domain of davidbarr@google.com designates 10.236.173.195 as permitted sender) client-ip=10.236.173.195;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of davidbarr@google.com designates 10.236.173.195 as permitted sender) smtp.mail=davidbarr@google.com; dkim=pass header.i=davidbarr@google.com
Received: from mr.google.com ([10.236.173.195])
        by 10.236.173.195 with SMTP id v43mr30321846yhl.40.1330989096041 (num_hops = 1);
        Mon, 05 Mar 2012 15:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=eFRxg+Cpfe8xcpm9RicgPoQubLwzE6pc6jxz+TX95r0=;
        b=nnPORxD9LUh0KBl6kbrZlfZ+s5KgYdpKX+LdVcxVwSGYh7NYfJ0dV2BA3zambfvELL
         uzVooc0ri9FI1kS2ZvSF1eFo+GdWef87lf79JtRQ1c6NYVP3WoYLRAUqAW8i9c/Sz1tV
         n9Pq75pOBTJKIQhR94PUreBvoCOWZ59C09AGEH+4yjaUrDge6OpAwBMINzLRTN9L4Sx9
         90FVC9WkdufJuzE/e5/MiQwu4yoMmtXje7NZ7cVq+JT6CMVDU+W80J4023lnIwu4cskF
         vs+qrLhawWyAwtHteBzvT3g0u0OhkqKM0G8yrGh4Dm7sfogBnTufOr7ta/Cas3feH3dx
         BloQ==
Received: by 10.236.173.195 with SMTP id v43mr23920300yhl.40.1330989095987;
        Mon, 05 Mar 2012 15:11:35 -0800 (PST)
Received: by 10.236.173.195 with SMTP id v43mr23920289yhl.40.1330989095870;
 Mon, 05 Mar 2012 15:11:35 -0800 (PST)
Received: by 10.101.154.34 with HTTP; Mon, 5 Mar 2012 15:11:35 -0800 (PST)
In-Reply-To: <7v1up6zmwr.fsf@alter.siamese.dyndns.org>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQkl4f83rqMude/dm9E2Dr9Gm78Fm0tL1lRhWQkCVcxPX2g6Vu8lT5xPaxwWEhOrQG1s1MGhEW+RdwajTUPeV3GRPl5KZ/uNctYvRgWpTaw+CErpJCfKTgsZ9qq3EMR9WqbQw3/AtMFCrFXEOl22jI87bnwh5A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192283>

On Tue, Mar 6, 2012 at 9:46 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> David Barr <davidbarr@google.com> writes:
>
>> On Mon, Mar 5, 2012 at 6:55 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>>> You can find the changes described here in the integration branches=
 of the
>>> repositories listed at
>>>
>>> =A0 http://git-blame.blogspot.com/p/git-public-repositories.html
>>
>> Just a note that the htmldocs are readable at:
>> =A0 http://git-htmldocs.googlecode.com/git/git.html
>
> That's good to know. =A0Even the cross reference links work ;-)
>
> It is different from the URL of the document that lists repositories
> I gave above, though.

I meant it as a potential addendum for that document.

>> Also, they would be readable at:
>> =A0 http://gitster.github.com/git-htmldocs/git.html
>> If the branch gh-pages existed and mirrored master.
>
> I have no idea what you are talking about here, sorry.

GitHub has a different mechanism for publishing project content.
They expect a special named branch, gh-pages.

  http://pages.github.com/#project_pages

I thought it might be of interest that both Google Code and GitHub
provide git-friendly means of publishing project content.
--
