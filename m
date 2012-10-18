From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new git-remote-hd helper
Date: Thu, 18 Oct 2012 11:10:35 +0200
Message-ID: <CAMP44s3+FP2N4iEmxzcu_ayUAF+XWmKdBFDCvFvj6D5RQmN+5Q@mail.gmail.com>
References: <1350478721-3685-1-git-send-email-felipe.contreras@gmail.com>
	<20121017225913.GC21742@sigill.intra.peff.net>
	<CAMP44s0+Fhtj2rMQ1Av-49Koa=DumX8JZs5angOFSRzqtDc+9Q@mail.gmail.com>
	<CAMP44s1b=dNaCbm1WkFBv6368Y+jDYdkPuscEFdiUnVJBStfVg@mail.gmail.com>
	<CAGdFq_hsCjL5uunwg=N-y+FkFt-ZxORtrEcxAAHt-rDfA04cZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 11:10:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOm82-0008QM-Tk
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 11:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754922Ab2JRJKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 05:10:38 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:64260 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754909Ab2JRJKg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 05:10:36 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so8365790oag.19
        for <git@vger.kernel.org>; Thu, 18 Oct 2012 02:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/xdSVEt7/+lhryCp4n4SEcMRXBTovjKPwxGTkkMbzzE=;
        b=PV+hmke6kcNnM34WSWiNyWODxFVGPuybRNxnfw5lrut1LKZZErXJvu9bIXo6yGeUX7
         sbFGL0bgtoWh8qT9o0fGsunv+uVtGNGSNpQp1z3xlMd5ivMasvlV7PBgZHAdMHjWR0T1
         NgXNoSln0gxeSA6EKlPxXeTjq0TcSBUNRUVUyajC+XZs1RntKrWkrUNl6/hITYi9JAzQ
         qw+oku1ILxWGcyGlX6P4pB5xSrKuhl8Jze+3d2VipV4KtqF0/kVxNnhhS78gqAha/czM
         GL7QmzEK1t6JeT7w2qw7rvp3XWuzl8OV6LiFYezW+oHEZAFbJ0JffE2edgg+a/1l7NET
         y9jw==
Received: by 10.60.32.19 with SMTP id e19mr18769046oei.9.1350551435637; Thu,
 18 Oct 2012 02:10:35 -0700 (PDT)
Received: by 10.60.58.137 with HTTP; Thu, 18 Oct 2012 02:10:35 -0700 (PDT)
In-Reply-To: <CAGdFq_hsCjL5uunwg=N-y+FkFt-ZxORtrEcxAAHt-rDfA04cZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207981>

On Thu, Oct 18, 2012 at 8:12 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Wed, Oct 17, 2012 at 10:18 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Right now I've just added an error when using remote repositories. But
>> it seems there's no way around it; if we want to have support for
>> remote repos, we need to make a local clone.
>
> My git-remote-hg does the local clone into .git/ using a hash of the
> url (although you could just as well use urlencode, basically any way
> to safely use a url as a directory name). Have a look if you want.

Can you point to the version you are talking about? I've been checking
the remote-hg branch of fingolfin.

https://github.com/fingolfin/git/tree/remote-hg/

-- 
Felipe Contreras
