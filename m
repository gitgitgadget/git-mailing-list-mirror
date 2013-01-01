From: greened@obbligato.org
Subject: Re: [PATCH 6/8] Make the Manual Directory if Needed
Date: Tue, 01 Jan 2013 16:37:35 -0600
Message-ID: <87bod8fs28.fsf@waller.obbligato.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
	<1357012655-24974-7-git-send-email-greened@obbligato.org>
	<7vobh88tp3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Jesper L. Nielsen" <lyager@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 23:38:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqATe-0002gR-JE
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 23:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301Ab3AAWiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 17:38:11 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48614 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752291Ab3AAWiL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 17:38:11 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1TqAaS-0001Gz-Mk; Tue, 01 Jan 2013 16:45:33 -0600
In-Reply-To: <7vobh88tp3.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 01 Jan 2013 13:44:08 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Junio C Hamano <gitster@pobox.com> writes: >> diff --git a/contrib/subtree/Makefile
    b/contrib/subtree/Makefile >> index 36ae3e4..52d6fb9 100644 >> --- a/contrib/subtree/Makefile
    >> +++ b/contrib/subtree/Makefile >> @@ -35,6 +35,7 @@ install: $(GIT_SUBTREE)
    >> install-doc: install-man >> >> install-man: $(GIT_SUBTREE_DOC) >> + mkdir
    -p $(man1dir) > > We seem to use "$(INSTALL) -d -m 755" for this kind of
   thing (see > the Documentation/Makefile). [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name  
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212468>

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
>> index 36ae3e4..52d6fb9 100644
>> --- a/contrib/subtree/Makefile
>> +++ b/contrib/subtree/Makefile
>> @@ -35,6 +35,7 @@ install: $(GIT_SUBTREE)
>>  install-doc: install-man
>>  
>>  install-man: $(GIT_SUBTREE_DOC)
>> +	mkdir -p $(man1dir)
>
> We seem to use "$(INSTALL) -d -m 755" for this kind of thing (see
> the Documentation/Makefile).

Ok, will fix.

                             -Dave
