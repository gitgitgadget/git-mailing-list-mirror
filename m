From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't add To: recipients to the Cc: header
Date: Tue, 20 Nov 2007 11:04:47 -0800
Message-ID: <7v8x4slovk.fsf@gitster.siamese.dyndns.org>
References: <1195470026-7389-1-git-send-email-ask@develooper.com>
	<7vr6ill5f1.fsf@gitster.siamese.dyndns.org>
	<7A3DDFA5-085D-4D92-BE96-A405FF1FB029@develooper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ask =?utf-8?Q?Bj=C3=B8rn?= Hansen <ask@develooper.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 20:05:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuYPs-0000OI-7w
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 20:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762445AbXKTTE5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Nov 2007 14:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762082AbXKTTE4
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 14:04:56 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:58948 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762446AbXKTTEz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Nov 2007 14:04:55 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id AD9FB2FA;
	Tue, 20 Nov 2007 14:05:14 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 3994497DCA;
	Tue, 20 Nov 2007 14:05:12 -0500 (EST)
In-Reply-To: <7A3DDFA5-085D-4D92-BE96-A405FF1FB029@develooper.com> (Ask
 =?utf-8?Q?Bj=C3=B8rn?=
	Hansen's message of "Tue, 20 Nov 2007 01:36:20 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65568>

Ask Bj=C3=B8rn Hansen <ask@develooper.com> writes:

> On Nov 19, 2007, at 23:52, Junio C Hamano wrote:
>
>> How did you prepare and send this patch?
>
> git format-patch + tweak in emacs.
>
>> I see 7 preimage lines and 11 postimage lines, although the hunk
>> header claims otherwise.
>>
>> Did you edit the patch in Emacs diff mode or something?
>
> Indeed!  I take it you've seen that particular way of botching it
> before.  :-)

Yes and a heavy advocate of Emacs on this list wanted to get a
breakage example out of me which I forgot to supply but now we
have it.  Unfortunately I do not offhand recall who it was.

> When I was about to send the patch I realized I had added whitespace
> at the end of one of the lines.  Ironically then I ended up just
> sending the messed up patch because I couldn't apply it to my working
> copy after doing a reset.  Being a new git user I convinced myself
> that I had messed up the reset rather than the patch.  Doh.  My
> apologies!   A new patch should be on the list momentarily.

Oops, forgot to say "no need to resend".  I asked only because I
wanted an independent datapoint for Emacs diff mode breakage.
