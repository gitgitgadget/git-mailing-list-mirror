From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFH] QGit: how to cram a patch in a crowded screen
Date: Sun, 27 May 2007 17:56:05 +0200
Message-ID: <e5bfff550705270856o195b9075u1c99a05e79d69742@mail.gmail.com>
References: <e5bfff550705260146q51350f40q1c80cfe8079f47c6@mail.gmail.com>
	 <200705261034.53723.andyparkins@gmail.com>
	 <e5bfff550705261344l604543e7h64c20c1fc0979f20@mail.gmail.com>
	 <20070527153852.GA30365@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org,
	"Pavel Roskin" <proski@gnu.org>
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun May 27 17:56:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsL6i-0005A3-Pp
	for gcvg-git@gmane.org; Sun, 27 May 2007 17:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755234AbXE0P4N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 11:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755963AbXE0P4M
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 11:56:12 -0400
Received: from nz-out-0506.google.com ([64.233.162.233]:6853 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755234AbXE0P4L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 11:56:11 -0400
Received: by nz-out-0506.google.com with SMTP id n1so690579nzf
        for <git@vger.kernel.org>; Sun, 27 May 2007 08:56:10 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LyEtYj1vb2nNFUoZnGeIH3K3gkfb+FONOgxwHjWi5ROZWMUKnGazXzD18uZ8G8ZhmCz0al58VGBcS3mQxYRSxqUxi4oXv3CgyhZXTILRHtctQGx1ASV44IKwonkFJaGx5i05Di3qp74h68NlJSWvNKRZIiPSByg97ZcQzSvHCCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KDM7g7r7dIuUzeV+bYGxyXD1C0RVG3aNHsnX6M5KO9YFJrwzxxVMYT+rY2jnfOup9DvvJikbFCXN1aegexpT31MPJi0HlzsZYmR9UMhXfWMVfo2oOTxtA4u2hq5LC5V8593f+SHVqvhEqUlVCYBeoDCzcHlq6I8rkzx79jZRxs0=
Received: by 10.114.153.18 with SMTP id a18mr2460164wae.1180281370239;
        Sun, 27 May 2007 08:56:10 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sun, 27 May 2007 08:56:05 -0700 (PDT)
In-Reply-To: <20070527153852.GA30365@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48564>

On 5/27/07, Jan Hudec <bulb@ucw.cz> wrote:
> On Sat, May 26, 2007 at 22:44:28 +0200, Marco Costalba wrote:
> > On 5/26/07, Andy Parkins <andyparkins@gmail.com> wrote:
> > >
> > >For example, the log view widget would show:
> > >
> > ><Header>
> > ><Log Message>
> > ><Patch>
> > >
> > >All visually distinct to improve searching by eye (perhaps including
> > >clear separators between files patched).  Then the file list could
> > >include a "<header>" psuedo-file that would jump back to the top of the
> > >viewer.
> >
> > This seems really gitk like. Not that I don' t like it, but _if_ it's
> > possible I would prefer something a little bit more original.
>
> IMHO there's no point in being original.

True. But there's no point also in avoiding experimenting a little bit.

I've pushed some patches to use different ways to switch between diff
and messages, please read the last patch log message for a summary of
the changes.

If interested give it a try. it would be grat to hear your comment on that also.

Thanks
Marco

P.S: Perhaps the current gitk way is the best, but you'll never know
if you never try something different.
