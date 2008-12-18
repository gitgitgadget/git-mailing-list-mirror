From: "James Pickens" <jepicken@gmail.com>
Subject: Re: [RFC PATCH 0/2] Add support for multi threaded checkout
Date: Thu, 18 Dec 2008 14:13:34 -0700
Message-ID: <885649360812181313q6d43354jf73b3f39d5844016@mail.gmail.com>
References: <3BA20DF9B35F384F8B7395B001EC3FB3265B2A01@azsmsx507.amr.corp.intel.com>
	 <alpine.LFD.2.00.0812181600210.30035@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Dec 18 22:15:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDQCr-00009D-Qm
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 22:14:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362AbYLRVNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 16:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbYLRVNf
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 16:13:35 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:17592 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203AbYLRVNf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 16:13:35 -0500
Received: by wa-out-1112.google.com with SMTP id v27so322314wah.21
        for <git@vger.kernel.org>; Thu, 18 Dec 2008 13:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=GOE6KnkhY7+YGvbsQU27aT6nI0kBCOcHAOMQsNcfL2k=;
        b=CBf52jD/YdxltMZc0A5Ea8JDWHkQwU0HVnASVO+lf92IR5RYRWvpsPV2L0gRIjYGrN
         jTiJNaw65j4I1v1lQT8ACleP49Z9uQ/IWzqKrLwkBaOGkDCGElZQ0Fmfpb6a++MTl0Gr
         3Xd3mKnD05QTV6jbyMefBluNdhC/KgycEq4oA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fozOYsAcjR5YFTEoyTQWMI8Xw76rL0pPLUlLLaYuvEMx8cKCeQ6wKXGUYaNbGvKhH2
         0v9XH1lMZkjBx/lwOJFC9QMJTygBY/nHLQgQjywyA7H3jtzDZZWjYE1jEBZ1sIJvaC2Y
         7S931ymQqmJ9wM8tGkqhiIgTIyOKh3Ik9yXyE=
Received: by 10.114.56.1 with SMTP id e1mr1388280waa.150.1229634814160;
        Thu, 18 Dec 2008 13:13:34 -0800 (PST)
Received: by 10.114.80.15 with HTTP; Thu, 18 Dec 2008 13:13:34 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0812181600210.30035@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103493>

[Resending since I forgot to copy the list]

On Thu, Dec 18, 2008, Nicolas Pitre <nico@cam.org> wrote:
> On Thu, 18 Dec 2008, Pickens, James E wrote:
>
>>                    NFS->NFS    NFS->Local
>> master (53682f0c)    2:46.1          13.3
>> with threads           36.6          18.2
>>
>> So it improved performance on NFS significantly.
>
> Are those figures repeatable over multiple consecutive runs?

Roughly, yes.  There is some variance of course, probably
more than usual since all these operations involve NFS.
The numbers are the best of several runs in each case.

James
