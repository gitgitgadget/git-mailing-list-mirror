From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv3 1/6] Add additional testcases for D/F conflicts
Date: Wed, 7 Jul 2010 21:07:53 -0600
Message-ID: <AANLkTinVyfWEqJqZgpiXv0hvMLELLb-UThi-0W2izGQc@mail.gmail.com>
References: <1278480034-22939-1-git-send-email-newren@gmail.com>
	<1278480034-22939-2-git-send-email-newren@gmail.com>
	<7vocejt25d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, spearce@spearce.org, agladysh@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 05:08:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWhSx-0004ho-Tv
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 05:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067Ab0GHDHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 23:07:54 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49827 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531Ab0GHDHy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 23:07:54 -0400
Received: by vws5 with SMTP id 5so495651vws.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 20:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=mV3WSo0x69G8nESbM0g2vaAUv80vVMPAhaSowvd85zs=;
        b=Su/eZMdhIPZHfOw8u2Iu9Xrz6WMmXGKQ2TcNASFcpeoDg7oXoYTuQ+x6ccoF7PtZzQ
         c6xMhvIvlCIxEmyl606gJ11jae4rW8pP3lMWNvpT3IKerZyPlAOpcioQ1+B5C2TebK+Y
         Bx4VgcxjXG5kI1mPqnS11PB4k0u2mUsoatndI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=CXu3tI6NxOvxz85NWIbn4rp0uP/L+jAG3IgDbDosg5wnFQ01cFkQ0eviLktibMan8f
         Wk8nwKi2fcAvfFxy3k3XRWSlCAEIxxF2XiEFtbjcawQ+w931tqc0T0oYeoBbpqs0kPa3
         o56jZTZBp4jlhL99n3oLLj/5qPwVl+EHL8nvA=
Received: by 10.220.49.28 with SMTP id t28mr3823912vcf.233.1278558473299; Wed, 
	07 Jul 2010 20:07:53 -0700 (PDT)
Received: by 10.220.92.199 with HTTP; Wed, 7 Jul 2010 20:07:53 -0700 (PDT)
In-Reply-To: <7vocejt25d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150530>

Hi,

Thanks for the thorough reviews!

On Wed, Jul 7, 2010 at 3:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> -test_expect_failure 'do not lose a/b-2/c/d in merge (recursive)' '
>> +test_expect_failure 'Handle D/F conflict, do not lose a/b-2/c/d in merge (recursive)' '
>
> If you retitle this, you would probably want to retitle the corresponding
> test for resolve (the one before this test) the same way.
<snip>
> It may be a good idea to see what resolve does for all these new
> tests.

I'd be happy to make these and the other changes you suggested, but I
notice that you've already done so in pu with Fixup commits for this
and the other patches.  Should I squash those in for a resend of the
series?

Also, do you want me to split the series as you did with the testsuite
addition patches separate from the fixes?

Thanks,
Elijah
