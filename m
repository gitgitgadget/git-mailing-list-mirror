From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH/resend] Doc: git-push: Specify the default mode in the description
Date: Tue, 9 Nov 2010 13:23:20 +0100
Message-ID: <AANLkTimYTRvOb1SjjUyANuTX2sCRKj17bLMbkKKG3rFg@mail.gmail.com>
References: <1289222435-9610-1-git-send-email-santi@agolina.net> <7vy693o833.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 13:23:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFnEp-0001vW-VR
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 13:23:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755370Ab0KIMXn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Nov 2010 07:23:43 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50875 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754948Ab0KIMXm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Nov 2010 07:23:42 -0500
Received: by vws13 with SMTP id 13so3137974vws.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 04:23:40 -0800 (PST)
Received: by 10.229.237.199 with SMTP id kp7mr6045565qcb.152.1289305420701;
 Tue, 09 Nov 2010 04:23:40 -0800 (PST)
Received: by 10.229.105.76 with HTTP; Tue, 9 Nov 2010 04:23:20 -0800 (PST)
In-Reply-To: <7vy693o833.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161039>

On Mon, Nov 8, 2010 at 9:48 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Santi B=E9jar <santi@agolina.net> writes:
>
>> Signed-off-by: Santi B=E9jar <santi@agolina.net>
>> ---
>> Hi *,
>>
>> =A0 just resend a patch that maybe was missed inside this thread:
>
> No, I didn't miss it.
>
> The new text says 'push "matching" branches' before explaining what i=
t is,
> only vaguely refers the reader to the next section by "see below" wit=
hout
> telling which part of below the reader should look at. =A0In other wo=
rds, it
> wastes two lines without adding two lines worth of additional informa=
tion.
>
> Saying "look for string 'default' below" might be an improvement ;-),=
 but
> then the reader can do that without being told to do so themselves, s=
o...

At least with the new text the reader will know what to look for. She
has to look for "matching" and not the generic "default". BTW, I'll
send another patch with the explanation of matching, but it just
repeats what is written in the <refspec> option...

Another option would be to add "see the <refspec> option below",
although is is already implicit as the paragraph begins with "if no
explicit refspec".

Santi
