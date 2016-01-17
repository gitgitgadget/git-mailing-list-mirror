From: greened@obbligato.org (David A. Greene)
Subject: Re: [PATCH] contrib/subtree: Remove --annotate
Date: Sun, 17 Jan 2016 17:30:14 -0600
Message-ID: <87oacjaint.fsf@waller.obbligato.org>
References: <1451963101-4901-1-git-send-email-greened@obbligato.org>
	<1451963101-4901-2-git-send-email-greened@obbligato.org>
	<xmqqsi2cj5hu.fsf@gitster.mtv.corp.google.com>
	<87oaczwvz8.fsf@waller.obbligato.org>
	<xmqqbn8mish5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, techlivezheng@gmail.com,
	alex.crezoff@gmail.com, davvid@gmail.com, cbailey32@bloomberg.net,
	danny0838@gmail.com, prohaska@zib.de, th.acker@arcor.de,
	sschuberth@gmail.com, peff@peff.net, gitter.spiros@gmail.com,
	nod.helm@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 00:31:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKwmk-0006QQ-HL
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 00:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907AbcAQXa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2016 18:30:27 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:33003 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752804AbcAQXaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2016 18:30:25 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aKwnT-0003fR-HB; Sun, 17 Jan 2016 17:31:48 -0600
In-Reply-To: <xmqqbn8mish5.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 15 Jan 2016 10:54:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Junio C Hamano <gitster@pobox.com> writes: > greened@obbligato.org
    (David A. Greene) writes: > >> If you really don't want to get rid of this,
    I guess that's ok but my >> preference as maintainer is to reduce the feature
    set to those things >> people seem to actually regularly use (according to
    my very unscientific >> Google searches) and add features as requested/evaluated.
    --annotate >> isn't a huge maintenance burdern but some of those other changes
    I >> mentioned do in fact significantly reduce the maintenance burden of
   >> git-subtree. 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284273>

Junio C Hamano <gitster@pobox.com> writes:

> greened@obbligato.org (David A. Greene) writes:
>
>> If you really don't want to get rid of this, I guess that's ok but my
>> preference as maintainer is to reduce the feature set to those things
>> people seem to actually regularly use (according to my very unscientific
>> Google searches) and add features as requested/evaluated.  --annotate
>> isn't a huge maintenance burdern but some of those other changes I
>> mentioned do in fact significantly reduce the maintenance burden of
>> git-subtree.  I hope I will have some leeway with those, even if they
>> change semantics slightly.
>
> OK.  It is easy enough to add back when people complains, so...
>
> ;-)

Thanks.

Just to clarify, what is the expectation of things in contrib?
Basically the same as other code?

                    -David
