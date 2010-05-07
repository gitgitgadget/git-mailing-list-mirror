From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 17:30:20 -0400
Message-ID: <m2z32541b131005071430vcd851ac8yd3c783429a84f875@mail.gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> 
	<i2i32541b131005071235z64c9de56w29a2d555cf801c9a@mail.gmail.com> 
	<alpine.LFD.2.00.1005071240590.901@i5.linux-foundation.org> 
	<g2s32541b131005071258s92e058bakc8f3a4df1e1dc634@mail.gmail.com> 
	<alpine.LFD.2.00.1005071303040.901@i5.linux-foundation.org> 
	<alpine.LFD.2.00.1005071306190.901@i5.linux-foundation.org> 
	<576B55DC-C92D-4FEB-B4E8-4A042D6F024B@gmail.com> <alpine.LFD.2.00.1005071355380.901@i5.linux-foundation.org> 
	<384AA932-227B-43B0-9D38-560A3567918A@gmail.com> <alpine.LFD.2.00.1005071421340.901@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	hasan.aljudy@gmail.com, kusmabite@googlemail.com, prohaska@zib.de
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 07 23:30:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAV8L-00072L-2E
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 23:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758602Ab0EGVam convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 17:30:42 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46807 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758587Ab0EGVal convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 17:30:41 -0400
Received: by gyg13 with SMTP id 13so910339gyg.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 14:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=qvSw6U1mokVJ1xu2ZrUClyml/o9GW10fn43UcI/zdRI=;
        b=Cg4m2V1UtI9uMjKjFQS/YUikFba9w3l1/Pv1kRHhsy96mbb7PASXZfAcjqyeo2rM1j
         79aX5O9SgMKJyfjZiS9ODHs1kS5ID+2YbvEzqEag65+TpT/z+R1gD1F3I7SuXmdhxCYa
         nTHgxrFwyYM+t69LZmaV6hB7tIuGCb3tVempA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=t5KCVZK4UzezfYb5TWxwKk9KJgjTZvC+Pbh0AiEnG80C3UUd6RdQPq55MLSukrDG9/
         jDkZsc/VRVVG3KaN1MnrT2YS3Q4pw/e43UGkB6PfunA1wJ1GhsJ05hCeqcR5tIOu1hUu
         hOvUC2E38pD8CC1tMVkUk4csCBR2qvGwKEiyI=
Received: by 10.150.117.42 with SMTP id p42mr4783653ybc.77.1273267840234; Fri, 
	07 May 2010 14:30:40 -0700 (PDT)
Received: by 10.150.217.12 with HTTP; Fri, 7 May 2010 14:30:20 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005071421340.901@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146604>

On Fri, May 7, 2010 at 5:23 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, 7 May 2010, Eyvind Bernhardsen wrote:
>> I don't understand. =A0All you have to do is add "* auto-eol=3Dtrue"=
 to your
>> .gitattributes, and line endings will be normalized exactly as if yo=
u'd
>> set "core.autocrlf". =A0Why would you have to write totally new rule=
s?
>> Which rules?
>
> I think "* auto-eol=3Dtrue" is just crazy. We would _never_ want to d=
o that.
> Any project that does that should be shot in the head.

In the interests of further making myself look like an idiot:

Just to clarify, is it crazy because that line would convert all
files, even binary ones, where core.autocrlf auto-detects whether
files are binary or text?

Avery
