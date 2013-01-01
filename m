From: greened@obbligato.org
Subject: Re: [PATCH 1/8] Use %B for Split Subject/Body
Date: Tue, 01 Jan 2013 16:24:46 -0600
Message-ID: <877gnwh781.fsf@waller.obbligato.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
	<1357012655-24974-2-git-send-email-greened@obbligato.org>
	<7vtxr1bg4g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Techlive Zheng <techlivezheng@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 23:25:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqAHG-0005IR-EU
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 23:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502Ab3AAWZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 17:25:24 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48576 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752477Ab3AAWZX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 17:25:23 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1TqAO4-0001E3-KQ; Tue, 01 Jan 2013 16:32:45 -0600
In-Reply-To: <7vtxr1bg4g.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 31 Dec 2012 21:56:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Junio C Hamano <gitster@pobox.com> writes: > "David A. Greene"
    <greened@obbligato.org> writes: > >> From: Techlive Zheng <techlivezheng@gmail.com>
    >> >> Use %B to format the commit message and body to avoid an extra newline
    >> if a commit only has a subject line. > > Is this an unconditional improvement,
    or is it generally an > improvement but for some users it may be a regression?
    I am > guessing it is the former but am just making sure. [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name       
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212460>

Junio C Hamano <gitster@pobox.com> writes:

> "David A. Greene" <greened@obbligato.org> writes:
>
>> From: Techlive Zheng <techlivezheng@gmail.com>
>>
>> Use %B to format the commit message and body to avoid an extra newline
>> if a commit only has a subject line.
>
> Is this an unconditional improvement, or is it generally an
> improvement but for some users it may be a regression?  I am
> guessing it is the former but am just making sure.

The former.

>> Author:    Techlive Zheng <techlivezheng@gmail.com>
>>
>> Signed-off-by: David A. Greene <greened@obbligato.org>
>
> Please don't do "Author: " which does not add anything new.  That is
> what "From: " is for.  Instead it needs to be a sign-off.

Ok.  Unfortunately I sent a number of patches like that.  Do you want me
to re-send them?

> Also, is that a real name, I have to wonder?

No idea.  Not likely, I'd say.

                        -David
