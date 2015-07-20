From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: How to use --cc-cmd in git-send-email?
Date: Mon, 20 Jul 2015 14:07:00 -0400
Message-ID: <CAPig+cS3NxpTLJL42oV_JpxEjAJSCwrdSuJCWMQxfwK4QjEx8Q@mail.gmail.com>
References: <CA64425B296E41328D6A1F29E227A24D@PhilipOakley>
	<CAPig+cTQspD+0StY5tneqwekS3xCjdxcidoDA7Ztf26g-tMucg@mail.gmail.com>
	<8684534127894F239338493A7D15F46D@PhilipOakley>
	<CAPig+cTsJQ+dK5M0S8LERkPWiipzxLYdbCK6-ghen1OkAX=NBg@mail.gmail.com>
	<28D6CFA8D1964D34B1E7F28325AF94A8@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 20:07:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHFT5-00051H-9R
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 20:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbbGTSHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 14:07:03 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:34688 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbbGTSHB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 14:07:01 -0400
Received: by ykax123 with SMTP id x123so145576958yka.1
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 11:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=NoQ+Vcnea7hDIhPM93eF2Bx9cSIXlV1Jx9xfR5/Zdm0=;
        b=MX526yUHw9aaclr+TwMRnlefmQLboTpj7WXzHkslBmgHM8jjJgSfAksaYR+ktsqHUL
         P0Yj/1t6PBxNQDnVhYfRfFErKTFEpxkcTDLFyXpDQnaaVM5dOuK3+IRcIgsQPxkYBeKW
         Suz9DNUOYKZxxJNZpMOhmgxC9rnsi859Mm5NA5ft482kJYP1CejeuNrsbV9O0C7PvxO3
         0Rytx5Ht14APQZIwWoaMGRMO6liRbire8iXdO2rHzFBqFxZUSSvguhlbeonB759lVKRN
         sWiznN9s1XddA2iofqkavcR8yTN7LA1ATDtVj+qAx6qWWgNwBwHcFYn4nzfBl0j9snvp
         aAAQ==
X-Received: by 10.129.91.87 with SMTP id p84mr30221372ywb.95.1437415620861;
 Mon, 20 Jul 2015 11:07:00 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Mon, 20 Jul 2015 11:07:00 -0700 (PDT)
In-Reply-To: <28D6CFA8D1964D34B1E7F28325AF94A8@PhilipOakley>
X-Google-Sender-Auth: EKIMxINyuoY5MfKGFWb-hIfByN8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274337>

On Mon, Jul 20, 2015 at 10:20 AM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Eric Sunshine" <sunshine@sunshineco.com>
>> On Mon, Jul 20, 2015 at 2:01 AM, Philip Oakley <philipoakley@iee.org>
>> wrote:
>>> I may try and do a small doc patch for the git-send-email.txt man page (I
>>> have a few doc fixes backing up waiting to be done ;-)
>>
>> That would be welcome. I don't think it's mentioned at all in
>> git-send-email.txt that the --to-cmd/--cc-cmd commands are handed the
>> patch pathname as an argument, so that's certainly something worth
>> documenting.
>
> The other issue I noted was wondering what "auto-cc" is?
>
> It's only mentioned the once in:
>    --suppress-cc=<category>
>
> Specify an additional category of recipients to suppress the auto-cc of:
>
> Is it a sort of double negative? Certainly I had no idea what an auto-cc was
> ;-)

I presume that "auto-cc" refers to git-send-email's behavior of
figuring out whom to cc: automatically (by gleaning email addresses
from various sources, such as the patch itself, cc-cmd, etc.). Even
just saying "...suppress the automatic cc:'ing..." would be an
improvement, though it may deserve its own little paragraph explaining
that automatic cc:'ing is occurring and from where the email addresses
are gleaned.
