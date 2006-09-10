From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: [PATCH] git-upload-archive: add config option to allow only specified formats
Date: Sun, 10 Sep 2006 21:07:36 +0200
Message-ID: <cda58cb80609101207y420bd034n9a76b661374e1edf@mail.gmail.com>
References: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net>
	 <7vk64ctctv.fsf@assigned-by-dhcp.cox.net>
	 <7v1wqkt2v4.fsf_-_@assigned-by-dhcp.cox.net>
	 <20060910155837.GA15974@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 10 21:08:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMUez-0001Nv-5B
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 21:08:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbWIJTHi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 15:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbWIJTHi
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 15:07:38 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:64100 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932513AbWIJTHh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 15:07:37 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1302634wxc
        for <git@vger.kernel.org>; Sun, 10 Sep 2006 12:07:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Bgn4f5it4kx03tu2dMmg5qkVyajlihxW8g9NapNQRC+sHu1ICBziZvhZjjDA/Wfr4fjgFTEQF6kH64x5EebRYwSv38UFFWhIxV+oqrH/jEVEvDVqDhzSRx11UJ+HKA/1oEHE32Ta9KI4qa3FdnusLmoshKyMGc6vQHoF/kojgiw=
Received: by 10.70.29.14 with SMTP id c14mr4532546wxc;
        Sun, 10 Sep 2006 12:07:36 -0700 (PDT)
Received: by 10.70.72.5 with HTTP; Sun, 10 Sep 2006 12:07:36 -0700 (PDT)
To: "Rene Scharfe" <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <20060910155837.GA15974@lsrfire.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26809>

2006/9/10, Rene Scharfe <rene.scharfe@lsrfire.ath.cx>:
>  Documentation/config.txt |    5 +++++
>  builtin-upload-archive.c |   39 +++++++++++++++++++++++++++++++++++++++
>  daemon.c                 |    2 ++
>  3 files changed, 46 insertions(+)

[snip]

>
> +       if (!upload_format_allowed(ar.name)) {
> +               free(daemon_formats);
> +               die("upload of %s format forbidden\n", ar.name);
> +       }

just out of curiousity, why "free(daemon_formats)" right before a "die()" ?

-- 
               Franck
