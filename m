From: Matthew Daniel <mdaniel@gmail.com>
Subject: Re: [PATCH] git-gui: Do not select Revert Changes by default
Date: Sat, 17 Mar 2012 21:07:59 +0100
Message-ID: <CAHtgEPuLjijzcMiAC3QerATyyCAh912tam-KrYgwihe-RQd4JQ@mail.gmail.com>
References: <loom.20120317T161127-418@post.gmane.org>
	<4F64EDCD.1000405@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Mar 17 21:08:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8zvD-0006qK-PC
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 21:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755232Ab2CQUIH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Mar 2012 16:08:07 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:35645 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226Ab2CQUIB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Mar 2012 16:08:01 -0400
Received: by wejx9 with SMTP id x9so4852934wej.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 13:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=imTDMAmhKADJHoUP5pDdDP1V0txfYEstN0y99hDffdU=;
        b=UxZg2Av/dezK4scRpDIpu1pCYjcV0aJxddNdbaeWbkak65IQnWcPDWHQeEofB8Wh2P
         a5naXOUQPdYovarITmxKvuoNp+QJrhNfCDnr00LLqUuiBSFZiBiTCIVEcTwV6v4wRPBk
         ou1DLf8AMZIulrCacHS6IVyRmSv7WTAjtEHoDDrhaCqQtF2NmzbrE2f6Szx1MidgJYCY
         s2STZ2J/8Zc1ngwI+ak6Kj8LfO1Bc9THI8mG7JfjvQN+yfU9znV323qgOXcYg6wPFvN0
         THHp96nSyQKxB4qvc8xHn3BGJEeEGVG80WmWI6fIFkcviKmdkhy8llbBL3uIE6vHrjBI
         bjUw==
Received: by 10.216.132.40 with SMTP id n40mr4077361wei.68.1332014879668; Sat,
 17 Mar 2012 13:07:59 -0700 (PDT)
Received: by 10.227.172.14 with HTTP; Sat, 17 Mar 2012 13:07:59 -0700 (PDT)
In-Reply-To: <4F64EDCD.1000405@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193350>

Okay, I thought perhaps it was a usability oversight. If it is that
way on purpose, then feel free to not apply the patch.

  -- /v\atthew

On Sat, Mar 17, 2012 at 9:02 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 17.03.2012 16:12, schrieb Matthew L Daniel:
>> Currently, if one activates the revert changes dialog,
>> it has the destructive button selected as the default.
>>
>> This change moves the default action to "do nothing".
>> ---
>> =A0git-gui/lib/index.tcl | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/git-gui/lib/index.tcl b/git-gui/lib/index.tcl
>> index 8efbbdd..252aa33 100644
>> --- a/git-gui/lib/index.tcl
>> +++ b/git-gui/lib/index.tcl
>> @@ -437,7 +437,7 @@ proc revert_helper {txt paths} {
>>
>> =A0[mc "Any unstaged changes will be permanently lost by the revert.=
"]" \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 question \
>> - =A0 =A0 =A0 =A0 =A0 =A0 1 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 0 \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [mc "Do Nothing"] \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [mc "Revert Changes"] \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ]
>
> Gah! Please no!
>
> The destructive action is that you chose Branch->Revert. The dialog i=
s
> the "Are you sure?" question. Your change is the equivalent of an "Ar=
e
> you sure that you are sure?" question. It does not make a lot of
> difference for point-and-click people, but you force another keypress=
 on
> people who operate git-gui with the keyboard.
>
> -- Hannes
