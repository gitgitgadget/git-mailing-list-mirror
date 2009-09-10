From: John Tapsell <johnflux@gmail.com>
Subject: Re: obnoxious CLI complaints
Date: Thu, 10 Sep 2009 22:46:58 +0300
Message-ID: <43d8ce650909101246l50189c97r4f3fc4a8d7a0bd4@mail.gmail.com>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com>
	 <m3fxavvl5k.fsf@localhost.localdomain>
	 <4C1FB36D-F8A6-4C01-A42A-8AD2355A9961@wincent.com>
	 <200909101850.26109.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>,
	Brendan Miller <catphive@catphive.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 21:52:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mlph3-0007mc-3p
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 21:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434AbZIJTwX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Sep 2009 15:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbZIJTwW
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 15:52:22 -0400
Received: from mail-yw0-f174.google.com ([209.85.211.174]:49634 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbZIJTwW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Sep 2009 15:52:22 -0400
X-Greylist: delayed 326 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Sep 2009 15:52:22 EDT
Received: by ywh4 with SMTP id 4so466682ywh.5
        for <git@vger.kernel.org>; Thu, 10 Sep 2009 12:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CbdfTpmlTp8MXuP5h3nlOzPiN6uTS4sZuvOEMpFROCI=;
        b=kNvu+jbjLERv/Evcr5JKYFR0gPo8Q8MKp2vRDIicRFdS37S8sb1rY+vSlnCsIAqKQA
         DsAoye2lkxvuzfnqvOwBi8LfEJS2UKwl09ZjbNqw0jjeTdUxKiW1UDSz2IL4H+907/El
         4hjS5SDTYbze6LZNQIWQOg4iv2iAAv0C8v0nw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=onCpmAmAn/+g45ZcSJsNj3yub2u8Vrsh45+UhVVgaomXRmkfhpfnx6s45u7DVLOD3p
         2cx8NCEMAj8u4ihYCXPNUQoxAUIJTlu2VqMTzl36hJS7xIFu+HyKORRHFr3XRG/Wqsvl
         I8w7nbrCOQn5lM7kgTxSFFiOGB74cM8FA83a8=
Received: by 10.150.65.19 with SMTP id n19mr3398338yba.119.1252612018329; Thu, 
	10 Sep 2009 12:46:58 -0700 (PDT)
In-Reply-To: <200909101850.26109.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128137>

2009/9/10 Jakub Narebski <jnareb@gmail.com>:
> Dnia czwartek 10. wrze=C5=9Bnia 2009 00:06, Wincent Colaiuta napisa=C5=
=82:
>> El 09/09/2009, a las 23:54, Jakub Narebski escribi=C3=B3:
>>> Brendan Miller <catphive@catphive.net> writes:
>>>
>>>> 5. Most commands require lots of flags, and don't have reasonable
>>>> defaults. e.g. archive.
>>>>
>>>> $ git archive --format=3Dtar --prefix=3Dmyproject/ HEAD |
>>>> > gzip myproject.tar.gz
>>>>
>>>> Should just be:
>>>> git archive
>>>> run from the root of the repo.
>>>
>>> I'd rather not have "git archive" work without specifying tree-ish.
>>
>> Why, out of interest? I would've thought that HEAD would be a pretty
>> good default, although I confess that I have never used "git archive=
"
>> without specifying a particular signed tag.
>
> First, it would be consistent with how ordinary archivers such as tar
> or zip are used, where you have to specify list of files to archive
> (in our case this list is HEAD). =C2=A0Second, I'd rather not acciden=
tally
> dump binary to terminal: "git archive [HEAD]" dumps archive to standa=
rd
> output.

That could be fixed by outputting to a file.  git format-patch outputs
to a file, so why wouldn't git achieve?

John
