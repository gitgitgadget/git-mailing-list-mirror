From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC] Disabling status hints in COMMIT_EDITMSG
Date: Tue, 10 Sep 2013 21:53:44 +1200
Message-ID: <522EEC28.6020405@gmail.com>
References: <vpq4n9tghk5.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 10 11:52:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJKcm-0005Z8-Ss
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 11:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111Ab3IJJwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 05:52:41 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:36601 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982Ab3IJJwk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 05:52:40 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro12so7337525pbb.41
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 02:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=mSJCFme1Turkba7EJb3cY7quGDRVtOCpX3cIPrDZnK8=;
        b=nsQ+Qnwi5+VW9CKMu8tluhAjkSk55WnIZsun/8LEnYzbo2fAgrOTmvGyJ1nEcvlCY/
         kroT1X0qhHvHI8ztT1dQPZ3EAv5u9cBBVsOQZdvpEd614pi3Hwf/f75dw4V3bKD/4r2i
         CrqAniu4SIA/cRDeOZP7eXjtvmFeWSB37InonDTbq4A6XzaKr+6hc6HMxJtdmlX3FVgd
         HLIMmMrkeSgJTckefEOM9uyno7chFaBGKSz2ZtCgLuAXf7rpDTHDecpcvocahwqYflVv
         MlqGcnGOmZDrEdPR2puObMmdTLTlsGDkUOuPvxDa/fc2veNoNVqm26T3hno6LfjxF3+F
         H8DA==
X-Received: by 10.68.96.130 with SMTP id ds2mr23884879pbb.99.1378806760071;
        Tue, 10 Sep 2013 02:52:40 -0700 (PDT)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id ht5sm21849365pbb.29.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 02:52:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <vpq4n9tghk5.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234429>

On 10/09/13 21:19, Matthieu Moy wrote:
> Hi,
> 
> I just noticed that the template COMMIT_EDITMSG was containing status
> hints, and that they were not particularty helpfull _during_ a commit. I
> think it would be sensible to ignore advice.statusHints and disable
> hints unconditionally when writting to COMMIT_EDITMSG.
> 
> Any objection?
> 

I did recently find them useful/reassuring when I was committing a
merge. But I wouldn't consider that a strong objection.
