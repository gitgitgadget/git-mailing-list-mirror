From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH] git-format-patch: add a new format.cc configuration variable
Date: Tue, 29 Apr 2008 13:21:36 -0400
Message-ID: <76718490804291021m4d6827d3h522fe61b791ae067@mail.gmail.com>
References: <1209244746-12649-1-git-send-email-vmiklos@frugalware.org>
	 <alpine.DEB.1.00.0804262330370.7944@eeepc-johanness>
	 <20080426232737.GR4012@genesis.frugalware.org>
	 <alpine.DEB.1.00.0804271252200.16320@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Miklos Vajna" <vmiklos@frugalware.org>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 29 19:23:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqtXq-00017e-68
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 19:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759198AbYD2RVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 13:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759191AbYD2RVi
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 13:21:38 -0400
Received: from el-out-1112.google.com ([209.85.162.178]:48420 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759127AbYD2RVh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 13:21:37 -0400
Received: by el-out-1112.google.com with SMTP id n30so84391elf.21
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 10:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4Pl7pDPUPbJqr3GrqUtiBATrQk1MbyWP1UIepeVEfR4=;
        b=sZpFSErtq8YRA1lvLhgYxiSXHOYe1q7alFfLaE2MVo/9cwJ3x7LLG2WCWEi3m+IZ1V2G2fnUbR5AiG9trFy0aAG3u1mgbGqkAxYjaXBMoJse8Z5xKNzWM9To4ayL/4qFjV5Mfh5Z0IQuBerQ3pnL5GG0JTRF2XKEdh7nGrq7MI8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jVbcILm+oPTBUkOQQvs0feG5W2MQgNjGzJ+dEcfPRNVjwXGEOMrlFctu0TVS+DZZ0qJc5xfRTtYQ3XaznHtUbrvq6hA3MUP1gAOQsGLDMsayuFXHQ3805LzWHz01d4sIPai5F9iuhuKeR+mPFymfgODzprVHsJAFMOvNTimZH/M=
Received: by 10.114.103.4 with SMTP id a4mr8225972wac.172.1209489696299;
        Tue, 29 Apr 2008 10:21:36 -0700 (PDT)
Received: by 10.114.13.5 with HTTP; Tue, 29 Apr 2008 10:21:36 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0804271252200.16320@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80708>

On Sun, Apr 27, 2008 at 7:53 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>
>  On Sun, 27 Apr 2008, Miklos Vajna wrote:
>
>  > On Sat, Apr 26, 2008 at 11:31:13PM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  > > I am wary... should this not be specific to send-email?  IOW should
>  > > format-patch not be left alone?
>  >
>  > Yes and no. :-) I first searched for a --cc option in send-email, then
>  > realized that only format-patch has one.
>
>  You are completely correct, sorry.  Hmm.  I would have preferred
>  send-email inserting that header, oh well.

You can do something like:

[sendemail]
  cccmd = "sh -c 'echo address@example.com'"

j.
