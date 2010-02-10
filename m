From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] Documentation: reword --thin description
Date: Wed, 10 Feb 2010 08:52:51 -0800
Message-ID: <4B72E463.6060409@gmail.com>
References: <1265778851-5397-1-git-send-email-bebarino@gmail.com> <alpine.LFD.2.00.1002101037300.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Feb 10 18:01:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfFvv-0002kZ-BL
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 18:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755587Ab0BJRAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 12:00:52 -0500
Received: from mail-qy0-f190.google.com ([209.85.221.190]:39200 "EHLO
	mail-qy0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755351Ab0BJRAv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 12:00:51 -0500
X-Greylist: delayed 469 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Feb 2010 12:00:50 EST
Received: by qyk28 with SMTP id 28so184105qyk.25
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 09:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=KP2Duzb1etfCLJvwfuAY9g5oFJqOucOe/Wf5aVAvlTw=;
        b=lNPXHcdq3Zcd8ngG0OVZTQ1nktXHnhpSj7i+Xs9fIUtE8tPnbY2g0RTHbXFokBa3ej
         Xyt4+0MA012HfnrzwYtDKOx2+uFJQiSvmFiBRNn/p9lvVZz8OGLFUaN7qiOjCIwAl9db
         TfkdUsr0StKYvAQCrMxrNXLBNCHE7LQ4b9hV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=AoPGVlrgLcbmunH5118o0/RskzRZkmZ2eGC35mPwOc/979oVoF4Q9UAYe5kynYdyyx
         988zvxpnK8NV/h/3lJ+uxQeAnHftfhtnr0cYBPxm8dLnaubK/Jc7SP6UxbIJx9aZPzCz
         Egt8XKDvsSO+LBul5CtPkK5DsVvUoCwtBY5N8=
Received: by 10.224.48.72 with SMTP id q8mr287843qaf.2.1265820774860;
        Wed, 10 Feb 2010 08:52:54 -0800 (PST)
Received: from ?192.168.1.5? (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 7sm515473yxd.8.2010.02.10.08.52.52
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 10 Feb 2010 08:52:53 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7pre) Gecko/20091214 Shredder/3.0.1pre
In-Reply-To: <alpine.LFD.2.00.1002101037300.1681@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139518>

On 02/10/2010 08:07 AM, Nicolas Pitre wrote:
> Both the old and the new text are bollocks.
>
> There is no extra cycles involved here.  And linking this to a slow 
> connection is misleading.
>
> The point of --thin is to create a pack containing delta objects while 
> excluding the base objects they depend on when those objects are known 
> to exist in the receiver's repository already.  Because base objects 
> are usually significantly bigger than delta objects, this results in a 
> large reduction in the amount of data to transfer.

Thanks. Maybe this would more accurately describe the option?

Create a pack containing only delta objects when the base objects the
delta objects depend upon are present in the receiver's repository. This
typically results in less data being transferred. Default: on
