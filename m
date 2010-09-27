From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv5 01/12] gitweb: introduce remote_heads feature
Date: Mon, 27 Sep 2010 08:42:54 +0200
Message-ID: <AANLkTi=QOMW3CaoiWja-it7+U0H2Nz95CC8-nkJ60jm2@mail.gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1285344167-8518-2-git-send-email-giuseppe.bilotta@gmail.com>
 <201009261924.06237.jnareb@gmail.com> <AANLkTikotGEOOeUOwz03xtL09fV+oycV3yG1O4hQhoQB@mail.gmail.com>
 <4C9FA35F.4090800@ripton.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: David Ripton <dripton@ripton.net>
X-From: git-owner@vger.kernel.org Mon Sep 27 08:43:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P07RA-0003Nu-AK
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 08:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758716Ab0I0GnR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 02:43:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60985 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758676Ab0I0GnQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 02:43:16 -0400
Received: by iwn5 with SMTP id 5so4523220iwn.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 23:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=FtrxkRZ38ykOtzQbJlCIxjA7DZSOQGudzOeLWYnhEbM=;
        b=xefrVT/+jAiFhkK/PotXH+chZIdhv+quzX8t3Drct+uKO9m3httDGMEyEWCqQB8/sJ
         vzUVjBYpZ6V0dA14wCB5pUl2ONy+wSGmPOP2C8J85xzeAt02+tWeBHPQLwri7TfDsNU+
         S8uWiYg9f+Rq8/eqYktbrZjsxSIwLnnKJ2dXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=CrjS4QnwXRQtFGRwSntz8cI7OznMcDNNJSLOm2RzKnWQ/nKCZ2QTCihr0XG0YQhYHG
         zRbUta1mLFz3eJT68MathANXjag1/Gje8QV3FSTe+R2jgQ+shRpZbHRKVTL6nB5Pucri
         v56gl3fSS3XSRWPDUOLMYhLL7akO22Yiud1mI=
Received: by 10.231.157.11 with SMTP id z11mr8565774ibw.147.1285569795894;
 Sun, 26 Sep 2010 23:43:15 -0700 (PDT)
Received: by 10.231.166.145 with HTTP; Sun, 26 Sep 2010 23:42:54 -0700 (PDT)
In-Reply-To: <4C9FA35F.4090800@ripton.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157304>

On Sun, Sep 26, 2010 at 9:47 PM, David Ripton <dripton@ripton.net> wrot=
e:
> On 09/26/10 15:19, =C6var Arnfj=F6r=F0 Bjarmason wrote:
>>
>> 2010/9/26 Jakub Narebski<jnareb@gmail.com>:
>>>
>>> On Fri, 24 Sep 2010, Giuseppe Bilotta wrote:
>>>>
>>>> + =A0 =A0 # Make gitweb show remotes too in the heads list
>>>
>>> Very minor nitpick: it should probably be (but I am not a native
>>> English speaker, so I migh be mistaken)
>>>
>>> =A0+ =A0 =A0 # Make gitweb show also remotes in the heads list
>>
>> Maybe:
>>
>> =A0 =A0 # Configure the display of remotes in the heads list
>>
>> or
>>
>> =A0 =A0 # Toggle the display of remotes in the heads list
>
> IMO either of those are fine. =A0Or you could just swap a couple of w=
ords in
> the original message to make it sound a bit more natural:
>
> # Make gitweb also show remotes in the heads list

I think I like the 'Configure the display' one better. I'll rephrase
the comment in the next rehash of the series.

--=20
Giuseppe "Oblomov" Bilotta
