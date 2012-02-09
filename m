From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Git, Builds, and Filesystem Type
Date: Thu, 9 Feb 2012 15:24:47 -0800
Message-ID: <CAE1pOi387-bimYEG4bjFOjaCwhPeDyLRj7wOJgyuKSCrZ9kBFg@mail.gmail.com>
References: <CAE1pOi1of-hj+87M7RqhFUWA8an14bPG88dAOwhNogmfFvJ=tA@mail.gmail.com>
	<201202091453.38564.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Fri Feb 10 00:24:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvdMD-0007hs-CQ
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 00:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758274Ab2BIXYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 18:24:49 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52711 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754395Ab2BIXYs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 18:24:48 -0500
Received: by ggnh1 with SMTP id h1so1231357ggn.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 15:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3OXD9hrhCKxPfiAq2iHmwY8ZPdpqSBka0eywnmdYLYw=;
        b=CyrBag0Tzdbcv9RhS793pypCnMbezFTYMvXJwNSzTH3ddx86xXvlGoezC/s7rFnHGT
         WCJxPh+7g+G7tmRidqfArHGjG4qjn0YgeQQ70xXJNh/jCQuoFEPIbrpOl/LA0PxTLa6w
         0eFXmOglXUEzuSf5n6YsORZLfT8wQCbSl/CZI=
Received: by 10.236.189.105 with SMTP id b69mr5822981yhn.90.1328829888023;
 Thu, 09 Feb 2012 15:24:48 -0800 (PST)
Received: by 10.236.73.130 with HTTP; Thu, 9 Feb 2012 15:24:47 -0800 (PST)
In-Reply-To: <201202091453.38564.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190341>

On 9 February 2012 13:53, Martin Fick <mfick@codeaurora.org> wrote:
> On Thursday, February 09, 2012 02:23:18 pm Hilco Wijbenga
> wrote:
>> For the record, our (Java) project is quite small. It's
>> 43MB (source and images) and the entire directory tree
>> after building is about 1.6GB (this includes all JARs
>> downloaded by Maven). So we're not talking TBs of data.
>>
>> Any thoughts on which FSs to include in my tests? Or
>> simply which FS might be more appropriate?
>
> tmpfs is probably fastest hands down if you can use it (even
> if you have to back it by swap).

I don't have quite that much RAM. :-)
