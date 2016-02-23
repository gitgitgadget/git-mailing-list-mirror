From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 0/5] activate diff.renames by default
Date: Tue, 23 Feb 2016 21:46:07 +0100
Message-ID: <vpqsi0jf94g.fsf@anie.imag.fr>
References: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqa8mr1bk7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 21:46:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYJqm-00057j-2Q
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 21:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755387AbcBWUqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 15:46:23 -0500
Received: from mx2.imag.fr ([129.88.30.17]:50175 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755151AbcBWUqV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 15:46:21 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NKk4bm004126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 23 Feb 2016 21:46:04 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NKk7vf014765;
	Tue, 23 Feb 2016 21:46:07 +0100
In-Reply-To: <xmqqa8mr1bk7.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 23 Feb 2016 11:17:12 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 23 Feb 2016 21:46:04 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1NKk4bm004126
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1456865168.78326@QC0ue8Aq2+ASi/HbwA5KHA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287113>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> I have always wondered why diff.renames was not activated by default.
>> I've had it to true in my configuration for 9 years, and I've been
>> teaching newbies to set it for a while without issue. I think it's
>> time to activate it by default, but please let me know if I missed a
>> reason to keep it to false.
>>
>> In any case, the first 3 patches are useful cleanups.
>
> It's a long time coming since I heard "I love how I can just say
> 'oh, keep in mind that we might want to..' and 24 hours later you
> did it." [*1*]
>
> I can hardly be an impartial judge for this series, though.
>
> [Reference]
>
> *1* http://thread.gmane.org/gmane.comp.version-control.git/3541/focus=3702

I guess there's another reference needed to fully understand your
message, and I'm not sure I have it right. Are you refering to the
"merge-recursive: test rename threshold option" discussion?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
