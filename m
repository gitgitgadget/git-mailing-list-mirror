From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: Re: Anyone running GIT on native Windows
Date: Fri, 11 May 2007 19:08:30 -0300
Message-ID: <f329bf540705111508m91f6de7r6e8d025e23a9fc67@mail.gmail.com>
References: <2b6901c78faa$cf9aa7e0$0200a8c0@AMD2500>
	 <46449B0D.5FCD66F1@eudaptics.com>
	 <f329bf540705111035v4a6f0b23w49f04c768a410069@mail.gmail.com>
	 <200705112207.02206.J.Sixt@eudaptics.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Marco Costalba" <mcostalba@gmail.com>
To: "Johannes Sixt" <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Sat May 12 00:08:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmdI3-0007Ih-5O
	for gcvg-git@gmane.org; Sat, 12 May 2007 00:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019AbXEKWIf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 18:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757793AbXEKWIf
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 18:08:35 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:46892 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbXEKWIf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 18:08:35 -0400
Received: by an-out-0708.google.com with SMTP id d18so271935and
        for <git@vger.kernel.org>; Fri, 11 May 2007 15:08:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pubDTml+jikGjfWBDXLpy8OFrntjKBHTL6fqiwVJN8TtfWlu9dchmboMucfI0Y2s2aPLLWXIEEN7LVZAXH0AY2HqjaFpTctSPWFYY+EOm1JBmN+wV2aQ3mYjvnl4kaYiTKcjjeGG/03u0W+Y7fXJ+CCIbhAEXBtwqFKuEwjZ8zI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s1LXVVnZg79GgRwb9FyGeboZ5FOVjC26QBiqtHv2m0XthPtqV2k9BjNyUjAP3gFuTnkIHNMmZHGVLntIw4T+aUoNiv09HQEdlndQDUdZ3o3K2bHUTuPgjjiznlnShs64zjVzMmIKzX9GePp5W7vREifdI1dIQ9dBmOTJy3ogl/s=
Received: by 10.100.171.16 with SMTP id t16mr2610804ane.1178921310756;
        Fri, 11 May 2007 15:08:30 -0700 (PDT)
Received: by 10.100.142.1 with HTTP; Fri, 11 May 2007 15:08:30 -0700 (PDT)
In-Reply-To: <200705112207.02206.J.Sixt@eudaptics.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46990>

2007/5/11, Johannes Sixt <J.Sixt@eudaptics.com>:
> >
> > Can you be more specific? Which files required this?
>
> git.exe, for example, hence, at least all builtins.
>
> > It is entirely coincidental that another DLL from another package
> > works, and it's a bug in our packaging.
>
> Why should this not work? The diffutils package I mentioned is from MinGW.

Because libintl.dll is actually generated in the cross-compile (as
part of the LilyPond),  and might be a different version than the one
you randomly downloaded.

-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
