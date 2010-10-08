From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/6] Fix odd markup in --diff-filter documentation
Date: Fri, 8 Oct 2010 13:03:27 -0500
Message-ID: <20101008180327.GA13910@burratino>
References: <87fwwhszsf.fsf@gmail.com>
 <1286559080-27257-3-git-send-email-stepnem@gmail.com>
 <20101008173941.GA13738@burratino>
 <87bp74tvno.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepan.nemec@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 20:06:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4HLB-0002FD-4H
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 20:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698Ab0JHSGk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Oct 2010 14:06:40 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:60817 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932666Ab0JHSGj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Oct 2010 14:06:39 -0400
Received: by qyk10 with SMTP id 10so1602828qyk.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 11:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ZbYsbw0AxgroFxIVz55bzQ99YZGTrfL8FlX0mbNbZvE=;
        b=VMvIDSZT/4lZb8jo1MhzrOk21DXVOXoR79OVFKqDrnzPuD3Kp+9h5qZJsxLEvy7IHD
         mUMdnuGlgdPGHaJqh7b2SBRGecxA2h0BT/K53t13OhMDFSeGgwCciMY2tR0sjoa92TAr
         MHZAg7tk3ejQb0iCcJQsFnybVNs1RKVDNylng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=jMT6/Q8cr1MZAZrW+kLRA+0GrQ6bunxq8hRu8Slde5/FzDcVl3974MAYT+3HSVPKcW
         gyXZqXuVcOhEus9CkMMljvRGZqPmcsDX0eLSYI6AwRdQbbGW9zKXwjXDyrPoHxKsTMr5
         zgGnrw8FdfdxcYohXzmEaG96J20mnsUfdOPWA=
Received: by 10.229.181.205 with SMTP id bz13mr2266286qcb.137.1286561198679;
        Fri, 08 Oct 2010 11:06:38 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id s34sm1708113qcp.8.2010.10.08.11.06.37
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 11:06:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87bp74tvno.fsf@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158519>

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Strictly speaking, --diff-filter=3D (with empty argument) is allowed=
, too,
>> but I don't know if it's worth fitting that in.
>
> If it provides some kind of useful behaviour (I don't know and you
> didn't clarify that either), then it should be documented I guess?

Just a special case of the usual behavior: it selects the empty set of
files.  Doesn't sound useful to me, but maybe someone writing a
front-end would want to be reassured that --diff-filter will still
work if the user unchecks all the boxes.

Of course, one can also just try it...

If you can find a way to format it nicely (using brackets?), then I
think it should be part of the documented syntax, yes.
