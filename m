From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Commit ID in exported Tar Ball
Date: Sat, 19 May 2007 17:39:40 -0400
Message-ID: <464F6E9C.4070506@gmail.com>
References: <20070517163803.GE4095@cip.informatik.uni-erlangen.de>	<200705171857.22891.johan@herland.net>	<20070517171150.GL5272@planck.djpig.de>	<464F5CA2.3070809@lsrfire.ath.cx> <7vd50wv88t.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Thomas Glanzmann <thomas@glanzmann.de>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 19 23:39:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpWeZ-0000Jo-Gs
	for gcvg-git@gmane.org; Sat, 19 May 2007 23:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755568AbXESVjq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 19 May 2007 17:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755791AbXESVjq
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 17:39:46 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:36865 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755327AbXESVjp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 17:39:45 -0400
Received: by an-out-0708.google.com with SMTP id d18so299274and
        for <git@vger.kernel.org>; Sat, 19 May 2007 14:39:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=DlZ9E4mI4e/z+J8gR8dam4e9iHJoc77h9+ZgDntbpFjVvWpVgr6zmQSTjU9h7rjgcfpskT3WWGOxjUMc4LltdOkRgk2x4xYKF+p07cLrFfLi0OJoV0HJXdEhiGpvxlR6gKXxgFgsMQyVSg81DivvNmbdXK9Wn4jA0mdjDmOh26g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=C0d1bQNmPUZva/4Q+bWl6HxMwen6SQWW8vIT4hGFsqNJWvTRr0/ECjWAu0hom/1BsVT7gJvvbZXN+EYcBl/26EtSXdZWAwi+N2rWqOu6oKgWhLrOTO9F1oW14yc5WGlkflyiVfVO04e62hJfvJshvWa7bYo9nnO5Hw87r9mhZWQ=
Received: by 10.100.242.11 with SMTP id p11mr2023352anh.1179610785146;
        Sat, 19 May 2007 14:39:45 -0700 (PDT)
Received: from ?192.168.1.3? ( [70.119.124.217])
        by mx.google.com with ESMTP id b29sm9773868ana.2007.05.19.14.39.43;
        Sat, 19 May 2007 14:39:44 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <7vd50wv88t.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47777>

Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> Something like the following patch?  Since we're already embedding t=
he
>> commit ID in a comment, we might as well offer creating a synthetic =
file
>> for it, too, if that solves a user's problem that might be difficult=
 to
>> work around otherwise.
>=20
> Are you detecting and erroring out if the named file already
> exists in the tree being archived?
>=20
> Should we?  Maybe we should just replace with warning?
>=20
> Also should we silently ignore the request if the tree-ish is
> not a commit-ish, or error out?

Silently ignoring conflicting command arguments is (almost always) a=20
bug; either in the implementation or the design.
