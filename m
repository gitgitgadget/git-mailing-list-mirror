From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Git sideband hook output
Date: Fri, 11 Jun 2010 17:55:28 -0400
Message-ID: <4C12B0D0.9000805@gmail.com>
References: <AANLkTinLWDFTn7bhcF3Vk-q9aw4lJC2vFj95M9bxLbBT@mail.gmail.com>	<20100608214632.GN14847@spearce.org>	<A612847CFE53224C91B23E3A5B48BAC744839BF3DD@xmail3.se.axis.com>	<alpine.LFD.2.00.1006090934320.30664@xanadu.home>	<A612847CFE53224C91B23E3A5B48BAC744839BF6AE@xmail3.se.axis.com>	<20100610183019.GR14847@spearce.org> <AANLkTikONJoDiyxmcmdG8zZkTCLbqXlXhrASae7rAreN@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 11 23:55:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONCCO-0007g7-U0
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 23:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760559Ab0FKVzc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jun 2010 17:55:32 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50521 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759554Ab0FKVzb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 17:55:31 -0400
Received: by gye5 with SMTP id 5so1127995gye.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 14:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=oTmgJ4fUeZ+tHH8hzHKSCNDJ7JimEcLHf0pAeIQMwqM=;
        b=BKurTbq693J2Mz6YjBD9Dv5ZvCjp29XGasPGIcsTgboU0klibbWopfP8ERZ6Y6hU7A
         FaYu51GTvJWvoXAag/y9HXCzwvXtsVM7I4zBfJgy6HWOZCUTJ508Sw9UMEjxIAnSrWxj
         350QtnUVQt5YbJ+YucSdncqSkzofa0Ii3OzgM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=PfASuDUEB5EqWpNHRald+/tFzyPdDr5JhkocTb2N4j9Dxzyz3fnJ0kUq+XX7wA/yEZ
         MD7nRp5dZvJU8RXNMOjW6/FVARzBciQCKCAS+fY1YCBP0+UuG8AYv2jqpLSpFA1ClMQA
         XIrxBa7FP5op3LBXqXbMdEpHHwJgINbIU+KcQ=
Received: by 10.150.131.9 with SMTP id e9mr4025643ybd.15.1276293330829;
        Fri, 11 Jun 2010 14:55:30 -0700 (PDT)
Received: from [10.0.0.6] (c-24-129-111-166.hsd1.fl.comcast.net [24.129.111.166])
        by mx.google.com with ESMTPS id v21sm13009821ybk.25.2010.06.11.14.55.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Jun 2010 14:55:30 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <AANLkTikONJoDiyxmcmdG8zZkTCLbqXlXhrASae7rAreN@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148973>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Thu, Jun 10, 2010 at 18:30, Shawn O. Pearce <spearce@spearce.org> =
wrote:
>> Peter Kjellerstedt <peter.kjellerstedt@axis.com> wrote:
>>> And what if my hook output is localized? Now there is an English
>>> "remote:" in front of every line... Or even worse, what if the
>>> "remote:" string is localized in a future version of git, then I
>>> have no way of knowing how wide it is and cannot take measures to
>>> format my hook output so that it will look right.
>> Don't localize "remote:"?  Or pick a shorter translation?
>>
>> If its really a problem, maybe "remote: " prefix should turn into
>> something shorter and language agnostic, like "<< ".  But thus far
>> we hadn't had to worry about it, since we didn't have translation
>> support in Git...  (though yes, I see that is changing now).
>=20
> Is there any reason for why the "remote:" output needs to be echoed
> verbatim to the user instead of being passed through some filter.
>=20
> If not, then it could be treated as part of a protocol, parsed, and
> localized however the user wants.
>=20
> ">" isn't as language-agnostic as you might think, in a RTL language
> the arrow ends up facing the wrong way.

Also seconded.
