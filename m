From: greened@obbligato.org
Subject: Re: [PATCH 2/8] Add --unannotate
Date: Tue, 01 Jan 2013 16:31:44 -0600
Message-ID: <87sj6kfsbz.fsf@waller.obbligato.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
	<1357012655-24974-3-git-send-email-greened@obbligato.org>
	<7v623ga8vs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, James Nylen <jnylen@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 23:32:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqANz-0008TC-Vx
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 23:32:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308Ab3AAWcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 17:32:22 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48597 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751252Ab3AAWcV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 17:32:21 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1TqAUo-0001Fu-68; Tue, 01 Jan 2013 16:39:42 -0600
In-Reply-To: <7v623ga8vs.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 01 Jan 2013 13:30:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Junio C Hamano <gitster@pobox.com> writes: > "David A. Greene"
    <greened@obbligato.org> writes: > >> From: James Nylen <jnylen@gmail.com>
    >> >> Teach git-subtree about --unannotate. This option strips a prefix >>
    from a commit message when doing a subtree split. > > Hrm. This looks like
    a workaround for a short-sighted misdesign of > the annotate option that
   only allowed prefixing a fixed string. I > have to wonder if it is better
   to deprecate --annotate and replace > it with a more general "commit log rewriting"
    faci 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212464>

Junio C Hamano <gitster@pobox.com> writes:

> "David A. Greene" <greened@obbligato.org> writes:
>
>> From: James Nylen <jnylen@gmail.com>
>>
>> Teach git-subtree about --unannotate.  This option strips a prefix
>> from a commit message when doing a subtree split.
>
> Hrm.  This looks like a workaround for a short-sighted misdesign of
> the annotate option that only allowed prefixing a fixed string.  I
> have to wonder if it is better to deprecate --annotate and replace
> it with a more general "commit log rewriting" facility that can
> cover both use cases?

That's not a bad idea.  I'd have to think a bit about a sensible design.
Do you have any ideas, James?

In the meantime, will you apply the patch or do you prefer a new design?

                      -David
