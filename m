From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2011, #02; Mon, 5)
Date: Thu, 8 Dec 2011 20:44:15 +0100
Message-ID: <CABPQNSYQ=nt9LYzXpQgfwV00e9AxOV3LKj6VCCO8xkMAXb-Lfg@mail.gmail.com>
References: <7v8vmqi98f.fsf@alter.siamese.dyndns.org> <20111206055239.GA20671@sigill.intra.peff.net>
 <CABPQNSbOReM71HaPmce3v_98NDu17fT3YnySR4pWzJEDa-RKnA@mail.gmail.com> <20111206185218.GB9492@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>, Stephan Beyer <s-beyer@gmx.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 08 20:45:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYjtt-0006Oj-TK
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 20:45:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383Ab1LHTo5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Dec 2011 14:44:57 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57970 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883Ab1LHTo4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Dec 2011 14:44:56 -0500
Received: by dadv6 with SMTP id v6so1931154dad.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 11:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=AQZG/fIxQ49Ub4zTt590XumUGhopac8LSlD0jLTXLWU=;
        b=V82S+/3TM1Tu8tQSzBCXhACS1dmvBH3vt4PPZet41sQx8ny5GqPhNLCNPFSRzTg7NX
         aPH2WHlFLxjlnHd2SKaydPVb/7GJfpEOB0yQQEwoy88xvfzywINnKhkLEVaJAK/djauB
         pcPPdlEyPqN7gsjpysLZJO+wg8TQ2MPQJm4YY=
Received: by 10.68.74.5 with SMTP id p5mr18029384pbv.56.1323373496259; Thu, 08
 Dec 2011 11:44:56 -0800 (PST)
Received: by 10.68.21.39 with HTTP; Thu, 8 Dec 2011 11:44:15 -0800 (PST)
In-Reply-To: <20111206185218.GB9492@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186589>

On Tue, Dec 6, 2011 at 7:52 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Dec 06, 2011 at 12:22:06PM +0100, Erik Faye-Lund wrote:
>
>> >> * jk/upload-archive-use-start-command (2011-11-21) 1 commit
>> >> =A0- upload-archive: use start_command instead of fork
>> >>
>> >> What's the status of this one?
>> >
>> > I think what you have in pu is good, but of course I didn't actual=
ly
>> > test it on Windows. Erik?
>> >
>>
>> I tried to check out ee27ca4 and build, and got hit by a wall of war=
nings:
>
> I think you are on the wrong topic. ee27ca4 is the maint topic for
> "don't let remote clients get unreachable commits", and is based on t=
he
> ancient 1.6.2. Which is why you are getting all of those warnings.
>

You are indeed right. Thanks for spotting :)

> The topic in question is jk/upload-archive-use-start-command, which i=
s
> at 1bc01ef, and should be based on recent-ish master.

t5000-tar-tree pass for that one as well. No warnings this time :P
