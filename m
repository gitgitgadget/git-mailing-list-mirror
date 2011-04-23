From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Cloning into an existing, non-empty directory?
Date: Sat, 23 Apr 2011 17:28:48 +0700
Message-ID: <BANLkTi=uNpruRhPcxKMUy4CH2V5q-z9U7Q@mail.gmail.com>
References: <BANLkTi=VwiqN99AMEJb6jb1uFya2Hipibw@mail.gmail.com>
 <20110421220327.GA3396@elie> <BANLkTikY7c7rP+yv5vt2vxw5nu84k_H=Xw@mail.gmail.com>
 <20110423101500.GB1500@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Richard Hartmann <richih.mailinglist@gmail.com>,
	Git List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 23 12:29:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDa5e-000560-OO
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 12:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036Ab1DWK3W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Apr 2011 06:29:22 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33660 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493Ab1DWK3U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2011 06:29:20 -0400
Received: by bwz15 with SMTP id 15so815393bwz.19
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 03:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=vQ1DoQ8JbkQJg3T/DPaBufkNq8kNOojMhVgDNVIU3xE=;
        b=BDEnAMk3GS1hXby+VCL4UfGQhzN2kvToNFG9RFY36HiyvlgvzUThyUfRHJ9GViBNKj
         BPjN4jWxXDVzH2lGoxGd/lLubsMUFcBVIoUAwb1GKXaQC6ni5N9O0RgLMOrmvAt5N8pZ
         Q34nXnHDkAQSHJMlWaU+TPV3aWOSMs3wbzgXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Pn3eug40EXWn4hmCoaxCWRsSk61abM0K0DuyQBi7It6mUmQko9ULx94BMY2G4i4iFv
         YLitj+BjV70OnJZVZOOiBqC1biVD5QyEN/FPxtuxLA2mR2pwSSMcTCqQ82hWr0YEiigR
         67CNfqVbTKqwbpIyPmJR4glmoXvfdsK/2GK04=
Received: by 10.204.0.71 with SMTP id 7mr1728276bka.11.1303554558192; Sat, 23
 Apr 2011 03:29:18 -0700 (PDT)
Received: by 10.204.17.14 with HTTP; Sat, 23 Apr 2011 03:28:48 -0700 (PDT)
In-Reply-To: <20110423101500.GB1500@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171980>

2011/4/23 Jonathan Nieder <jrnieder@gmail.com>:
>> 2) running `git pull` as suggested results in:
>>
>> fatal: /usr/lib/git-core/git-pull cannot be used without a working t=
ree.
>>
>> which can be worked around by using --work-tree and --git-dir . Not
>> ideal, but workeable if I accept the race condition.
>
> Weird. =C2=A0Maybe chdir-ing into the work tree will help? =C2=A0(Tra=
ditionally,
> git commands tend to be run from within the work tree, so I wouldn't
> be too surprised if some commands do not like being run from outside.=
)

Does this patch help?

http://article.gmane.org/gmane.comp.version-control.git/150986
--=20
Duy
