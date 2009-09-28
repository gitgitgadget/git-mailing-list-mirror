From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 1/2] Make generated MSVC solution file open from Windows 
	Explorer
Date: Mon, 28 Sep 2009 15:40:24 +0200
Message-ID: <bdca99240909280640x410ba7f4u5bd09a8cba2c9bb2@mail.gmail.com>
References: <4ABB84F4.7080403@gmail.com> <20090925220510.GY14660@spearce.org>
	 <bdca99240909251541h2e9932a3r67c1d8604e56a8df@mail.gmail.com>
	 <20090925225940.GB14660@spearce.org>
	 <bdca99240909251658q395a62b6r8d5998382ac3fc7b@mail.gmail.com>
	 <20090926000500.GE14660@spearce.org>
	 <bdca99240909260245i6ba10dd4j1b2ee9e74ea5282d@mail.gmail.com>
	 <2faad3050909280336r61e11b20nb52629a8fe95b0c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	mstormo@gmail.com
To: Baz <brian.ewins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 15:40:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsGSu-0004UC-00
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 15:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbZI1NkW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Sep 2009 09:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbZI1NkW
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 09:40:22 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:62190 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbZI1NkV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Sep 2009 09:40:21 -0400
Received: by fxm18 with SMTP id 18so3655912fxm.17
        for <git@vger.kernel.org>; Mon, 28 Sep 2009 06:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FsZrBcKsMpr99gwpUhG5d4PPOPZnFYPhYC747VGSaf4=;
        b=LAVpjp+iu5juCeybE3lm+2EvUQtTDH7+CS2zh8vm1t8NisJTPyf1WRL48nFb0cUKrV
         6fHBGV+sv1XZ0E6krdTFa+S4dCc62D6Jfgagi8+t2WWGzeU+w+g7qbx50Ja6pAb6zYR9
         QeVY3n9makAfCLkzwAhXIA/4B9/1pPi498bDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eBPB/lGjKScj7YMLVWMbBYsdbxFHKb/0V1EyFltgCYo9hGHc+1wmIo/UM6Knes5iAJ
         2oxSOll/b6piz2JJaMUHwvRUPPLBGyNSi+pKJVMPYBZvcxemJOMl/EMe504FIAUNPXj1
         oBOOGBe96KwcjsNqjVyruTaC913FOCh6WEyjk=
Received: by 10.86.221.25 with SMTP id t25mr3350011fgg.19.1254145224691; Mon, 
	28 Sep 2009 06:40:24 -0700 (PDT)
In-Reply-To: <2faad3050909280336r61e11b20nb52629a8fe95b0c0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129261>

On Mon, Sep 28, 2009 at 12:36, Baz <brian.ewins@gmail.com> wrote:

>>> Odd. =C2=A0If I copy and paste from Thunderbird, its fine. =C2=A0Bu=
t if I
>>> save the body out as an attachment from mutt, it fails.
>>>
>>> I wonder if it has to do with the From header appearing in the top
>>> of the body; this header has to be escaped with a leading space in
>>> mbox format. =C2=A0It looks like Thunderbird might be doing some ma=
gic to
>>> remove that leading space from the context lines, while mutt isn't.
>
> FYI: the Thunderbird version included this header:
> Content-Type: =C2=A0text/plain; charset=3DISO-8859-1; format=3Dflowed
>
> The format=3Dflowed part shows that Thunderbird is reformatting
> whitespace. You can disable that:
> http://kb.mozillazine.org/Plain_text_e-mail_-_Thunderbird#Completely_=
plain_email

Thanks, this was indeed helpful. I was relying on the "Toggle Word
Wrap" extension [1] to handle this, but apparently it only changes how
the *sender* sees the message, but does not remove "format=3Dflowed" if
word wrap is turned off. I've sent an according suggestion to the
extension's author.

[1] https://addons.mozilla.org/en-US/firefox/addon/2351

--=20
Sebastian Schuberth
