From: Christian Holtje <docwhat@gmail.com>
Subject: Re: [PATCH] pre-commit hook should ignore carriage returns at EOL
Date: Tue, 24 Jun 2008 20:19:17 -0400
Message-ID: <8EDBCDE3-1155-4C44-B3BF-FB7F16AC9AE8@gmail.com>
References: <53A5AFCF-94C7-465E-A181-1DA69F251F5B@gmail.com> <alpine.LFD.1.10.0806241418360.32759@sys-0.hiltweb.site> <39C2861E-F800-40AE-8C15-4FC3BB51EF16@gmail.com> <7v3an2bh3b.fsf@gitster.siamese.dyndns.org> <930163B6-4A7E-49C7-B9D5-F7B37699C2A9@gmail.com> <m3k5gejtkp.fsf@localhost.localdomain> <7vbq1q9zct.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 02:20:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBIkS-00065F-NE
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 02:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754433AbYFYATW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 20:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754825AbYFYATW
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 20:19:22 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:10568 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755892AbYFYATV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 20:19:21 -0400
Received: by an-out-0708.google.com with SMTP id d40so758461and.103
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 17:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=ReFY9iHaKlcUmD8VpaffkiQHJNV87QYFAii4XqpoAes=;
        b=acViKc4ouYp+LFCnbNSRLGSVd+nH8+bd9Ld0uwK9PIAtA9bBHJugy9hxxBBENT8yDD
         IihTSWl6VXXEYBbBaCWd3vVhHvVbq6W+UYSYTh6oOFMDcUZCiYW30hUWzTpJbmKzUmQR
         KGyfM+wFP8wHPUTIBok838BKkrz6sYKWiqM04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=ejyXsYejVnKgHxmCv0H+UOHXAIixCrFBQS2xxdxCK0wsr2rnj/JcT3Em3POj9LeJz0
         wwYY1UPJWzHf7hZ+WTwBEXUfu9kk50qxjJXcNu5TovybayIz+nj3WsVGiQHAbMsF9QlB
         RqHMRCrGRZm+YAYTBZRNaBPm6uqFdjn4/yarQ=
Received: by 10.100.228.17 with SMTP id a17mr17041029anh.75.1214353160418;
        Tue, 24 Jun 2008 17:19:20 -0700 (PDT)
Received: from quicksilver-wifi.gerf.org ( [69.17.59.111])
        by mx.google.com with ESMTPS id g9sm10433265wra.10.2008.06.24.17.19.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 17:19:19 -0700 (PDT)
In-Reply-To: <7vbq1q9zct.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86191>


On Jun 24, 2008, at 7:39 PM, Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
>
>> Christian Holtje <docwhat@gmail.com> writes:
>>
>>> Based on the information about core.whitespace doesn't git do this
>>> already?  Maybe we should just delete the pre-commit hook or make it
>>> empty with a note saying what you can do with it?
>>
>> pre-commit hook also detects unresolved merge conflicts, which
>> core.whitespace doesn't (and probably shouldn't).
>
> But perhaps "diff --check" should.
>

definitely; that sounds like an obvious thing for "diff --check".

Ciao!
