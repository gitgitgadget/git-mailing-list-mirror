From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv4 00/02] Simplify handling of gitweb dependencies and targets in main Makefile
Date: Sat,  7 May 2011 14:45:19 +0200
Message-ID: <1304772321-22687-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 14:46:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIgti-0008NH-SM
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 14:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754537Ab1EGMpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 08:45:54 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53133 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807Ab1EGMpx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2011 08:45:53 -0400
Received: by fxm17 with SMTP id 17so2840923fxm.19
        for <git@vger.kernel.org>; Sat, 07 May 2011 05:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=g4Y0+wBoehc9lQvQInKKKxbC6nMynL+loXIQNC0TM10=;
        b=XtC4EAuSuTkXR99Sfs00SuwCtBLHm10MPXoRv4wIQtcV5YCMqQMMpmbd60HLWGtEe7
         u4ImrBKQngsOmq8zqGsXwDdLYYfweFNr1fk1xVNw7Hsy4hWewe1dUBPwjjkpJoLSs5W7
         /Pezm8vP+Q9QL4phpIDxsbRL0wp3B/NpSmbtU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=t6E4qHHF4+TlDP0zh9p42p6ke1YtN09BDAryvGWH5qktPqKNKEQ5NqxMaEoOIRjt19
         uz63QmuX6xKSCs8N+B8+qUpAQoE57oGguXRujaezjIbk2YZeIotj3KRkZZV3JaWOpJc3
         ofeB8zT+6iRciSofZdxA656uzs04db6i2TQio=
Received: by 10.223.94.129 with SMTP id z1mr479370fam.144.1304772351923;
        Sat, 07 May 2011 05:45:51 -0700 (PDT)
Received: from localhost.localdomain (abwd142.neoplus.adsl.tpnet.pl [83.8.227.142])
        by mx.google.com with ESMTPS id j11sm1375094faa.20.2011.05.07.05.45.49
        (version=SSLv3 cipher=OTHER);
        Sat, 07 May 2011 05:45:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.189.gcec93
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173048>

On Thu, 5 May 2011, Junio C Hamano wrote in:
"Re: What's cooking in git.git (May 2011, #02; Wed, 4)"
http://article.gmane.org/gmane.comp.version-control.git/172842

> Jakub Narebski <jnareb@gmail.com> writes:
>>>
>>> Rerolled.  Waiting for comments.
>>
>> Should I extract first two commits i.e.
>>
>>    - Remove gitweb/gitweb.cgi and other legacy targets from main Makefile
>>    - git-instaweb: Simplify build dependency on gitweb
>>
>> into a separate patch series?  Even though their existence was
>> ...
>> I think this cleanup is worthy on its own.
> 
> Sounds like a good idea.  Thanks.

And here it is.  I'm sorry for the delay.

Shortlog:
~~~~~~~~~
Jakub Narebski (2):
  git-instaweb: Simplify build dependency on gitweb
  Remove gitweb/gitweb.cgi and other legacy targets from main Makefile

Diffstat:
~~~~~~~~~
 Makefile |   28 +---------------------------
 1 files changed, 1 insertions(+), 27 deletions(-)

-- 
1.7.5
