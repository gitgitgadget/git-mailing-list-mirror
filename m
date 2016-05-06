From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mingw: introduce the 'core.hideDotFiles' setting
Date: Fri, 6 May 2016 14:06:24 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605061404090.7829@virtualbox>
References: <17d30bb680a0452efd7b3c4f42e2f94478a86273.1462372716.git.johannes.schindelin@gmx.de> <572A20B9.7060301@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Fri May 06 14:06:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayeWv-0003mB-7A
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 14:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758655AbcEFMGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 08:06:43 -0400
Received: from mout.gmx.net ([212.227.15.19]:62200 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758534AbcEFMGn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 08:06:43 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LdHqj-1bPDur3ymf-00iSa9; Fri, 06 May 2016 14:06:25
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <572A20B9.7060301@ramsayjones.plus.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:1AaT5xfSKMJdvPfP/ZPef5q/i/H5ugrZM23TIbHWmHdRAImqATl
 IpC8u6L9aauXqutYz7HZKfXtGWdtW+AiCfG8l5mbTyWg1BjBbLYdgNDg2BHSIWwl0TWjDg+
 PKGcTUUQsNMYxjF5tP+79XEfWnCmrAtmCroFYAZ9e3n4PVOXTb6UKxS1w52EUZmhX7K2wjB
 XpXER8qOwvQb93LvjlNvA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vDzkkrLblBQ=:M74oTfhjviAcTJxOv/oKQP
 975EnaBjjhhZbm10kFa+qIbl45e5lgNX6ZzlEuJv5Qfnm2lDjDMmNCRi57xynp02AcmNGzBMB
 XZEY95Intm8B6+D0OSo3qSC4dcl2GanrhzoesbNCJqZVVBavZ864badkbQkE7XndKQONmJQc7
 wy2rrz7mYHXIHYq5NOm9Swc8yRcVXKPUynNI2ZUvmqqDiFprgdcdeh5qW0/KggoGbZsoGWlwr
 QbKmQfS8V7qRo/ejB00N9QxA+ZIv9Wm5pUQfPPOgWyRDFKgjptmHRgpP5LF+fs4dqfGIMDHJG
 6mQZIpxsWZIOjhj7DCi9zRrfPbWLoFW6RAOEtwyMDmEjcC1KMESVgXeFg8kX8OGONBMP8HFGE
 N6IJdKAGA3x9Uy4RG7WHmVynZfUhwgtqyIPt6DlGVvbt+AZXA4G47CXrYiFWrsV1BLIZgniKB
 k9h2ogJvHfykS+dJIVTmF67PKgu+jD1wLnz6hJnbRgIdCZAPSsNXb+xMPj7nkFVMI3MvhUkaD
 k0RTZAoBxQeHIUxVekNk8bi6/m9Ek/w+pLuK7O6YuUjNVck4/Pnv33BmVtKevfVg3e8tN+m8z
 ZoKt0cGAsstlqMQSk/MtT8UBaR8jao3yAIgBJhzmn61mvrjLKVSWfzkoRzNMz8k29ALtMuya/
 a7h7otffcQgKVBLYkjjca8vEN7bOBF+JNhJSwW4PlCRUBPDRgIXZhmTaaFdDVFiW2iAgWmogc
 /EwuJMwDoDnVMiecWwmbgIZJZyGYBroXCufBLURnXQGCQex/z3wRxwR4miT/5e4ckcduXeKw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293765>

Hi Ramsay,

On Wed, 4 May 2016, Ramsay Jones wrote:

> On 04/05/16 15:40, Johannes Schindelin wrote:
> > 
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index 42d2b50..a9f599d 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -269,6 +269,12 @@ See linkgit:git-update-index[1].
> >  +
> >  The default is true (when core.filemode is not specified in the config file).
> >  
> > +core.hideDotFiles::
> > +	(Windows-only) If true (which is the default), mark newly-created
> 
> The patch (if I'm reading it correctly) and the commit message indicate that
> the default is 'dotGitOnly'.

Good catch! The original version did default to "true", but we introduced
the "dotGitOnly" option later because it was too cumbersome to access
things like .mailmap and .gitmodules when they were hidden, and changed
the default accordingly. Missing the documentation update.

Fixed in the upcoming v2,
Dscho
> 
> > +	directories and files whose name starts with a dot as hidden.
> > +	If 'dotGitOnly', only the .git/ directory is hidden, but no other
> > +	files starting with a dot.
> > +
> 
> ATB,
> Ramsay Jones
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
