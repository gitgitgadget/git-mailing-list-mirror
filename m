From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 1/2] archive: allow remote to have more formats than we understand.
Date: Sun, 10 Sep 2006 21:18:54 +0200
Message-ID: <cda58cb80609101218m35e3ac97y5668017d2c03948f@mail.gmail.com>
References: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net>
	 <cda58cb80609101202y2ee1a18dwf09d6e104740777@mail.gmail.com>
	 <7vwt8br150.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Rene Scharfe" <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Sep 10 21:19:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMUpW-0003B5-Pi
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 21:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbWIJTS4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 15:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbWIJTS4
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 15:18:56 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:26230 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932536AbWIJTSz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 15:18:55 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1305130wxc
        for <git@vger.kernel.org>; Sun, 10 Sep 2006 12:18:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FBUNS3t27P1FOLnTKcYNqlxvKefaouHRWu+A0PTxuHRFfJsqz/qYESAfsH8VAv1x0jVxunusvkrOD1efLaAEdPpQfVe/FFmZXa/q6HieKYSeV8uFQrL707VswhOvjvTR1gic7kf9lu+jO9IQwzERyD4s9wQt3tuCrHhExvsQWF8=
Received: by 10.70.19.16 with SMTP id 16mr2811661wxs;
        Sun, 10 Sep 2006 12:18:54 -0700 (PDT)
Received: by 10.70.72.5 with HTTP; Sun, 10 Sep 2006 12:18:54 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vwt8br150.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26812>

2006/9/10, Junio C Hamano <junkio@cox.net>:
> "Franck Bui-Huu" <vagabon.xyz@gmail.com> writes:
>
> >> +static const char *remote_request(int *ac, const char **av)
> >> +{
> >
> > just to be consistent with the rest of the file, I would have called
> > this function
> > "parse_remote_arg" or "extract_remote_arg"
>
> I was thinking about calling this is_remote_request() actually.
>

that sounds like to return a boolean. You would need to pass remote as
a parameter, no ?
I think extract_remote_arg is nice because it tells you that it
returns remote option valu _and_ remove it from argv.

-- 
               Franck
