From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: [Updated PATCH 1/2] Report exec errors from run-command
Date: Thu, 31 Dec 2009 09:44:33 -0500
Message-ID: <905315640912310644r7e94699eo876361fb6139f0e7@mail.gmail.com>
References: <1262170338-11574-1-git-send-email-ilari.liusvaara@elisanet.fi> 
	<1262170338-11574-2-git-send-email-ilari.liusvaara@elisanet.fi> 
	<905315640912302126n1848c99cre0f9caa644041fad@mail.gmail.com> 
	<20091231104835.GA18848@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Dec 31 15:46:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQMI4-0008G0-QV
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 15:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465AbZLaOoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 09:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752355AbZLaOoy
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 09:44:54 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:44833 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbZLaOox (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 09:44:53 -0500
Received: by pwj9 with SMTP id 9so7942126pwj.21
        for <git@vger.kernel.org>; Thu, 31 Dec 2009 06:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type;
        bh=zQJpSF9/f2v5Te4TGNAOWi+InBcZBJovzTDgl3QIojg=;
        b=T76LVyaCS8MfRIRj5YyZqj17kCFndp2qLuw6oI20ShrVwX2o7GdEf0FYJVMC0NnBiy
         +m1iZ/ZIBFc5hK8PVEW4hITqyzhjcMa+uCitALEwfttrC2TqRLSl6VPuDZ/mZaWXmdMU
         79D5R9XFFCgx2tLgj9LzY0ryPZ8GFFS4sPmUk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=Ui6CFFcbFNFDlmrf22ZR5MxCkMpYvE/n3sekkpquzUdatYp6ZaSZu4IpxLffvH7mYf
         w2Zzx6EaDF6lNVSDdtuoVxFfmhkoAFli098fYu4sXY4UecTlqIMcvy/TU2T9ahqkjhz5
         7eL4D7WMF0KiS+R9dHA0NRguGnYrxD0G4FpJI=
Received: by 10.142.248.42 with SMTP id v42mr13226621wfh.187.1262270693147; 
	Thu, 31 Dec 2009 06:44:53 -0800 (PST)
In-Reply-To: <20091231104835.GA18848@Knoppix>
X-Google-Sender-Auth: f8ce44c271f2cfb9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135953>

On Thu, Dec 31, 2009 at 5:48 AM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> On Thu, Dec 31, 2009 at 12:26:48AM -0500, Tarmigan wrote:
>> On Wed, Dec 30, 2009 at 5:52 AM, Ilari Liusvaara
>> <ilari.liusvaara@elisanet.fi> wrote:
>>
>> I was testing pu and 'git diff' and 'git log' would hang forever.
>
> V3 just sent to list. Should fix this issue.

Yep, that fixed it.

Thanks,
Tarmigan
