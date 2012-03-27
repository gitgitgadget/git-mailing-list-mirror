From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC] "Remote helper for Subversion" project
Date: Tue, 27 Mar 2012 09:28:52 +0530
Message-ID: <CALkWK0mMHjYpmxckanoPbqD=TrKR-i+7SjBEf2-8cV0kvPx0qA@mail.gmail.com>
References: <1330777646-28381-1-git-send-email-davidbarr@google.com>
 <CAFfmPPMPDCKjAmZ85Cj1cdT2yAUykm9sV6a66zXeFRmYfrmtjg@mail.gmail.com> <20120304075424.GI14725@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Barr <davidbarr@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 05:59:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCNZU-0008Cz-PT
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 05:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843Ab2C0D7O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Mar 2012 23:59:14 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:46122 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809Ab2C0D7O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2012 23:59:14 -0400
Received: by wgbdr13 with SMTP id dr13so4454552wgb.1
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 20:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=GSBiYFRw4L2cwvWwbMhKzLs/HoXfpsI8Sk2L3Km3w7E=;
        b=PVfAEDTLs07dbiIeGoaQ6uUkwtJutvgIcuBv+xivWDZx1TUeo96Ch4jGth5wJworvh
         AdcAfdGm7wchsowpDeCc0KhlC60buv3Cm4HlB0bBGJpbWuTLjdPdoCAmdM/IjDdt2Eub
         Fjkch2DqA0/GEx5wiMA8QlSYFf2soSnSnLu4AxgtaYwY882xYSPgxtmSpEEjkvrhRRyy
         TpJ8EFwKna7WJT+b0XoFtJluJ57LcHS+cMQPLDyWf0ZMH/84wVxUfsAsLrREEvkK2fxn
         j0A9flqwxeMt6Q/ZyaZUC3UsD2HzunNi7+o8WhNMQ+kyL0eWpmo6aaTBHRYRl0At9oT5
         Qg0w==
Received: by 10.180.97.41 with SMTP id dx9mr23779283wib.9.1332820752743; Mon,
 26 Mar 2012 20:59:12 -0700 (PDT)
Received: by 10.216.11.199 with HTTP; Mon, 26 Mar 2012 20:58:52 -0700 (PDT)
In-Reply-To: <20120304075424.GI14725@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194002>

Hi,

Jonathan Nieder wrote:
> David Barr wrote:
>> On Sat, Mar 3, 2012 at 11:27 PM, David Barr <davidbarr@google.com> w=
rote:
>>> +
>>> +* Getting an Git-to-SVN converter merged.
>
> Probably could fill a summer in itself. =C2=A0In previous starts I th=
ink
> there was some complexity creep. :/
>
> =C2=A0http://thread.gmane.org/gmane.comp.version-control.git/170290
> =C2=A0http://thread.gmane.org/gmane.comp.version-control.git/170551

I've been meaning to finish this off for sometime now- probably as an
SoC project this summer?

>>> +
>>> +* Building the remote helper itself.
>>> +
>>> +Goal: Build a full-featured bi-directional `git-remote-svn` and ge=
t it
>>> + =C2=A0 =C2=A0 =C2=A0merged into upstream Git.
>
> Sure would be neat. ;-) =C2=A0Another nice piece to build would be br=
anch
> tracking / follow_parent heuristics.

This doesn't sound awfully complicated; if the Git -> SVN converter
gets merged early on, I might get a chance to work on this as well.

    Ram
