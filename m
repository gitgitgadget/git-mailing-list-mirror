From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: update defaults for modern Cygwin
Date: Mon, 5 Apr 2010 09:30:53 -0500
Message-ID: <20100405143053.GA13093@progeny.tock>
References: <1270161834-9597-1-git-send-email-eblake@redhat.com>
 <7vaatmmju9.fsf@alter.siamese.dyndns.org>
 <4BB5F94F.3090403@redhat.com>
 <20100403074700.GA24176@progeny.tock>
 <4BB9E24E.4090206@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	jon.seymour@gmail.com
To: Eric Blake <eblake@redhat.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 16:30:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NynK0-0008V1-Aj
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 16:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754838Ab0DEOab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 10:30:31 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:34415 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064Ab0DEOaa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 10:30:30 -0400
Received: by pwj9 with SMTP id 9so255095pwj.19
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 07:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0kaDcEK7nKf9ce5YlaSwkCOsH1B0G3WkoWoRSwOxRj0=;
        b=KcqmebFhJYi2nzVsceerK8es+TemV27M5z42d9fMVAhK9HMbg13rtWouYrHp6Y7EMB
         TFEzZAw0MMMmOsU1hSY0LCTPU3d30knjn6lmAzazsktf60tz0e47AfxvWWkdCVYftFUU
         4Le+E+s79VReeJ1MFvl+gRYvf/OO4TEx8Hcs8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jOFcbOgHWrZ8EaKFEFa4mtEh8BFsk8u0dSFiQ+S3vmRIAacU7qbJwrv4ZGCVtorZbp
         /JcPF4WvBg3bDKzmuQblg6ybeO6gPC31w46s4THFogC1bqV92wMR3V3xqOP9GGafOzov
         NlPAqwyW/lTcP/0ZZVOJhR6mUYTosKi70yPCk=
Received: by 10.114.251.32 with SMTP id y32mr4381187wah.149.1270477829701;
        Mon, 05 Apr 2010 07:30:29 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm4620916iwn.9.2010.04.05.07.30.28
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 07:30:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BB9E24E.4090206@redhat.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143984>

Eric Blake wrote:

> Cygwin 1.6 is on par with 1.5 feature-wise, so your cutoff of 1.6 as the
> last old version is correct.

Thanks for explaining.

> ifeq ($(shell case '$(uname_R)' in (1.[1-6].*) echo old;; esac),old)

Looks good to me.

While I have your attention, do you know of a simple way to test
Cygwin programs under Linux?  setup.exe does not work well under wine,
so I am asking mostly in the hope that there is a .tar.gz or .zip
binary distribution somewhere I could play with.

Thanks,
Jonathan
