From: Alangi Derick <alangiderick@gmail.com>
Subject: Re: Patch that modifies git usage message
Date: Fri, 1 May 2015 16:54:38 +0100
Message-ID: <CAKB+oNtsy4E5Y6d3VCvdrjRTsdqARu8nJPYjH5J-qUenirR8mg@mail.gmail.com>
References: <CAKB+oNtYbJXNb2wGzJCdQ5Ru5fq3HzcapSqiTVC_34=xDnTb7Q@mail.gmail.com>
	<CAGZ79kY1ZoYrVwVVqfyB+uMGsJo59qDxbDLgyo5qygSm=CUVhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 01 18:09:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoDVi-0001Xb-J5
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 18:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbbEAPym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 11:54:42 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35101 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754302AbbEAPyj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 11:54:39 -0400
Received: by qkhg7 with SMTP id g7so52893691qkh.2
        for <git@vger.kernel.org>; Fri, 01 May 2015 08:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pnLV2wYAVkfRwNB1AjJCTOuqNz+YlmNDz3SlCz42jwg=;
        b=Ut1vjwAciaEpE9yBjyE2G4VexXvnIc0+OMiRuAuWyUFEl3vio6mm9vbTcVtgROeVjf
         XWc/xsVLKrxcaPfM1rmun9lZ49+faeJX89f/UTVYZcul3H4YZfrNhGTC5vFGcem+J5+l
         Iezjo9KyanvyWS7fiT1t13eOsNCsS2f4C4j+wiMWoNwyuYDYyYJQX2HCREovA8Ue+ACk
         5cYWEPcbbGfNUmaF/SjcCBbpVOozcG905zLCsH/AyeLTB6NiOtEk1CF5zJoIAyVe/8uH
         Lyf08hOnfqXDhJCAcqYwnyl+XLc2LD5xlj+m/RP1P4zjZygH8Md8Cyo8L63dFS5AceZx
         HOHQ==
X-Received: by 10.140.32.34 with SMTP id g31mr11365515qgg.74.1430495678346;
 Fri, 01 May 2015 08:54:38 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Fri, 1 May 2015 08:54:38 -0700 (PDT)
In-Reply-To: <CAGZ79kY1ZoYrVwVVqfyB+uMGsJo59qDxbDLgyo5qygSm=CUVhA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268152>

I am saying so because there are some strings with upper case letters
and others with lower case letters. So there is no consistency. That
is why i wanted to keep the consistency by correcting the letters
which are to be corrected and allow the once which are to be allowed.
Regards
Alangi Derick Ndimnain


On Fri, May 1, 2015 at 4:51 PM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, May 1, 2015 at 4:01 AM, Alangi Derick <alangiderick@gmail.com> wrote:
>> This patch just modifies the "usage" word to "Usage" which enhances
>> readability. Below is the patch
>>
>> Regards
>> Alangi Derick Ndimnain
>
> It's easier to have the patch in the email itself, this looks it's
> some form of attachment.
>
> Checkout Documentation/SubmittingPatches (protip: get "git send-email"
> working, it will
> send in the preferred way by default for nearly any open source
> project using email based
> workflows.)
>
> There are also some resources on the web, how to send patches,
> although it should be
> all covered in our Documentation,
> http://alblue.bandlem.com/2011/12/git-tip-of-week-patches-by-email.html
>
> For the patch itself:
>
> $ grep -r usage *.c builtin/*.c |wc -l
> 551
> $ grep -r Usage *.c builtin/*.c |wc -l
> 3
>
> The community agreed (maybe subconciously) to prefer lower case
> for the 'usage' string, so I don't think this is an improvement.
