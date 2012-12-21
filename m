From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: recommendation for patch maintenance
Date: Fri, 21 Dec 2012 18:29:37 +0100
Message-ID: <50D49C81.5060007@gmail.com>
References: <50D475EF.6060303@gmail.com> <7vvcbv1grr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 18:38:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm6YI-0008Mh-2L
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 18:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573Ab2LURiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 12:38:12 -0500
Received: from mail-wg0-f46.google.com ([74.125.82.46]:39095 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab2LURiL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 12:38:11 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so2173831wgb.1
        for <git@vger.kernel.org>; Fri, 21 Dec 2012 09:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=AzUfXmAPvKm0ZEFVxgUpkfCr00qb/9bbWAgq1FP5ayM=;
        b=tng8SPk5UxL31Sg4ZIJLU6s7zZNRq0qmiBtUMwoQF4dP/C6lMmzwCIj3khhShf5ZbA
         46BF8nXw7loZUFGLj70kWREhpluMzjJ1liEtj5RP1DTcCFILFIZGR7I+V89sqirirwlW
         3mK0yHqoYcCxT5ZKhQ1Mo/LHNCYL5tdSVN2Inp3STFIlnnR1bkmm2LYGZuNBNpYYc0oD
         Pu/14HDAAD5peze7gToOa3pZS1Z//dAR73NIMxMqaJtVO0LWz3wnkAGjHcCUjOHynB+o
         Ib6LbVjhUOVNsOZM5BFEao+eXFF4KoVlMOLnze1NWWNllCBfqtTbNMppaBEM5Mi8bn7j
         fbPQ==
X-Received: by 10.194.173.195 with SMTP id bm3mr24860417wjc.32.1356110989224;
        Fri, 21 Dec 2012 09:29:49 -0800 (PST)
Received: from [192.168.0.3] ([151.70.200.164])
        by mx.google.com with ESMTPS id dw4sm19263553wib.1.2012.12.21.09.29.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Dec 2012 09:29:48 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <7vvcbv1grr.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211990>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 21/12/2012 18:01, Junio C Hamano ha scritto:
> Manlio Perillo <manlio.perillo@gmail.com> writes:
> 
>> I would like to have advices about some possible workflows to use when
>> maintaining a patch, that can evolve over the time (fixing bugs, and
>> applying advices from reviewers).
>>
> [...]
>> when I need to update the patch:
>>
>>   1) modify code
>>   2) commit --amend
>>   3) format-patch --subject-prefix="PATCH v<n>" \
>>      --output=mp/complete-patch master
>>   4) edit patch to add a list of what was changed
>>   5) review the patch
>>   6) send-email
>>
>> This is far from ideal, since all my local changes are lost.
> 
> Not offering any answer, but it is unclear to me what local changes
> you are losing here.  Care to explain?

I lose the history of all the changes I have made to produce the final
version of a patch.

Since for every new version of a patch I do a commit --amend, I can not
see, as an example, the changes I have made between x and y versions of
a patch.

Of course the commits are not really lost, but I have to search them
using the reflog.


Thanks   Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDUnIAACgkQscQJ24LbaUTf0QCfX9WtA+/GLzVWDJFPbLMCPucJ
bKQAnj0HJuQs9SVCPV/TlDXcpGDqIqfD
=lhZ5
-----END PGP SIGNATURE-----
