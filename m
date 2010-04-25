From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Gitweb: ignore build file
Date: Sun, 25 Apr 2010 22:23:42 +0200
Message-ID: <j2mfabb9a1e1004251323xcd5fc40bme5c4497710d36e52@mail.gmail.com>
References: <1272226625-22628-1-git-send-email-srabbelier@gmail.com> 
	<m2jfabb9a1e1004251319y180319b1nabe7de8765fc9668@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Junio C Hamano <gitster@pobox.com>,
	Mark Rada <marada@uwaterloo.ca>,
	Git List <git@vger.kernel.org>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 25 22:24:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O68NB-0006Wr-8A
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 22:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000Ab0DYUYH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Apr 2010 16:24:07 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:51318 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941Ab0DYUYE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Apr 2010 16:24:04 -0400
Received: by bwz19 with SMTP id 19so73487bwz.21
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 13:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=GyIrNlMeumo0Xx2q5kbQ9zHRhLLazayfFI3Bmb+gwO4=;
        b=Lmu6Jqn9xYiqdRJ2+pIeOqf6CsOTPmW9EfQH9C6AjckOcTYKQO4gUwMCmg267GbO8U
         27AaJqeaLSQi6Knc/YNow41FcjHrlwbF1Hl8zMwEK6Ti3AfnA0g+gz2j5FP9wft1kG2C
         hv1bofcoDP0O32mNl8l7UhFN4sLkvB3hObxvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=gVM/eeWxaz/5x2rHfub9+H/RrPQCgF4D7EcuVPQupINyqv4orEX2WJ5qJ0Poh+qSla
         S9S86Menk/yy5sDgTJSXrLATzGoNkbREQg8qu918sqnDbJJkOrw8aPJJE0fhKf00JjA8
         WJBxbK8DZhN/R6UI7HWy57TsDjBsvw84aSb1k=
Received: by 10.102.207.1 with SMTP id e1mr1692322mug.122.1272227043126; Sun, 
	25 Apr 2010 13:24:03 -0700 (PDT)
Received: by 10.103.168.14 with HTTP; Sun, 25 Apr 2010 13:23:42 -0700 (PDT)
In-Reply-To: <m2jfabb9a1e1004251319y180319b1nabe7de8765fc9668@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145766>

Heya,

[I give up. The 'Signed-off-by' in bb4bbf75829 is wrong, I assumed I
missed an m while copy/pasting, while instead the 'co' should have
been 'ca'. Double apologies for the spam on such a trivial patch!]

On Sun, Apr 25, 2010 at 22:19, Sverre Rabbelier <srabbelier@gmail.com> =
wrote:
> [fixed typo in address of Mark, sorry for the spam to everybody else,
> please reply to this mail, or add the 'm' to uwaterloo.co in the
> previous one]
>
> On Sun, Apr 25, 2010 at 22:17, Sverre Rabbelier <srabbelier@gmail.com=
> wrote:
>> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
>> ---
>>
>> =C2=A0Seems like this was forgotten in 8de096b6
>> =C2=A0("gitweb: simplify gitweb.min.* generation and clean-up rules"=
, Thu Apr 15)
>>
>> =C2=A0.gitignore | =C2=A0 =C2=A01 +
>> =C2=A01 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/.gitignore b/.gitignore
>> index 83dd1e8..14e2b6b 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -156,6 +156,7 @@
>> =C2=A0/git-write-tree
>> =C2=A0/git-core-*/?*
>> =C2=A0/gitk-git/gitk-wish
>> +/gitweb/GITWEB-BUILD-OPTIONS
>> =C2=A0/gitweb/gitweb.cgi
>> =C2=A0/gitweb/gitweb.min.*
>> =C2=A0/test-chmtime
>> --
>> 1.7.1.6.ga2e26

--=20
Cheers,

Sverre Rabbelier
