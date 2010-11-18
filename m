From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: How to import bzr repository into git
Date: Thu, 18 Nov 2010 10:37:03 -0600
Message-ID: <20101118163702.GA16610@burratino>
References: <AANLkTinVrwkOvYgGFX3S2530jfWnrAP28gVm4te1B4sC@mail.gmail.com>
 <AANLkTimPmPOJq64=VePSb2efsx17j8BNxCLt_i=b2ykW@mail.gmail.com>
 <4CE32062.6010308@gmail.com>
 <AANLkTimm2unZoUNH=wgnAFjPpeF_C=tJAZ0DkNK4mMv_@mail.gmail.com>
 <AANLkTikLt+=ffsqY1=-fN49fVZ_Q4HVWnzn5qSftg=T3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitri Pissarenko <dmitri.pissarenko@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>, git@vger.kernel.org,
	bzr-fastimport@packages.debian.com
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 17:38:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ7Un-0001u5-KE
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 17:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759866Ab0KRQhv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Nov 2010 11:37:51 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47566 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759674Ab0KRQhu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 11:37:50 -0500
Received: by fxm10 with SMTP id 10so90937fxm.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 08:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=TKgDeWeLzGANFc0TweXKGhSql1RiLMsBUJFwVzpweVQ=;
        b=n/QyySr9Io+zNhrGzaJqrnrOa5Vudemkko49B7OyuwcHOUb/cwuAiTRRbQ1Qj0wSCF
         VQYVDDB61y3w2KXvwwQvaMaaqRAe1g+1wpGSzs/nfHpnFOzYP+JsOPjbBbNUHrT+2VIp
         5DPzL5l7xD7WxRunjQl/Wlm4HeAiq+zQsBaCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Y3YCZJBXgP3bo0fK89H5ERHxlXip9RtBRmJxYWH6qzUFy3gBoMt+r+BQ0dl19thPTz
         J6AQD/YfOuIN0hmet/zJt1hLLIiG4zsjjXc1EGCpqFjUMF4amzIFaF+B3V8kD0iAbHW5
         8sNZkTiqlZC6sfAOB/3kUgvPdAeu/N+Okv9nY=
Received: by 10.223.86.203 with SMTP id t11mr778775fal.97.1290098269054;
        Thu, 18 Nov 2010 08:37:49 -0800 (PST)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id j14sm198352faa.47.2010.11.18.08.37.46
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Nov 2010 08:37:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikLt+=ffsqY1=-fN49fVZ_Q4HVWnzn5qSftg=T3@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161682>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Thu, Nov 18, 2010 at 15:34, Dmitri Pissarenko
> <dmitri.pissarenko@gmail.com> wrote:

>> However, I had to give up this idea due to an "out of memory" error
>> during bzr-export.
>
> Buy more memory or use more swap?

Or report it as a bug/wanted feature?

Cc-ing Jelmer Vernooij in the hope that he might be able to point you
to the right person for that.

Thanks,
Jonathan
