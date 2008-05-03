From: Tim Harper <timcharper@gmail.com>
Subject: Re: [PATCH] I don't known anyone who understands what it means when they do a merge and see "file.txt: needs update".  "file.txt: has changes" is much clearer.
Date: Sat, 3 May 2008 14:10:48 -0600
Message-ID: <3DE78C03-DA35-4CB5-8D3D-0529A89065EC@gmail.com>
References: <1209798522-13618-1-git-send-email-timcharper@gmail.com> <alpine.DEB.1.00.0805031509170.30431@racer> <7v3aozwcj6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 03 22:11:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsO57-0003qt-No
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 22:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbYECUKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 16:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752120AbYECUKx
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 16:10:53 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:63700 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbYECUKw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 16:10:52 -0400
Received: by wf-out-1314.google.com with SMTP id 27so502890wfd.4
        for <git@vger.kernel.org>; Sat, 03 May 2008 13:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=SZHN1+mLQXUyXicAp1XvAssV1R5k3Kn3Y0S3OGnG7BI=;
        b=cR0Y9lmLhnC+zeGnQWG3J6DMTv+Kvpn5ozgP8XEC6a336vCqlUUbUSQnz34I69C0DNhzJ5WcAJ74xhwmxE826IJ9AMOPBVEosgPS1ePl3WmZfQdlxi3OAb6QLDYGZFNG1KVNkUjrnu05IM2pNIswCrohgAVP4lyMhXLmPv9gEBs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=HQi3rHRrT59zEuutRHqLoWH/oeLTXseJ/NhWUaDGNVg9AADZqhdZA3yHq3UFGUPl0E0H0QCm8g23wdOAYzvAlAMRZpVB7caUmGquAn8LwmpPCod6idK2lKlmBMrkr/CIW80u91JzrbetUCM8tbRdvzuxBNY2gJYFCZdttXTtq9A=
Received: by 10.142.128.6 with SMTP id a6mr1814659wfd.206.1209845452345;
        Sat, 03 May 2008 13:10:52 -0700 (PDT)
Received: from ?10.0.0.103? ( [208.186.134.104])
        by mx.google.com with ESMTPS id 20sm11482658wfi.11.2008.05.03.13.10.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 May 2008 13:10:51 -0700 (PDT)
In-Reply-To: <7v3aozwcj6.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81114>

I ran all of the tests with the patch apply, and they all pass.  Is  
that enough indication?

Tim

On May 3, 2008, at 10:57 AM, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> On Sat, 3 May 2008, Tim Harper wrote:
>>
>>> -			printf("%s: needs update\n", ce->name);
>>> +			printf("%s: has changes\n", ce->name);
>>
>> How about "local changes"?
>
> Aren't there Porcelain and end-user scripts that relies on the  
> output by
> doing "sed -ne s'/: needs update$//p"?
>
