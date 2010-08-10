From: Sultan Shakir <sshakirflhosp@gmail.com>
Subject: Re: Git and Documentation
Date: Tue, 10 Aug 2010 15:55:10 -0400
Message-ID: <AANLkTikwVfymGB8oEQUN=1LMWoif22p316mm=PzSxQwa@mail.gmail.com>
References: <AANLkTik_rO_+az5kE=yhfXK1uUO3v0RKdcO2hzFBcZym@mail.gmail.com>
	<AANLkTi=P=RsToSor=giC+dgV24bPj7KJ3eRV1M5a+iuD@mail.gmail.com>
	<AANLkTi=pk4oXz84kWbHEzTUiWkTV5P4P9mTwzQbJG865@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 22:13:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OivCm-0001Tt-V8
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 22:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913Ab0HJUNj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 16:13:39 -0400
Received: from mail-qw0-f66.google.com ([209.85.216.66]:59115 "EHLO
	mail-qw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720Ab0HJUNh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Aug 2010 16:13:37 -0400
X-Greylist: delayed 1106 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Aug 2010 16:13:37 EDT
Received: by qwd7 with SMTP id 7so1689816qwd.1
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 13:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=/QCzx1HLLUNiTRJT1nwPcOwL4CXmzSGK5e6p+IHKdtg=;
        b=x/IicrHQmKLiOxRO32pHU1mbFFVGdZoke1c+jcsxpChc6u0zUB8tzRDZbdV5tVL3yY
         PcGnAzNJ6Bk5qdGGw5uh1+JUsbRu3QJMaJY80g/il1UUXHzm0Sr5lybVqRhI/+3wD3tj
         Q3We/ZnejQ9Wsx3Q4FdINtegJYoWW602NeFS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=v6pp5y+ZXwOP4FQKHhX3QMIAfnuyNXCwW86jIokPQ/6DETp5CgZYopSWzvP2C/apfX
         wExnzNLEPVDvRnj+w7y2yWXFXXJtkKNr2uEvbvlDn94PT4pYSBdvsuP/2XY2W71NHDNm
         LEW2AbcP65xCAKZTBIuPecHIhkFA2mx+mqIEY=
Received: by 10.229.51.206 with SMTP id e14mr8622432qcg.232.1281470110653; 
	Tue, 10 Aug 2010 12:55:10 -0700 (PDT)
Received: by 10.229.69.76 with HTTP; Tue, 10 Aug 2010 12:55:10 -0700 (PDT)
In-Reply-To: <AANLkTi=pk4oXz84kWbHEzTUiWkTV5P4P9mTwzQbJG865@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153152>

Yes I guess I could. =A0I am a little new at this. =A0 I got the same i=
dea
after watching Stephen Wood's video here:
http://developer.yahoo.com/yui/theater/video.php?v=3Dwoods-yuiconf2009-=
yuidoc
=2E =A0He had 3 rules/guidelines that might work if we use YUI Doc to
generate the documentation:

1) Generate documentation as part of the build
2) Don=92t manually check documentation in to VCS (do it automatically)
3) Treat documentation comments like code

I am not sure how to make it run as part of my build process though.

On Mon, Aug 9, 2010 at 4:43 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Aug 9, 2010 at 17:35, Sultan Shakir <sshakirflhosp@gmail.com>=
 wrote:
>> Dear Git Community:
>> My organization is exploring using Git to manage our code repository=
=2E
>> We also have a strong need for documentation of our code. =A0The cod=
e is
>> written in a=A0proprietary language (Discern Explorer/CCL). =A0We lo=
oked
>> into Natural Docs but don't think we can combine it with Git.=A0=A0D=
oes
>> anyone know of an app where we can combine the power of Git and code
>> documentation in one? =A0Thank you. -Sultan
>
> Can you be clearer. That question makes little sense.
>
> You can keep your documentation *in* Git if it's in files that you ca=
n
> keep in version control. So in that case you could keep it alongside
> your code.
>
> Can't you use this approach?
>
