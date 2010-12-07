From: demerphq <demerphq@gmail.com>
Subject: Re: git diff --summary only seems to work when combined with --stat
Date: Tue, 7 Dec 2010 07:53:42 +0100
Message-ID: <AANLkTinuQoJLfDq8HhUd=FLoqosVD23MU6ch6Ea2iVSJ@mail.gmail.com>
References: <AANLkTimCAy8kcQaKNaxz4UJp2ZB=_HeRMmeaQ5ZHNV4g@mail.gmail.com>
	<20101206210304.GA9735@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 07:53:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPrQz-0002dn-Cd
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 07:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186Ab0LGGxv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 01:53:51 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:43790 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155Ab0LGGxv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 01:53:51 -0500
Received: by qyk12 with SMTP id 12so15460645qyk.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 22:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mciW1TK67wElHYFGJ0iWpu7yHsE792ho3SXelP8rgzA=;
        b=b+ROPb3aAjcR+h43M9nN96l1rs8RRkYUIUbLktsPJ1dMkgB9mzPRlpnCchqPSaCFSW
         CtcioG9P12Zv9rAhuBI2W4FvI9O8KVSQ28l9VYdYOWEyrpenXP6GG5LOnXtSEmURPqBv
         DcvuvjHR9LTbDgzeBGMpYWsAGgyO5ISSdWhNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZJDIHIeuM1REFCHxyQVlIlkB9vhDMblT+X27lPo+qhuqflLCtSvsbZVpSSDo2JTdfh
         iDCZnHJmRBxOHvMHpQ8kF31h5twmWm57O8cRHDvRiIi6otLwBs6bj9Rfer4O3hTVyeKM
         06nudvqd2Ehty887e+y7wWTUtU55xhIgMxmFU=
Received: by 10.229.251.204 with SMTP id mt12mr5306158qcb.182.1291704822372;
 Mon, 06 Dec 2010 22:53:42 -0800 (PST)
Received: by 10.229.192.193 with HTTP; Mon, 6 Dec 2010 22:53:42 -0800 (PST)
In-Reply-To: <20101206210304.GA9735@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163069>

On 6 December 2010 22:03, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi Yves,
>
> demerphq wrote:
>
>> It seems like the --summary option only works in combination --stat.
>>
>> It doesn't seem to work if I use it by itself, nor in combination wi=
th
>> --name-status or --num-stat. And depending on the order, it either
>> does nothing, or causes a usage note.
>
> It is tricky, but as you noticed --summary is not actually about the
> diffstat. =A0--summary affects the output summarizing new files and
> renamed files.
>
> Example:
>
> =A0 =A0 =A0 =A0$ git diff --summary v1.7.2..v1.7.3
> =A0 =A0 =A0 =A0delete mode 100644 Documentation/RelNotes-1.5.0.1.txt
> =A0 =A0 =A0 =A0delete mode 100644 Documentation/RelNotes-1.5.0.2.txt
> =A0 =A0 =A0 =A0[...]
>
>> $ git diff --name-status --sumary HEAD^
>> usage: git diff <options> <rev>{0,2} -- <path>*
>
> There is an 'm' missing here. :)

Thanks for your reply. It turns out that was a mis-paste. I tried both
splelings of summary. ;-)

And none of them produce output.

$ git diff --summary HEAD^..HEAD
$ git diff --summary HEAD^^..HEAD
$ git diff --summary HEAD..HEAD^
$ git diff --summary HEAD^

So why does it work for you but not for me?

Yves


--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
