From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: GIT_ONE_FILESYSTEM inclusion?
Date: Wed, 24 Mar 2010 12:37:39 +0100
Message-ID: <81b0412b1003240437n799bac07sb74db749d647817d@mail.gmail.com>
References: <20100323232055.GV7038@pixar.com>
	 <81b0412b1003240229l6f7eaa18l563c3d7ba0cf6cc5@mail.gmail.com>
	 <4BA9DCDD.6060109@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Damerow <lars@pixar.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 24 12:37:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuOuC-000067-JN
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 12:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755644Ab0CXLhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 07:37:43 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:59628 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755464Ab0CXLhm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 07:37:42 -0400
Received: by bwz1 with SMTP id 1so2754713bwz.21
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 04:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=3LQYwcHlYN/yYh2KtpBbvIV0L8BDPZ+Zu7SCH/u2SEk=;
        b=t28olgWtleJaNlhmY7JcXCbY2ZQ+9A7cbjJ73XJY2G5cW7XMcN+M3/XC6KBzgeTm+U
         okh4X2L4HVP0u1FIZlXm5NmmaoHXahwel6/DEPnb55EcfJfPzcWyYz3LmqFgmCPH0Byu
         9fGLYI/c8SbvasYORvkPRVq5nswngrU6mAO3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Jc041Sj7qv1xnQV7bWvliwUFx/WS8YYVXS9Q4p8ohdxD4EfhFFBTzUHU0G5Aw1sOk4
         IX5J0k5GkE19rGrz58M5+GtnuJw7ZZS4/PqTjX+EIE60QHA3DpYbq01rKcqhuJZOq/zp
         cKgL2TRD9Up4a6Y5gfgMsmOugEZ6S+409O0SY=
Received: by 10.204.127.70 with SMTP id f6mr3958161bks.76.1269430659921; Wed, 
	24 Mar 2010 04:37:39 -0700 (PDT)
In-Reply-To: <4BA9DCDD.6060109@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143081>

On Wed, Mar 24, 2010 at 10:35, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 3/24/2010 10:29, schrieb Alex Riesen:
>> And while at it, how about making it a config option? (i.e. core.oneFilesystem?)
>
> It's difficult to have this as a config option when you are looking for a
> repository... ;)
>

Isn't it a little pointless to look for repository when you can't
access its config?
