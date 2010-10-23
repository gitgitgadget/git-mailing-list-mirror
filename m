From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: should Documentation/howto/setup-git-server-over-http.txt be
 marked obsolete?
Date: Sat, 23 Oct 2010 11:57:31 +0530
Message-ID: <AANLkTimTVviTBfY1Zeebyhufr36U+0w7VYf4f=25FMFi@mail.gmail.com>
References: <AANLkTimJe9vEUwWM482NLmfHGYjnsKD5RAryQO=Zyqjj@mail.gmail.com>
	<7vsjzyrh2w.fsf@alter.siamese.dyndns.org>
	<AANLkTinv3kzvtC_Pq4F0cM_JqU7-Q2a=sWs8YSxbMiPs@mail.gmail.com>
	<20101022150627.GB9224@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 23 08:28:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9XaA-0007dj-IV
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 08:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032Ab0JWG1d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Oct 2010 02:27:33 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:38428 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489Ab0JWG1d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Oct 2010 02:27:33 -0400
Received: by ewy7 with SMTP id 7so2218140ewy.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 23:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bunBoXb7VNLT0SawN4FthITapQsRBhklJXtzQsCZG8g=;
        b=wDoE36QgJZYo6Uwx1En24PjtWBqrr5mkHTMT5WrVC0PJldmlxU8iv9PHyDEI16bJ0l
         c4ojQfMRttYYu9q0jz82XTzCiOmtfCevhX5rGLwKekZLKLh70du+JjxaKj2VAgO9LTJ/
         q/qbqxuPkWnW5oSAOAom4xeM2wLk4iSRfr05o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LErr3tPqSSdRRkIm3fEG9qqcdPlj16aD3TZPvU8s6Jccn6dcV3TcQvaW1dQT22H2Ks
         W/8F5rI+B9vTUIBN0DRqNvMCCaWGpu6XlE1IMcraYv+HwzXzYzMkzV9ySY5LlXocECEv
         UkUH+Futtqs//6KVQ57Oycaz/p/GXgANv/jMk=
Received: by 10.213.4.206 with SMTP id 14mr4042691ebs.99.1287815251634; Fri,
 22 Oct 2010 23:27:31 -0700 (PDT)
Received: by 10.213.14.6 with HTTP; Fri, 22 Oct 2010 23:27:31 -0700 (PDT)
In-Reply-To: <20101022150627.GB9224@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159772>

On Fri, Oct 22, 2010 at 8:36 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Sitaram Chamarty wrote:
>
>> I assumed that the new -- much more efficient (correct?) transport
>> would make the older (dumber) transport obsolete, and I didn't reali=
se
>> it had any advantages over the new one.
>
> FWIW the old transport still has its place. =C2=A0If your web host (e=
=2Eg.,
> an ISP) allows only static content (no CGI), then there is no choice.
>
> Not so relevant for gitolite but still relevant in the world.

Also I now realise the new transport requires Apache, so people with
other web servers probably need it too.

I guess what remains is that the protocol is not efficient enough,
especially for normal push/fetch working-day interactions.  I'll find
suitable wording that reflects all this...

thanks

sitaram
