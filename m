From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 19:27:30 -0500
Message-ID: <b4087cc51003181727k37dabd15y12ba34762b67c4d7@mail.gmail.com>
References: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org> 
	<46a038f91003181419n5d076bdbv18e32e292d7937a8@mail.gmail.com> 
	<b4087cc51003181429v2998b95ei3f08360e6d2a5aa7@mail.gmail.com> 
	<46a038f91003181439lc343dafl6b9321a0b620de84@mail.gmail.com> 
	<b4087cc51003181446r6bd89371q9f2e7a14bfa4d557@mail.gmail.com> 
	<46a038f91003181455u7136e011u5352c996384f086d@mail.gmail.com> 
	<b4087cc51003181502y1f339cf8u268fa5388ace098@mail.gmail.com> 
	<alpine.LFD.2.00.1003181935070.31128@xanadu.home> <b4087cc51003181644j45722911u87d4cb62a9b4ea09@mail.gmail.com> 
	<alpine.LFD.2.00.1003181958430.31128@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Mar 19 01:27:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsQ4D-0000cd-28
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 01:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025Ab0CSA1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 20:27:52 -0400
Received: from mail-fx0-f219.google.com ([209.85.220.219]:52184 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640Ab0CSA1v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 20:27:51 -0400
Received: by fxm19 with SMTP id 19so195770fxm.21
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 17:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=MpSEWC6dN6K34m9wzCVXFqp/qKrJnEW2P2lRryb03K0=;
        b=q336vJgoxIEeAMGGFCcIgvKWlUNdGc0yKojNblUL81QFA3vIKLeBV1cR+AHzrI57pe
         cZ2TAYP5AS1qUbx+P0xnq2DiJdYfSOMJI/+IyEYIZl3gAV4UdjgnJcMaR/BCv62MeuGX
         xHt3E4NinxlbIHeFHi7a7JIoALV3rWfkU6www=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=aB65471rjO6uTjGJLFd3zgekTOaihL/xcLvxQHVw7Cf6wQO43Ul62I4bZ5fkbuN4nO
         RuNQrXyc15ouDyS1MHKTR1BaC+ZxaQ9xPkQ4Dah3SR+l09xIXmuR4CkMO3DaYFfjK13E
         nRMMsvZs/TG8QRVNgleMeQzMJQPqruO5AIads=
Received: by 10.239.190.145 with SMTP id x17mr502537hbh.201.1268958470212; 
	Thu, 18 Mar 2010 17:27:50 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1003181958430.31128@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142546>

On Thu, Mar 18, 2010 at 19:03, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Thu, 18 Mar 2010, Michael Witten wrote:
>
>> On Thu, Mar 18, 2010 at 18:37, Nicolas Pitre <nico@fluxnic.net> wrote:
>> > On Thu, 18 Mar 2010, Michael Witten wrote:
>> >
>> >> You missed the other line (probably gmail's fault):
>> >>
>> >> Most likely, all that will happen is identification entropy won't
>> >> increase nearly so rapidly and there might be other benefits
>> >> such as shortlog speed improvements.
>> >
>> > The shortlog speed improvement is certainly not going to compensate for
>> > all the added human time needed to process the extra piece of
>> > information.
>>
>> What added human time?
>
> The time that humans will have to spend on this UUID
> setup/fixing/whatnot.

Compatibility concerns aside, there is virtually no overhead. Indeed,
there would be less overhead than there is now in terms of fixing.
