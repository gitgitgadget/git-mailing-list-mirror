From: greened@obbligato.org
Subject: Re: [PATCH 4/8] Fix Synopsis
Date: Tue, 01 Jan 2013 16:35:05 -0600
Message-ID: <87k3rwfs6e.fsf@waller.obbligato.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
	<1357012655-24974-5-git-send-email-greened@obbligato.org>
	<7vwqvw8tur.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 23:36:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqARE-0001Zt-O1
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 23:36:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700Ab3AAWfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 17:35:42 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48605 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751533Ab3AAWfl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 17:35:41 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1TqAY2-0001GN-Hg; Tue, 01 Jan 2013 16:43:02 -0600
In-Reply-To: <7vwqvw8tur.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 01 Jan 2013 13:40:44 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Junio C Hamano <gitster@pobox.com> writes: >> -git subtree
    add --prefix=<prefix> <commit> >> +git subtree add --prefix=<prefix> <refspec>
    > > Again, this is not <refspec> but <commit>. Ok, I need to study the terminology.
    :) [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probabil 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212466>

Junio C Hamano <gitster@pobox.com> writes:

>> -git subtree add   --prefix=<prefix> <commit>
>> +git subtree add   --prefix=<prefix> <refspec>
>
> Again, this is not <refspec> but <commit>.

Ok, I need to study the terminology.  :)

>> +git subtree add   --prefix=<prefix> <repository> <refspec>
>
> This is given to "fetch" and it seems to acccept any <refspec>, so
> it is probably a good change (I didn't fully follow the codepath,
> though).

I think you are correct.

                          -David
