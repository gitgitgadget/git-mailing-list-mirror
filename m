From: greened@obbligato.org (David A. Greene)
Subject: Re: [PATCH 1/2] Allow Overriding GIT_BUILD_DIR
Date: Tue, 06 Mar 2012 08:21:39 -0600
Message-ID: <87r4x5izd8.fsf@smith.obbligato.org>
References: <1330903437-31386-1-git-send-email-greened@obbligato.org>
	<7vaa3v4kwo.fsf@alter.siamese.dyndns.org>
	<nng399m3om6.fsf@transit.us.cray.com>
	<7vaa3u24lw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dag@cray.com (David A. Greene), git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 15:24:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4vJp-0003uf-2w
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 15:24:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030698Ab2CFOYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 09:24:43 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:55444 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965183Ab2CFOYm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 09:24:42 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=smith.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1S4vL4-0000S2-PC; Tue, 06 Mar 2012 08:26:07 -0600
In-Reply-To: <7vaa3u24lw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 05 Mar 2012 12:08:11 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Junio C Hamano <gitster@pobox.com> writes: >> Right. This
   is because you flagged an indentation issue with the >> previous version of
    the patch. I think what happened is that the >> previous version included
    the 1-HT (what is HT - half-tab?) spacing but >> it "looked funny" with the
    additional "+" from the diff line. > > No, with your earlier patch, all the
    existing lines used horizontal > tabs for indenting, and the line you added
    used runs of spaces. > When such a hunk is shown in diff output, "+" will
    make it obv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192350>

Junio C Hamano <gitster@pobox.com> writes:

>> Right.  This is because you flagged an indentation issue with the
>> previous version of the patch.  I think what happened is that the
>> previous version included the 1-HT (what is HT - half-tab?) spacing but
>> it "looked funny" with the additional "+" from the diff line.
>
> No, with your earlier patch, all the existing lines used horizontal
> tabs for indenting, and the line you added used runs of spaces.
> When such a hunk is shown in diff output, "+" will make it obvious
> that only the new line you added is wrong (because the initial "+"
> and " " is absorbed in the first horizontal tab for Tab-indented
> lines) and that is how I noticed and pointed out "a funny
> indentation" to you.

Hmm...when I went back to the file it indeed had horizontal tabs.  Ah, I
think I know what happened.  I had to cut-n-paste into an e-mail because
I couldn't get git send-email to work at the time (it apparently gives
up after failing to authenticate even if the server presents more than
one authentication method).  So I think the mailer might have replaced
tabs with spaces.  I don't know.  In any case, it's moot.

You indicated you'd fix up the patch.  I am happy to do that as well if
you want a proper re-submission.  Just let me know.

                                    -Dave
