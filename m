From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Problem with git-http-backend.exe as iis cgi
Date: Tue, 29 Mar 2016 22:28:22 +1300
Message-ID: <CAFOYHZB6VEcXK9QV7puDMTsGQGdd8bqAHCsSnSn1Z5WuWs49qg@mail.gmail.com>
References: <F0F5A56A22F20D4CB4A03BB8D6658797E260E0E3@SERVER2011.CS-SOFTWARE.local>
	<20160310155522.1dee53cf95fead8cfd4e178a@domain007.com>
	<F0F5A56A22F20D4CB4A03BB8D6658797E261A10C@SERVER2011.CS-SOFTWARE.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Konstantin Khomoutov <kostix+git@007spb.ru>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Florian Manschwetus <manschwetus@cs-software-gmbh.de>
X-From: git-owner@vger.kernel.org Tue Mar 29 11:36:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akpwr-0001QZ-BJ
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 11:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756465AbcC2J20 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 05:28:26 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36796 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756325AbcC2J2X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2016 05:28:23 -0400
Received: by mail-ig0-f181.google.com with SMTP id nk17so71645231igb.1
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 02:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=pxKWFDotfG4dPUxP5XPv1/duTqw77uYOnTEFpAvPmhY=;
        b=FszxdzrPzwXzz4+7EG7T3f8mvHOmYnGvVnlfRVIe6kxHko+whoLnv1P9AD3upNvDYT
         NwOLR/kw97NN9fwS0EfsFq2X2G32miYPJlcw92o0GfIIlj4/TunapEq5BedHUdwriWOM
         PnkXS9ZnxPIjRRdCMJ0rdXWEnABeft7euooUkHB5HxApTRsDB4UTQS46Aoy83hPWD64d
         gogRwmgXMfF7/qZFlU3IYyl9g2KkxCa/+EOau9QtQ/3a72lcJCtYqHNChFG8GSA75BGe
         13avwCUls/pT6pV9jBlquJnW0chJoFo/9RRsptbK92V2vp+t4t7uG1HukmO4eBQIg35/
         +k1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=pxKWFDotfG4dPUxP5XPv1/duTqw77uYOnTEFpAvPmhY=;
        b=FSgpbDwFA5BphxC/ppvE3P1iLZ+6R4mCF6f75ciiDLPfPerxRIVgfY9l9n8DJlcKRD
         2dTpjVPOaf/PumaI4jVwgVTEJbdKzaV7wjXqxITBL1XgsjszhAWqsFcTuquYd+uv/E9Q
         H3a60tDVIg5m533JDELwv1vam6xoNk4w63KEyc8ZIYM5tEZr6mADQjqzH+0QjZZcFNUK
         ZO3cg3AQyLorIR4TdFcc9+gybMmy+DOCDoOhthk9hABx1JNJgWN6zYoQMsbO9l0r37Ka
         L4+iRlZgKbtIbSEwLk5hSmWzjj1KSqALzumzNo+xn8xJT/uuhuRsqjcKU1NdjwezF0My
         UImQ==
X-Gm-Message-State: AD7BkJISaXBWxpekd1kytoz0+IsqprAFAIcRlkH34gATGcLGq2qGq6XuMOwwEKK14Pf5FDn+agpYQV5nfj37dA==
X-Received: by 10.50.4.73 with SMTP id i9mr1669856igi.24.1459243702157; Tue,
 29 Mar 2016 02:28:22 -0700 (PDT)
Received: by 10.79.110.1 with HTTP; Tue, 29 Mar 2016 02:28:22 -0700 (PDT)
In-Reply-To: <F0F5A56A22F20D4CB4A03BB8D6658797E261A10C@SERVER2011.CS-SOFTWARE.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290107>

Hi Florian

On Tue, Mar 29, 2016 at 7:01 PM, Florian Manschwetus
<manschwetus@cs-software-gmbh.de> wrote:
> Hi,
> I put together a first patch for the issue.
>
> Mit freundlichen Gr=C3=BC=C3=9Fen / With kind regards
> Florian Manschwetus
>
> E-Mail: manschwetus@cs-software-gmbh.de
> Tel.: +49-(0)611-8908534
>
> CS Software Concepts and Solutions GmbH
> Gesch=C3=A4ftsf=C3=BChrer / Managing director: Dr. Werner Alexi
> Amtsgericht Wiesbaden HRB 10004 (Commercial registry)
> Schiersteiner Stra=C3=9Fe 31
> D-65187 Wiesbaden
> Germany
> Tel.: 0611/8908555
>
>
> -----Urspr=C3=BCngliche Nachricht-----
> Von: Konstantin Khomoutov [mailto:kostix+git@007spb.ru]
> Gesendet: Donnerstag, 10. M=C3=A4rz 2016 13:55
> An: Florian Manschwetus
> Cc: git@vger.kernel.org
> Betreff: Re: Problem with git-http-backend.exe as iis cgi
>
> On Thu, 10 Mar 2016 07:28:50 +0000
> Florian Manschwetus <manschwetus@cs-software-gmbh.de> wrote:
>
>> I tried to setup git-http-backend with iis, as iis provides proper
>> impersonation for cgi under windows, which leads to have the
>> filesystem access performed with the logon user, therefore the
>> webserver doesn't need generic access to the files. I stumbled acros=
s
>> a problem, ending up with post requests hanging forever. After some
>> investigation I managed to get it work by wrapping the http-backend
>> into a bash script, giving a lot of control about the environmental
>> things, I was unable to solve within IIS configuration. The
>> workaround, I use currently, is to use "/bin/head -c ${CONTENT_LENGT=
H}
>> | ./git-http-backend.exe", which directly shows the issue. Git
>> http-backend should check if CONTENT_LENGTH is set to something
>> reasonable (e.g. >0) and should in this case read only CONTENT_LENGT=
H
>> bytes from stdin, instead of reading till EOF what I suspect it is
>> doing currently.
>
> The rfc [1] states in its section 4.2:
>
> | A request-body is supplied with the request if the CONTENT_LENGTH i=
s
> | not NULL.  The server MUST make at least that many bytes available =
for
> | the script to read.  The server MAY signal an end-of-file condition
> | after CONTENT_LENGTH bytes have been read or it MAY supply extensio=
n
> | data.  Therefore, the script MUST NOT attempt to read more than
> | CONTENT_LENGTH bytes, even if more data is available.  However, it =
is
> | not obliged to read any of the data.
>
> So yes, if Git currently reads until EOF, it's an error.
> The correct way would be:
>
> 1) Check to see if the CONTENT_LENGTH variable is available in the
>    environment.  If no, read nothing.
>
> 2) Otherwise read as many bytes it specifies, and no more.
>
> 1. https://www.ietf.org/rfc/rfc3875

Your patch description seems well thought out but if you want someone
to notice it you should have a read of
https://git.kernel.org/cgit/git/git.git/tree/Documentation/SubmittingPa=
tches
