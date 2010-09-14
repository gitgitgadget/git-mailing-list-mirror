From: Ramana Kumar <ramana.kumar@gmail.com>
Subject: Re: [PATCH] Make commit help text more accurate for --verbose
Date: Tue, 14 Sep 2010 19:08:39 +1000
Message-ID: <AANLkTin0W3HOwSQVFR_cm9oJzYib2yULkUc19Pg4yJD6@mail.gmail.com>
References: <1283680383-12495-1-git-send-email-ramana.kumar@gmail.com>
 <AANLkTinEZ92S_XB4zrnb26eVR-MFsDQcSPAZ3RXj6ofH@mail.gmail.com> <AANLkTikLTykbgUjCK4H0cbF0QXZHOPYbLdptEKe4-rD5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 14 11:09:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvRVn-0004ny-82
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 11:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113Ab0INJJE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 05:09:04 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59785 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664Ab0INJJA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Sep 2010 05:09:00 -0400
Received: by wyf22 with SMTP id 22so7185655wyf.19
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 02:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=IE2MtfoqZubbheifBpuXo3WJ8Lco9Ly2NvqpWupQaow=;
        b=jVQJbzWpTPeOQEJ/sQhuMlfACrFyQegQ6AqHdAs/q5Le/zDCpRDF0mYAdtNzgUEbsZ
         YauNGJHqt1SdMmx4OKFPQ79yP8yzFDn7jbS3XWQgscL7FEJFdU9kjfYgQvkwbo6ljwfV
         kiSOFfcwlQsUjJpUApRleUqH3ehLqZayHmA2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=W11VbK3hP53IQZXUkT9qIRqMQ8yDo2VUKzmCih1OGPF2Kti5UoHEH5JViwwB6vsPIi
         lX9g2lQHnKewQdwjoOTGDIH1gCb4NJHnCDtO2YVI020BUYB467+CFtpWOJDvkNcABq9Y
         m9v1daN89LIibn2pebML+1A9Zqk5fe8KeOlK8=
Received: by 10.216.158.140 with SMTP id q12mr3669000wek.14.1284455339269;
 Tue, 14 Sep 2010 02:08:59 -0700 (PDT)
Received: by 10.216.25.9 with HTTP; Tue, 14 Sep 2010 02:08:39 -0700 (PDT)
In-Reply-To: <AANLkTikLTykbgUjCK4H0cbF0QXZHOPYbLdptEKe4-rD5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156167>

On Mon, Sep 6, 2010 at 2:30 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Sun, Sep 5, 2010 at 15:06, Thiago Farina <tfransosi@gmail.com> wro=
te:
>> Hi Ramana,
>>
>> Some *style* comments below.
>> On Sun, Sep 5, 2010 at 6:53 AM, Ramana Kumar <ramana.kumar@gmail.com=
> wrote:
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(fp,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0"\n"
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0"# Please enter the commit message for your changes.");
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cleanup_mode=
 =3D=3D CLEANUP_ALL)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cleanup_mode=
 =3D=3D CLEANUP_ALL && !verbose)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0fprintf(fp,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0" Lines starting\n"
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"# with '#' will be ignored, =
and an empty"
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0" message aborts the commit.\=
n");
>> The Documentation/CodingStyle says to avoid using braces unncessary.
>> But since this is not a single line statement, like:
>> if (foo)
>> =C2=A0foo =3D x;
>>
>> Could you wrapp this into { } ?
>
> The braces are still unncessary if the function call is spread across
> a few lines. I haven't seen anything in the source that indicates tha=
t
> we prefer braces when a braceless if/else has an associated statement
> that exceeds 1 line.

Any other suggestions to improve this patch?
