From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: What's cooking extra
Date: Mon, 24 May 2010 14:22:13 +0200
Message-ID: <AANLkTil83LQrMiAtAQwgfCtI6jeBHHq-P3DyjrIjcNtz@mail.gmail.com>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org>
	 <20100519170656.GA30161@pvv.org> <20100522130916.GA28452@localhost>
	 <50199F1F-3513-43A6-8990-957F3D0AF58C@gmail.com>
	 <20100522222746.GA2694@localhost>
	 <CDD31343-2352-434B-B875-2013DAF49CE7@gmail.com>
	 <20100523115127.GA20443@localhost>
	 <20100524121224.GB3005@dpotapov.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clemens Buchacher <drizzd@aon.at>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 24 14:22:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGWfm-0007Jd-Sn
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 14:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757026Ab0EXMWQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 May 2010 08:22:16 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50316 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757021Ab0EXMWO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 May 2010 08:22:14 -0400
Received: by wyb29 with SMTP id 29so1442867wyb.19
        for <git@vger.kernel.org>; Mon, 24 May 2010 05:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=bMqOnApCe1H31WldIC4h6P88Pl03sdgGydpbmOcRer4=;
        b=TiFHVz35+vCm2twfqy5afwPE9IiG3Y66CSnw3rSUsH+H+jPn4u3VWsK/z+GbiT6h62
         VvLqmzjzOgytxSv8khqod/P9TIntuV4C86iIeu5OGwGfPf/PpZHRoYN1B0XCvHVtkvSN
         4wllZdTckQPZTthqYfT6K3J4OdUk+WX7R8efE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=rZXATj/LkJpeM634bp1OutwUCyM2p6QP9PVEHuTycyvhNzfD94MjWwpcY6GLgMbZWk
         DEVzWZMXxOYhGryB14oVYy36sjsUXR9qKgkIibL39jPQWITNiO9ikiY443BOdiJ83ejz
         nnGeYNnNgI+5jtM3K2w2c+gIa9dXSDV9DFhjc=
Received: by 10.216.184.136 with SMTP id s8mr2799093wem.102.1274703733120; 
	Mon, 24 May 2010 05:22:13 -0700 (PDT)
Received: by 10.216.21.73 with HTTP; Mon, 24 May 2010 05:22:13 -0700 (PDT)
In-Reply-To: <20100524121224.GB3005@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147628>

On Mon, May 24, 2010 at 2:12 PM, Dmitry Potapov <dpotapov@gmail.com> wr=
ote:
> On Sun, May 23, 2010 at 01:51:27PM +0200, Clemens Buchacher wrote:
>> On Sun, May 23, 2010 at 12:36:51PM +0200, Eyvind Bernhardsen wrote:
>> >
>> > Actually, since git normalizes to LF, "eol=3Dlf" simply means
>> > "convert on input but not on output", which is what
>> > "core.autocrlf=3Dinput" currently does. =A0The fact that you didn'=
t
>> > know this reflects the poor usability of core.autocrlf, which is
>> > one of the things this series is trying to rectify :)
>>
>> No, I am aware of autocrlf=3Dinput, but apparently I did not
>> understand the meaning of eol=3Dlf correctly. So if a file has CRLF
>> endings in the repository, and eol=3Dlf, it will _not_ be converted
>> to LF in the work tree? Conversely, if it has LF endings in the
>> repository, and eol=3Dcrlf, it _will_ be converted to CRLF in the
>> work tree?
>
> All text files should LF in the repository, if some file does not, it
> means the repository is corrupted in respect of handling text files.
> So, the situation is not symmetric at all! I don't know how better to
> handle this "corruption". I guess, it should be a warning about some
> files having different ending that it should have had based on their
> attributes.
>

I thought the original motivation behind this change was to make repos
with CRLF-textfiles work without reporting diffs on all lines when
autocrlf was enabled. Because checking in CRLF-files DOES happen, and
for some of us the reality is that we have to deal with such repos.

Perhaps I'm confusing this discussion with some other, though.

--=20
Erik "kusma" Faye-Lund
