From: Luben Tuikov <ltuikov-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Tue, 10 Jan 2006 19:32:29 -0800 (PST)
Message-ID: <20060111033229.5590.qmail@web31809.mail.mud.yahoo.com>
References: <252A408D-0B42-49F3-92BC-B80F94F19F40@mac.com>
Reply-To: ltuikov-/E1597aS9LQAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Luben Tuikov <ltuikov-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>,
	"Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Junio C Hamano <junkio-j9pdmedNgrk@public.gmane.org>,
	Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>,
	"David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>,
	linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	LKML Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>,
	Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
X-From: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org Wed Jan 11 04:32:36 2006
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Envelope-to: glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwWit-0001v8-Vt
	for glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org; Wed, 11 Jan 2006 04:32:32 +0100
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org via listexpand
	id S932627AbWAKDcb (ORCPT <rfc822;glad-acpi-devel@m.gmane.org>);
	Tue, 10 Jan 2006 22:32:31 -0500
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org id S932696AbWAKDcb
	(ORCPT <rfc822;linux-acpi-outgoing>);
	Tue, 10 Jan 2006 22:32:31 -0500
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:59033 "HELO
	web31809.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932627AbWAKDca (ORCPT <rfc822;linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>);
	Tue, 10 Jan 2006 22:32:30 -0500
Received: (qmail 5592 invoked by uid 60001); 11 Jan 2006 03:32:29 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=jC8iY9r3N5siLAc0BpOtjcgyIbW4KKP5gR8gnAJkXo3tawdEz37wI+ORyqOSGqM1yWiSJeAeodug+zDXlBC7fpZnjoCVfIN9RB6yJVEH9hUqT9SbynFLxPDIYLAUrRWLG3DBf/ez4DdDnKlmAR/aQUW3IrIHSm9Tv5chw3jruTg=  ;
Received: from [69.134.142.183] by web31809.mail.mud.yahoo.com via HTTP; Tue, 10 Jan 2006 19:32:29 PST
To: Kyle Moffett <mrmacman_g4-ee4meeAH724@public.gmane.org>,
	Martin Langhoff <martin.langhoff-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <252A408D-0B42-49F3-92BC-B80F94F19F40-ee4meeAH724@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Precedence: bulk
X-Mailing-List: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--- Kyle Moffett <mrmacman_g4-ee4meeAH724@public.gmane.org> wrote:
> they're totally irrelevant.  This is why it's useful to only pull  
> mainline into your tree (EX: ACPI) when you functionally depend on  
> changes there (as Linus so eloquently expounded upon).

Sometimes the dependency is _behavioural_.  For example certain
behaviour of other modules of the kernel changed and you want
to test that your module works ok with them under different
behaviour.  In which case you may or may not have to
change your code after the fact.

    Luben

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
