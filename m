From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git-svn stubbornly re-creating branch "master"
Date: Sun, 29 Mar 2009 22:52:59 +0300
Message-ID: <37fcd2780903291252i19bba8ccx9dfb73e763d95b15@mail.gmail.com>
References: <20090329171347.GA26866@beczulka>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Marcin Owsiany <porridge@debian.org>
X-From: git-owner@vger.kernel.org Sun Mar 29 21:54:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo15X-0005gq-PS
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 21:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbZC2TxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 15:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752665AbZC2TxE
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 15:53:04 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:58011 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636AbZC2TxC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 15:53:02 -0400
Received: by fxm2 with SMTP id 2so1698169fxm.37
        for <git@vger.kernel.org>; Sun, 29 Mar 2009 12:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gfz9wvwvyKf5NtscXk3fdd8JZ1+9omyJUiiD475AXBM=;
        b=SBs+tjhBDYUPhoLc42P59lI1W7x1HRVX1PM4GYpLspuxR7Lnnj9zuetsH9jSUQjA0B
         BCzic6tL8jyCdAXPl+UofvEM2Ipy6t7DYfK7wEPOPJochbUCR487loia+6E0phB+UXeY
         sQ14Ka8FyYTZFXjEGZoKyQv3XuJW0EphzUd9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XGfOCHVvNCWBOD7FtHeqvyYNFmS+mfmOqQpvTuV0sV9qQ33dIrrgEkE1CZ3sF8iqhW
         /omEQcg3STjM1a+59ADbQz4iWQYf6XnpO5epmUpDHI30vXliA/IuSGycQek0+UaaBle9
         xwHTZwE07lL+enau4YYKMkYkgEqdIIU7Y1lqE=
Received: by 10.86.31.18 with SMTP id e18mr3686794fge.72.1238356379827; Sun, 
	29 Mar 2009 12:52:59 -0700 (PDT)
In-Reply-To: <20090329171347.GA26866@beczulka>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115032>

On Sun, Mar 29, 2009 at 18:13:47 +0100, Marcin Owsiany
<porridge@debian.org> wrote:
>
> As you can see, "master" sprang back to life after the last command.

It looks like git-svn does not like a repo without 'master'. It seems
the problem was caused by this patch:
http://git.kernel.org/?p=git/git.git;a=commit;h=1e889ef36c45b5554f7e317493ed3f4f901f8d9f

I have added Eric to CC...

Dmitry
