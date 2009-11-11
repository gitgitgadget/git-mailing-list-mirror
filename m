From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: t5541-http-push hanging
Date: Wed, 11 Nov 2009 23:47:33 +0800
Message-ID: <be6fef0d0911110747k219e1fe0l7bd19bbc58b5ea3e@mail.gmail.com>
References: <B17AB159-E217-4E1F-BEA3-97E5892C13F4@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 16:47:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8FQ3-0000h5-Fp
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 16:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757435AbZKKPr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 10:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756987AbZKKPr2
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 10:47:28 -0500
Received: from mail-iw0-f178.google.com ([209.85.223.178]:49092 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125AbZKKPr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 10:47:28 -0500
Received: by iwn8 with SMTP id 8so997297iwn.33
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 07:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=mLrCY43TOvrEs+N3AzoKpd/Z13+Vnd0AbQJBlxEk9DI=;
        b=gm1r99al+ypcrYxu10daTUcpwQJMXYVmaslKtkb2BIGypQT8JDhviMQYT1jDi7Tk59
         WkWAq72X+8N36XR4skJtBbCR2tgJiHZXWpYIgqvgPifGXYFMrv4XJFOpB/8+zghA5kLD
         2QaIJvQgnnGYc5tFxqBYa1o9YcgtlaehXt4Ok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=R56zWh7388JbDy9U+TzUJSVxd5S4uA6drSNmRGLI+oKhZq8PMbFw1OzzeEP2kYJYJ1
         El+uU1s2+gWJv7BrwD3XyMpPNdFA2YATZkJH36xf0guz74K4coWDYneGc7wjDNNXlZ1u
         luS/bcHEpiv6tJmphyYXFOMe5N1J/syzutApE=
Received: by 10.231.157.131 with SMTP id b3mr561133ibx.19.1257954453344; Wed, 
	11 Nov 2009 07:47:33 -0800 (PST)
In-Reply-To: <B17AB159-E217-4E1F-BEA3-97E5892C13F4@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132665>

Hi,

On Wed, Nov 11, 2009 at 2:28 PM, Brian Gernhardt
<brian@gernhardtsoftware.com> wrote:
> error: RPC failed; result=22, HTTP code = 500
> ^CFATAL: Unexpected exit with code 130

looks like an apache/http-backend issue. What version of apache are you running?

Also, are you running out of the 'next' branch?

-- 
Cheers,
Ray Chuan
