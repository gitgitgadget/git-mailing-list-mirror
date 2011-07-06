From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC PATCH 14/14] revert: Change insn sheet format
Date: Wed, 6 Jul 2011 16:19:14 +0530
Message-ID: <CALkWK0nThSNg5Os4b1=S=9h38jDB7X77wM8j=1Jr4FvpRbJtZw@mail.gmail.com>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-15-git-send-email-artagnon@gmail.com> <20110706103321.GK15682@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 12:51:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QePhE-0002YG-DO
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 12:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512Ab1GFKtg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jul 2011 06:49:36 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41529 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955Ab1GFKtf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2011 06:49:35 -0400
Received: by wyg8 with SMTP id 8so4574222wyg.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 03:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=K4wH1MfRTYKh9d3j5ntuMPnZmvC3/Oc45tQUJyscfjA=;
        b=TJPXeLgF1xs9ZOXMIaBpfO0Nus66zvjUPvCYjqlbK1/IbbmlXF1Z+rSNdASd9EfoYP
         4weuEzwIOsmJThJhkuWmo/PjcbknUeZadqzY5en5Vt2s0UrcWOXa1O+y/X8oeLFRzrkd
         96Notgs8FaWG3iZSCwTco8tJzJTPErHCTZZu4=
Received: by 10.216.50.2 with SMTP id y2mr6894371web.77.1309949374083; Wed, 06
 Jul 2011 03:49:34 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Wed, 6 Jul 2011 03:49:14 -0700 (PDT)
In-Reply-To: <20110706103321.GK15682@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176685>

Hi again,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> =C2=A0I've intentionally left parse_cmdline_args unimplemented
> [...]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Existi=
ng implementations in libraries like Glib are
>> =C2=A0much too heavyweight.
>
> Wait, how did glib enter the picture? :)

Completely unrelated -- I just incidentally saw "g_shell_parse_argv"
in glib which does what we want, but it's an overkill.

> The implementation of
> shell-style quoting in [1] is not very complicated; perhaps it could
> complement git's existing parsers for shell-style single-quoted
> expressions and C-style double-quoted expressions in quote.c.

Okay.

> Of course, a more basic question is whether we want to allow passing
> arbitrary command-line arguments through the insn sheet at all (a
> part of me wishes "no", at least at first).

I have an overwhelming desire to say "no", but I can't think of an alte=
rnative.

> Could you give an example to illustrate what this functionality would
> be used for? =C2=A0I can understand wanting to pass "-s" and "-X" fla=
gs to
> a merge insn and "-X" to pick, but that's as far as my imagination
> goes.

I wasn't imagining anything else.  That's just it -- I've just been
breaking my head trying to figure out how to do it :|

-- Ram
