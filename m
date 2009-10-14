From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] checkout: add 'pre-checkout' hook
Date: Wed, 14 Oct 2009 09:04:18 +0200
Message-ID: <36ca99e90910140004y275cbb86he03d790ec7a388d4@mail.gmail.com>
References: <1255495525-11254-1-git-send-email-sam.vilain@catalyst.net.nz>
	 <36ca99e90910132349o25322021l266124bd8b0d30b3@mail.gmail.com>
	 <4AD574CA.8010900@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, elliot@catalyst.net.nz
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Oct 14 09:06:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxxwX-0004cZ-RC
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 09:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755504AbZJNHE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 03:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754159AbZJNHEz
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 03:04:55 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:45664 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbZJNHEz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 03:04:55 -0400
Received: by fxm27 with SMTP id 27so11168270fxm.17
        for <git@vger.kernel.org>; Wed, 14 Oct 2009 00:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=YgqFIF5Wl+cQVJsGAwaQeNXEcJMxAaJH3yowF6PWePw=;
        b=OK4pCMvP0gS3u9pkfKcNEeT89J846De54fWDj87bsHnV/7CLlN5dEQZKhuHFn72Zzr
         foaZaItt3cyt9dcn53dnaV7BvhW58F+T3QrCK2bfrONjBOrw7BAov21cQHXN1nzNk2At
         Z5GkRG50W805o4Z+jyxnR6zop7YkqjtzP80b4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=sEO4M0ylfGJ/MSwH5FUc43grA62G4HcB67ZGcOspRIiur1KUDPe6c+FC7KKLkNB6PX
         D5nnUxDNCl+SoZHu5Hka77qorAL0G1Ws+Egd+aWzA2DTb3PDhTWGPs2po9IVqphOMX1K
         2Kla2pwmjGOOtR9WPkrGn0WpKCPYrEY4a6QQo=
Received: by 10.223.14.140 with SMTP id g12mr2001359faa.50.1255503858394; Wed, 
	14 Oct 2009 00:04:18 -0700 (PDT)
In-Reply-To: <4AD574CA.8010900@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130263>

On Wed, Oct 14, 2009 at 08:50, Sam Vilain <sam.vilain@catalyst.net.nz> wrote:
> Bert Wesarg wrote:
>>> +pre-checkout
>>> +-----------
>>>
>>> -post-checkout
>>> -~~~~~~~~~~~~~
>>> -
>> Why do you change the caption from subsection (Ie. ~~~) to section (Ie. ---)?
>
> Possibly the headings changed from the version I originally patched to
> the current 'master'.
That was me one month ago ;-)
