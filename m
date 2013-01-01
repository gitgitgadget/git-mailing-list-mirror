From: greened@obbligato.org
Subject: Re: [PATCH] For git-subtree, when installing docs (make install-doc), create man1 folder first.
Date: Mon, 31 Dec 2012 21:01:20 -0600
Message-ID: <87623hy5bz.fsf@waller.obbligato.org>
References: <1355429376-4192-1-git-send-email-lyager@gmail.com>
	<7v8v91y97f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jesper L. Nielsen" <lyager@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 04:02:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tps7K-0003aq-SL
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 04:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496Ab3AADB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 22:01:56 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48290 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751324Ab3AADBz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 22:01:55 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1TpsE5-0005bR-P9; Mon, 31 Dec 2012 21:09:14 -0600
In-Reply-To: <7v8v91y97f.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 13 Dec 2012 12:43:16 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Junio C Hamano <gitster@pobox.com> writes: > "Jesper L. Nielsen"
    <lyager@gmail.com> writes: > >> From: "Jesper L. Nielsen" <lyager@gmail.com>
    >> >> Hi.. >> >> I installed Git subtree and discovered that the if the man1dir
    doesn't exist the man-page for Git Subtree is just called man1. >> >> So,
    small patch to create the folder first in the Makefile. Hope everything is
    right with the patch and submitting of the patch. >> >> Best Regards >> Jesper
    >> >> Signed-off-by: Jesper L. Nielsen <lyager@gmail.com> >> --- > > Thank 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212396>

Junio C Hamano <gitster@pobox.com> writes:

> "Jesper L. Nielsen" <lyager@gmail.com> writes:
>
>> From: "Jesper L. Nielsen" <lyager@gmail.com>
>>
>> Hi..
>>
>> I installed Git subtree and discovered that the if the man1dir doesn't exist the man-page for Git Subtree is just called man1.
>>
>> So, small patch to create the folder first in the Makefile. Hope everything is right with the patch and submitting of the patch.
>>
>> Best Regards
>> Jesper
>>
>> Signed-off-by: Jesper L. Nielsen <lyager@gmail.com>
>> ---
>
> Thanks.  David, Ack?

Yep.  I can add it to my queue which I'll send to you tomorrow.
Otherwise, feel free to apply it to your copy.

                               -David
