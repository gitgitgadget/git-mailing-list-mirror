From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: GNU patch: new 2.6 release
Date: Sat, 14 Nov 2009 13:27:38 +0100
Message-ID: <6672d0160911140427p549dfe66p454376eaed346704@mail.gmail.com>
References: <200911140109.34202.agruen@suse.de>
	 <6672d0160911140045h70243c12w3c56ad925dc70d39@mail.gmail.com>
	 <200911141117.29238.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: bug-patch@gnu.org
X-From: git-owner@vger.kernel.org Sat Nov 14 13:27:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9HjT-0002MC-4a
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 13:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbZKNM1e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Nov 2009 07:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbZKNM1e
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 07:27:34 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:42622 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbZKNM1d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Nov 2009 07:27:33 -0500
Received: by fxm21 with SMTP id 21so1327444fxm.21
        for <git@vger.kernel.org>; Sat, 14 Nov 2009 04:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zLjyTjYh1DgVlSr1ifHmH6A0fO/XblxQofp9eNjHlXg=;
        b=JEGy30QCJA7TYNw20P/uI2R07gTLu/OytaF8/OenIJdmimKE0w/g4kuv2Wfakej3ed
         jVOSWjDjlGlwITwXl3Rolk8RMohlPf7pcou4kVIZ9HIBftIdN8malhJ39bFjx/UKs7t7
         WHNOxwKGtQOUnwoYnegKPzBiqLl2Tu4Ss31WQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KHqCF13QHM4oO/pSxGd03lrxwVLLewUizykaRta5sivrJ5OggKRTOOsRk+ZhH5eTAQ
         9Io6ZzUXl5hTRFcV9gsjeRc565eEpusuANmgOW9NKjhEVrOvW8t5mLS4b/Hk5cSiDtya
         DFZCErqGzEQScm0kPtjYQYXijZBaD50X3HwIM=
Received: by 10.204.34.75 with SMTP id k11mr4557358bkd.105.1258201658624; Sat, 
	14 Nov 2009 04:27:38 -0800 (PST)
In-Reply-To: <200911141117.29238.agruen@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132873>

2009/11/14 Andreas Gruenbacher <agruen@suse.de>:
> Support for git's extended header lines for renames, copies, hashes, =
file
> modes would be great. I'll happily take patches or eventually impleme=
nt it
> myself. Binary patches are not as high on my wish list, but feel free=
 to send
> code.

Support for the other extended header lines would be useful for me too.
I might have a go at implementing them (and binary patches) at some
point in the future.

>> That would be very useful in a workflow when you work in git (and ha=
ve some
>> binary files in the repository), but need to commit your finished wo=
rk
>> into another VCS (such as Clearcase).
>
> Isn't there a better way to do this than with patches?

If there is a better way, I would be very interested in finding out wha=
t it is.

=46eeding the output from 'git format-patch' to patch is the
best way I've had come up with yet. patch (given the '-g 1' option)
will automatically check out the files that are to be patched.
I have wrapped that in a simple script that retrieves the commit
comment from the patch and check in the files with that commit
comment.

/Bj=C3=B6rn

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
