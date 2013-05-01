From: Thomas Adam <thomas@xteddy.org>
Subject: Re: [PATCH v3] Add new @ shortcut for HEAD
Date: Wed, 1 May 2013 11:31:10 +0100
Message-ID: <CA+39Oz7gib+dpW1CNEHtD2M6JcOF1QuxpeOWLcyTxdVPGnS5+A@mail.gmail.com>
References: <1367401888-21055-1-git-send-email-felipe.contreras@gmail.com> <CAPig+cSQeU8BaaPm7GfCUxtsVj1Ce31ygBLdkb5WN8o4aNMAow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed May 01 12:31:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXUJv-0007K2-TT
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 12:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759423Ab3EAKb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 06:31:28 -0400
Received: from mail-vb0-f47.google.com ([209.85.212.47]:40711 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759312Ab3EAKb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 06:31:26 -0400
Received: by mail-vb0-f47.google.com with SMTP id x14so1146839vbb.34
        for <git@vger.kernel.org>; Wed, 01 May 2013 03:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=oiEAgMb/m/7EgwQECwR7bhX87GYTde2OZodKOANMtCs=;
        b=e0shLqAGlPNuFjRRbOiavFZS0rWlbTGdd3w9onL2zuwe8TIJR4JYkk5hoGULbauMiM
         vVSmdqmDBJp/5hu520SFGqzdPmFAWzU2xQn4AEse0QYbxFSIOIqV8dfAjRBn9liMPkfh
         +98oG0lJ5XQQA2sSU2O8aohU2ZzEZXqx69+yb4DmQaauvP8qYENfeRtgJeAAktpaSBGx
         aN/pjFcU+0wWP1eXUOfFx9eYOA073bKRa2XcmJ51XjdoJ4HQ2RR6P3R0x9sQ3D5eA6jL
         l3XYbeWLFVDi1qpLbkIdJQsjXVbk6104XQcHr3rES2897D2C3wNxB7LTwrjUDXmTeLqm
         kW+A==
X-Received: by 10.52.96.138 with SMTP id ds10mr614598vdb.3.1367404286166; Wed,
 01 May 2013 03:31:26 -0700 (PDT)
Received: by 10.220.22.199 with HTTP; Wed, 1 May 2013 03:31:10 -0700 (PDT)
In-Reply-To: <CAPig+cSQeU8BaaPm7GfCUxtsVj1Ce31ygBLdkb5WN8o4aNMAow@mail.gmail.com>
X-Google-Sender-Auth: K7ymGQ9J7L_h7E4KuhuGwpnXXfk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223079>

On 1 May 2013 11:12, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, May 1, 2013 at 5:51 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> So HEAD@{0}~0^0 is too much to type, but we can remove '^0', and we can
>> remove '~0', and we can remove 'HEAD', which leaves us with @{0}, but we
>> can't remove '{0}'?
>>
>> This patch allows '@' to be the same as 'HEAD'.
>>
>> So now we can use 'git show @~1', and all that goody goodness.
>>
>> Until now '@' was a valid name, but it conflicts with this idea, so lets
>
> s/lets/let's/  (contraction of "let us")

Ah, the contraction versus the first person singular.  In this case
where the context is concluding in decision, rather than making a
statement ("Let's go to the shops", for example) then "lets" is the
correct word to use here.

-- Thomas Adam
