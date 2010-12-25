From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: StandardInput Not Continuing Process
Date: Sat, 25 Dec 2010 10:45:45 +0800
Message-ID: <AANLkTi=2QV-pwDx1rVYVbG6zxK9mxmXQ6hMs2XvdzM0Y@mail.gmail.com>
References: <AANLkTikBdOLjzJxikXCwTs52RByfNZzKamK+F-JhY0mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Chase Brammer <cbrammer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 25 03:48:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWKBE-00081d-G9
	for gcvg-git-2@lo.gmane.org; Sat, 25 Dec 2010 03:48:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451Ab0LYCpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Dec 2010 21:45:47 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35116 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013Ab0LYCpr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Dec 2010 21:45:47 -0500
Received: by fxm20 with SMTP id 20so8186641fxm.19
        for <git@vger.kernel.org>; Fri, 24 Dec 2010 18:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=sJvz9LN8RhaIT4J7hOFns0ah9ATij3HAVPQnV9ngbj8=;
        b=qqY7oPO7DRqi5X29z9qkyNwIwDCE8UfQxl5vTywzgNMzk5xXRo3D8EpuPTdA03JPIO
         qf5zjNX0mVSKjjGKJJGdgxZG6fPmmpsU7zaFiDEV4qjyZpXYb37pN6jfoLSmSt5B9eQy
         wESfB4exSX7/HoWPBX4OI6XQNRKP8Z6znKqU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=epzKrGS2q6pT3PDXre0NfC1jkDPbJBCcpL4krz74/WjVheECfFlATq4yrZ/FH398YR
         yQEmHx3leId1z0Q6oLs4EW3heJFMX2uLXlAt47e+hQIvCmEN6uXWM6+Y6jGRcdE2LP/r
         ujHQ8r6DtzTeEZ53Empx+hskG70wnb7qvc0eI=
Received: by 10.223.72.197 with SMTP id n5mr606661faj.8.1293245145802; Fri, 24
 Dec 2010 18:45:45 -0800 (PST)
Received: by 10.223.106.138 with HTTP; Fri, 24 Dec 2010 18:45:45 -0800 (PST)
In-Reply-To: <AANLkTikBdOLjzJxikXCwTs52RByfNZzKamK+F-JhY0mQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164169>

On Thu, Dec 9, 2010 at 1:25 AM, Chase Brammer <cbrammer@gmail.com> wrote:
> For example, doing a clone from a HTTPS server may require a username/password.
> I writing the password as utf, and also tried just UTF byes (ie no
> prepended 16-bit int)
> but am unable to get the process to continue and start the clone process.

Try putting the username and password in ~/.netrc, or in the url with
https://user:pwd@foo.com/ - that way, you can skip the "input process"
altogether.

-- 
Cheers,
Ray Chuan
