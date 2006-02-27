From: "Jim MacBaine" <jmacbaine@gmail.com>
Subject: Re: cg-status and empty directories
Date: Mon, 27 Feb 2006 19:39:51 +0100
Message-ID: <3afbacad0602271039v21a255adndb7a2cbd2992c67a@mail.gmail.com>
References: <3afbacad0602270643k9fdd255w8f3769ad77c54e65@mail.gmail.com>
	 <44031941.1020806@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 19:40:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDnHo-00070E-0V
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 19:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWB0Sjx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 13:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWB0Sjx
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 13:39:53 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:32489 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751510AbWB0Sjw convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 13:39:52 -0500
Received: by zproxy.gmail.com with SMTP id x3so959349nzd
        for <git@vger.kernel.org>; Mon, 27 Feb 2006 10:39:52 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nK7jhMDQIY5WBW6v/JofQ7sZKlmMBI86ItBuMG0XHw9kqMcfOdQNEYXLq+xBqpdVNf7S2rzGSZU33KgLQOqf9P4zGWnD2SgyaUFEZttpWDYmUR+heMOSThmeEobdMZlJAMyxU1Z1FdZWCp1fwNufPWD98Gn6lqctqlCquPBFN48=
Received: by 10.36.220.52 with SMTP id s52mr7050366nzg;
        Mon, 27 Feb 2006 10:39:51 -0800 (PST)
Received: by 10.36.17.8 with HTTP; Mon, 27 Feb 2006 10:39:51 -0800 (PST)
To: "Andreas Ericsson" <ae@op5.se>
In-Reply-To: <44031941.1020806@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16872>

On 2/27/06, Andreas Ericsson <ae@op5.se> wrote:

> I'm afraid not.
>
> You should also note that git doesn't track permissions exactly. It just
> notices an execution bit and uses it to determine if it should write the
> working tree using (0666 ^ umask) or (0777 ^ umask). This makes it
> fairly unsuitable for /etc tracking unless you add some sort of
> permission restoring thing to it.

I'm aware of those limitations. It is not a backup mechanism at all
and permissions are handled by a small perl script.

However, I'm just curious to know, why cg-status suddenly started to
care about empty directories.

Regards,
Jim
