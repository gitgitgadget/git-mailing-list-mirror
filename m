From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/43] refs lmdb backend
Date: Thu, 17 Sep 2015 09:33:47 -0700
Message-ID: <xmqqlhc5j990.fsf@gitster.mtv.corp.google.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
	<xmqqfv2vgkve.fsf@gitster.mtv.corp.google.com>
	<1441382482.25570.33.camel@twopensource.com>
	<1442448552.5140.3.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 18:33:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zcc89-0005kZ-SD
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 18:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbbIQQdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 12:33:50 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34344 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbbIQQdt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 12:33:49 -0400
Received: by padhy16 with SMTP id hy16so24090497pad.1
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 09:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=EBOQGJKa2FWCS9+ATaeaSZf8GF1rMjtl0Tt9ZXmGhAM=;
        b=gQT0SIaNqnTVF9aO+N440NdbSVmYOatgmrEaa9pSxKOb4Dd1zMFtjWk3QDhfA+bdxu
         C+iMgl13jXMmLnbJ49eUhJFRYXT0uRKgthOzbqV9TTCiB8ekusMt6J/km9MFPhAG4izi
         bj0G1UBDqvl6kjFAvhAlGsuWDpNrEu9ob5w+7X9lga3twKm9+bKFI0BGFZphUOY8Si0p
         ukcUvP9VE/xp6QJrGzwb84E+nR9ZYIqz8ue/Ctc9iizuAVpHC+bTpEUr1gsYSiwCaday
         T/pulgYnO0dY+996HdEyu/6HTSe+Nf9RV/kHT1Z0S5t84Z/JzoJ4pd8T4BlN8ZstgQFh
         iI9A==
X-Received: by 10.66.243.225 with SMTP id xb1mr97178pac.78.1442507629309;
        Thu, 17 Sep 2015 09:33:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:25ac:307e:6383:2d03])
        by smtp.gmail.com with ESMTPSA id pi9sm4315937pbb.96.2015.09.17.09.33.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 17 Sep 2015 09:33:48 -0700 (PDT)
In-Reply-To: <1442448552.5140.3.camel@twopensource.com> (David Turner's
	message of "Wed, 16 Sep 2015 20:09:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278133>

David Turner <dturner@twopensource.com> writes:

> On Fri, 2015-09-04 at 12:01 -0400, David Turner wrote:
>> On Thu, 2015-09-03 at 16:10 -0700, Junio C Hamano wrote:
>> > 
>> > [03/43] seems to be missing
>> 
>> I just attempted to re-send it, but I still don't see it on gmane.
>> Perhaps this is because it is greater than some size limit?  It's about
>> 265k.  I've attached a gzipped version to this email.  
>
> Just wanted to send a ping on this series.  I know it's a big set of
> changes to review.  Let me know if there's anything else I can do to
> help here.

To me personally you cannot do much to help unless you have a magic
device to make a day to have more than 24 hours X-<.  Sorry about
that.

I'd get to it eventually but others are welcome to beat me to it
while I am looking at other topics and upcoming release ;-).
