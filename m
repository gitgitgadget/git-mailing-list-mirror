From: Leonid Podolny <leonidp.lists@gmail.com>
Subject: Re: last commit in a directory
Date: Tue, 25 Jan 2011 10:50:15 +0200
Message-ID: <4D3E8EC7.8000407@gmail.com>
References: <4D3E89FA.4080901@gmail.com> <4D3E8E0B.2090200@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jan 25 09:50:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhebZ-0008EP-C7
	for gcvg-git-2@lo.gmane.org; Tue, 25 Jan 2011 09:50:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091Ab1AYIuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jan 2011 03:50:21 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45633 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074Ab1AYIuU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jan 2011 03:50:20 -0500
Received: by ewy5 with SMTP id 5so2411735ewy.19
        for <git@vger.kernel.org>; Tue, 25 Jan 2011 00:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=p3UuwiVxIosoUvuUQqjoFNy2brsLtw/BQOULn5+8I30=;
        b=GjFTJ4Nb5FZzCddV6GIbCg3khEk2OZRv+PPcb6nAkw7hgHOOD7DpvQ6Lc/VH9xPQHP
         4+MmutJuqq9qJ1sCXdWRggGaqu1WMadFXgeOXrXgNdWf3pKyumhI3yweV4p5rd66UouR
         R/0J78ssMBzf/ABp0A8cFO/6sFvh5Na0hO3pY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=lWFQlT82NBFulGu1ewudCScTrGuO9CS9+m1OZkbPwROQRYiRmCbz8Qdo4rA8XIg9w5
         +euUZ4VPtngWVh40lwcz6yu2gCfVf1DQonwcuWAoGpA/ewPrll1JfRmLiKjE9SZsB7lu
         Y4ILCnoWB1i7+4+02B6b6YnZG/VZ+lh+O61bo=
Received: by 10.213.105.74 with SMTP id s10mr6460388ebo.48.1295945418957;
        Tue, 25 Jan 2011 00:50:18 -0800 (PST)
Received: from [10.20.20.19] (80.179.223.9.cable.012.net.il [80.179.223.9])
        by mx.google.com with ESMTPS id u1sm10941105eeh.22.2011.01.25.00.50.17
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 25 Jan 2011 00:50:18 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Thunderbird/3.1.7
In-Reply-To: <4D3E8E0B.2090200@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165475>

On 01/25/2011 10:47 AM, Johannes Sixt wrote:
> Am 1/25/2011 9:29, schrieb Leonid Podolny:
>> I have a really simple question: how do I find a last commit for the given
>> directory inside the repository?
>
> git log -1 that/directory
>
> But if you need it in a script, this is preferable:
>
>    lastsha1=$(git rev-list -1 HEAD -- "$directory")
>

Thanks!
