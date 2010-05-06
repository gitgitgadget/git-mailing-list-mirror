From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: What should be the CRLF policy when win + Linux?
Date: Thu, 6 May 2010 19:26:34 +0200
Message-ID: <k2s40aa078e1005061026x277757f4pae151c4d312eb3de@mail.gmail.com>
References: <4BE141E3.2060904@gmail.com>
	 <x2h600158c31005051935i6f379a9j6aa36b4503776b87@mail.gmail.com>
	 <o2ved79be1d1005060029n67f451c6p3b48b83c51031222@mail.gmail.com>
	 <i2i600158c31005060834s72e10fb7te19048e3b174d29b@mail.gmail.com>
	 <alpine.LFD.2.00.1005061009020.901@i5.linux-foundation.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: hasen j <hasan.aljudy@gmail.com>,
	Wilbert van Dolleweerd <wilbert@arentheym.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu May 06 19:26:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA4qR-0006Y4-5l
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 19:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837Ab0EFR0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 13:26:36 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:34988 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab0EFR0f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 13:26:35 -0400
Received: by wwb39 with SMTP id 39so169160wwb.19
        for <git@vger.kernel.org>; Thu, 06 May 2010 10:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type;
        bh=t8ADK/t1ijOjz4RXmsgitNpj4clPfVOZzfps/obO+JE=;
        b=vv0t7mLws4YOPT9kwGzsr6k+6vRuYD5R/2SHpEcOvkhWIFQ5IEcXY8F/TcidiFg13S
         eR2C+dp3PCg/VwjNX/x3mistQCHYuamx30uQevdmUQ2UkK0SdEtMGsSDPHfTEbmp1OvB
         g5+LhNUi6tYJ5Fzn9c/qvBR4Y03sW3xtUloHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=Sd+CK5beQSMBedMm/Dl1Aa9O3R46jtE4F2gt2sNu1K5ObLnMtIO2E+chCIeo1wKGv2
         bxV35h3PlPIIKJZR7tqQAvVY82kAIe1UOQQNSO40vheSpNmYtj98hGMgHaFERQFPIqVW
         k3IGGyxEGk39Fvidg4WunsPzldlhmz3XVntCg=
Received: by 10.216.89.193 with SMTP id c43mr3721487wef.151.1273166794056; 
	Thu, 06 May 2010 10:26:34 -0700 (PDT)
Received: by 10.216.51.79 with HTTP; Thu, 6 May 2010 10:26:34 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005061009020.901@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146486>

On Thu, May 6, 2010 at 7:15 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Thu, 6 May 2010, hasen j wrote:
>>
>> I don't know all linux editors, but I've yet to see one that can't
>> handle CRLF endings.
>
> A _lot_ of UNIX editors will handle CRLF endings, but if you change a
> file, they often write the result back with _mixed_ endings.

Just for completeness: The inverse is also the case on Windows; a lot
of editors will handle LF endings, but a handful of them will insert
gladly insert CRLFs under certain circumstances. Microsoft Visual
Studio is one of these.

So yeah, neither CRLF or LF everywhere is generally a good idea.

-- 
Erik "kusma" Faye-Lund
