From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: Re: Anyone running GIT on native Windows
Date: Fri, 11 May 2007 14:35:48 -0300
Message-ID: <f329bf540705111035v4a6f0b23w49f04c768a410069@mail.gmail.com>
References: <2b6901c78faa$cf9aa7e0$0200a8c0@AMD2500>
	 <7vejlufmhd.fsf@assigned-by-dhcp.cox.net>
	 <2b7f01c78fb1$be4dc6a0$0200a8c0@AMD2500>
	 <463ECEF4.625F3633@eudaptics.com>
	 <e5bfff550705070448t7813d064mbac82abb45591888@mail.gmail.com>
	 <463F14FF.F8DF11EB@eudaptics.com> <46415106.5040401@xs4all.nl>
	 <46417351.6BBA9313@eudaptics.com> <4643EA77.4040803@xs4all.nl>
	 <46449B0D.5FCD66F1@eudaptics.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Marco Costalba" <mcostalba@gmail.com>, git@vger.kernel.org
To: "Johannes Sixt" <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Fri May 11 19:35:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmZ25-0000G9-ED
	for gcvg-git@gmane.org; Fri, 11 May 2007 19:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759919AbXEKRft (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 13:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759779AbXEKRft
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 13:35:49 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:56260 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759919AbXEKRft (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 13:35:49 -0400
Received: by an-out-0708.google.com with SMTP id d18so253035and
        for <git@vger.kernel.org>; Fri, 11 May 2007 10:35:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jwCnvmWCcNO0j41e7skocVU05P/Bhf0oFETnn7F387NYihockHZHXvXH7kpiSEa3z3ouikCyEuMVp1cED4FpRrXOoALhiWyq/fXujvhQRW1trzAcPPLAhQL/h7cSeactKx+gC4sOUo91Jx+KLzc29OxkIX3+aRcDY7kGUd/M3A8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gaD7rRVk0M4JKdOPrRL5NguCkIlcHp6a+/ZUisJR7s+Upf+iFWV6DX84gDaQX/UBCgnqphrJpYFLYyZuPywsdnXPLLyFOkvToUG3sNKW/nXBQ9Kreh12EXUKp710wCnMw3E815otJOFcH9DHEYwmqAgaiNw/8blk1MS4wOS8yoE=
Received: by 10.100.227.5 with SMTP id z5mr2390268ang.1178904948215;
        Fri, 11 May 2007 10:35:48 -0700 (PDT)
Received: by 10.100.142.1 with HTTP; Fri, 11 May 2007 10:35:48 -0700 (PDT)
In-Reply-To: <46449B0D.5FCD66F1@eudaptics.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46971>

2007/5/11, Johannes Sixt <J.Sixt@eudaptics.com>:
> Han-Wen Nienhuys wrote:
> > http://lilypond.org/git/binaries/mingw/git-1.5.1-1.mingw.exe
>
> This resulted in a mostly working git toolset after I've done this in
> addition to installing it:
>
> - Installed MSYS (of course ;)
> - Install libiconv-2.dll, which can be found in
> diffutils-2.8.7-1-dep.zip from

Can you be more specific? Which files required this?

It is entirely coincidental that another DLL from another package
works, and it's a bug in our packaging.

The path to Git should also have been set automatically. I will look into this.

--
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
