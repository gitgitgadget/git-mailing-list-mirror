From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Sparse clones (Was: Re: [PATCH 1/2] upload-pack: support subtree 
	packing)
Date: Wed, 28 Jul 2010 13:06:57 +1000
Message-ID: <AANLkTin3OB6mw6rih208ybCL2+QQ8LpuCP5y=DywMuyw@mail.gmail.com>
References: <AANLkTikJhSVJw2hXkp0j6XA+k-J-AtSYzKWumjnqqsgz@mail.gmail.com>
	<AANLkTikMLOFet-VMT7MntPgoSkvqGAXPd8Z1aaDpY1xs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 05:07:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdwzI-0001X8-3R
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 05:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443Ab0G1DHF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 23:07:05 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:52124 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879Ab0G1DG7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 23:06:59 -0400
Received: by qyk7 with SMTP id 7so3220381qyk.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 20:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=J3SQr8Wn4LvDoqIakLNtl7nO87ruzslPR3VkkDivZks=;
        b=DqlVz2nphjZLOcL/bME8+1iAbOHGVVVQrHxWMQhtE1aWKGOtj2OdONQmSTcPlVMBaT
         5GeNKfN735gDwpUuAwkoSjL3iBQQzQUkHBCsM0vo3bIUFAoa/uXhzvPuop6knSv0/vSw
         QE4Z44U+QQIKkgZ37BbRXVsJxYjdMCgZo+t3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=unhJdMvObieqBlUtHfqI6orTFVvHS3MqDo33nosnnJ8JhO49gLVqNoqhtbLMDsRIV3
         dpPcbja4cBxp7RvjOBLOkoQ6tBcfAAqbuxffFICKJeKp+FyQ1Nu+Raf2I+Em9mAeWOP+
         fKOKjYkBCa//RLu9EnwCYh8UcdqSpRlkTEg9g=
Received: by 10.224.11.140 with SMTP id t12mr8207045qat.357.1280286417387; 
	Tue, 27 Jul 2010 20:06:57 -0700 (PDT)
Received: by 10.220.101.201 with HTTP; Tue, 27 Jul 2010 20:06:57 -0700 (PDT)
In-Reply-To: <AANLkTikMLOFet-VMT7MntPgoSkvqGAXPd8Z1aaDpY1xs@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152031>

2010/7/28 Avery Pennarun <apenwarr@gmail.com>:
> 2010/7/27 Elijah Newren <newren@gmail.com>:
>> 0) Sparse clones have "all" commit objects, but not all trees/blobs.
>>
>> Note that "all" only means all that are reachable from the refs bein=
g
>> downloaded, of course. =C2=A0I think this is widely agreed upon and =
has
>> been suggested many times on this list.
>
> I think downloading all commit objects would require very low
> bandwidth and storage space, so it should be harmless.

Here you go. A pack with only commits and trees of git.git#master is
15M. With blobs, it is 28M. Git is not a typical repo with large blobs
though.
--=20
Duy
