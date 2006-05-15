From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: 1.3.2.gde1d fails to build on OpenBSD
Date: 15 May 2006 08:57:40 -0700
Message-ID: <86bqtzth57.fsf@blue.stonehenge.com>
References: <86psiftlgf.fsf@blue.stonehenge.com>
	<20060515185819.ff05f6fe.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 17:57:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FffS6-0003Lz-GF
	for gcvg-git@gmane.org; Mon, 15 May 2006 17:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWEOP5n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 11:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbWEOP5n
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 11:57:43 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:56204 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751491AbWEOP5m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 11:57:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id CF4B98F2CA;
	Mon, 15 May 2006 08:57:41 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 16046-01-6; Mon, 15 May 2006 08:57:41 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 37A838F2D2; Mon, 15 May 2006 08:57:41 -0700 (PDT)
To: Timo Hirvonen <tihirvon@gmail.com>
x-mayan-date: Long count = 12.19.13.5.8; tzolkin = 10 Lamat; haab = 1 Zip
In-Reply-To: <20060515185819.ff05f6fe.tihirvon@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20061>

>>>>> "Timo" == Timo Hirvonen <tihirvon@gmail.com> writes:

>> I think you want
>> 
>> #include <sys/types.h>
>> 
>> on OpenBSD.

Timo> I think it should be #include <inttypes.h>.  It works at least on BSD
Timo> and Linux.

Yes, that's present in OpenBSD.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
