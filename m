From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Actually support embedded Qt, make configuration code more robust
Date: Sat, 27 May 2006 08:22:04 +0200
Message-ID: <e5bfff550605262322t70951ba9red00a12e04512aad@mail.gmail.com>
References: <20060527022735.5879.58043.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 27 08:22:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjsBh-0000WN-6g
	for gcvg-git@gmane.org; Sat, 27 May 2006 08:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWE0GWH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 02:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWE0GWH
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 02:22:07 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:45436 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750954AbWE0GWF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 May 2006 02:22:05 -0400
Received: by wr-out-0506.google.com with SMTP id i21so196242wra
        for <git@vger.kernel.org>; Fri, 26 May 2006 23:22:05 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fhjxB3FCX9wQ3A9xtAF2UOg4kKgbNlYLlGCfa6SvlHB9comhte/rzdOW0v52fG2Oo6DuYdU/ktGPJnAQeSaUo7EFmSXU1AcawoKHg3b8bZHADDdAAHBmZdXyKocRhTJMLkUYX7KEJHne6+hJ6Ra4vnzqY9fHpvZFbSpLmkkkzvk=
Received: by 10.64.131.14 with SMTP id e14mr63529qbd;
        Fri, 26 May 2006 23:22:04 -0700 (PDT)
Received: by 10.65.163.7 with HTTP; Fri, 26 May 2006 23:22:04 -0700 (PDT)
To: "Pavel Roskin" <proski@gnu.org>
In-Reply-To: <20060527022735.5879.58043.stgit@dv.roinet.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20836>

On 5/27/06, Pavel Roskin <proski@gnu.org> wrote:
> Add -DQWS and -fno-rtti flags for embedded Qt.
>
> Don't add X11 flags for embedded Qt and threading specific flags for
> non-multithreaded Qt.
>
> Before checking for the Qt library, make sure it actually exists in the
> Qt library path and not elsewhere.
>

Thanks, patch applied.

Please note that qgit public repository has changed. It is now
git://git.kernel.org/pub/scm/qgit/qgit.git

   Marco
