From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: ignored file can be deleted silently
Date: Thu, 5 May 2011 21:18:15 +0700
Message-ID: <BANLkTi=C4pO83mT3pO0B_AMaK3RMOC4V8g@mail.gmail.com>
References: <BANLkTinEupQKfBofhH-qKD6gLGWyWRbGvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 16:22:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHzRM-000361-Lp
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 16:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754647Ab1EEOV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 10:21:58 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44945 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754342Ab1EEOV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 10:21:57 -0400
Received: by bwz15 with SMTP id 15so1872489bwz.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 07:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=VOADY66VTa9V+8l+yoweiobz/Z4O02ODe3P9YuoEdEs=;
        b=kSa30M3+Lk8IvZY8UCTLBGXegkgHkTzyhUhI5Qq3FQT5FmDgKTBqlKT/fgw/1ia3O+
         wYuK1/NxIwWytbbD/i+enj7YeqtmykkVlpYW035oF2rJ2jlll7NnO8GOK3Mp4SZV9LIp
         da9Rag5gJQlutJnUZrltvfrjGSYDlalDiVmSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=evx4WKSN1aQYjgS3aDM7xzL03FIXD8dd9TNM7cLZDHUdyf0Jxn0wGMkVHgRLBjXNqi
         6nHOaJONRqFib6FtuMFGOWok6utkGMQ4joj6h7DuTlcS/BTbGFWe9BvkQqV1rxRP4DTT
         A/US8rdBC3YEe9aRXBYsA9vVMmZpLIaciUZnY=
Received: by 10.204.7.213 with SMTP id e21mr1341615bke.209.1304605125163; Thu,
 05 May 2011 07:18:45 -0700 (PDT)
Received: by 10.204.53.13 with HTTP; Thu, 5 May 2011 07:18:15 -0700 (PDT)
In-Reply-To: <BANLkTinEupQKfBofhH-qKD6gLGWyWRbGvw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172832>

On Thu, May 5, 2011 at 3:40 PM, Daniele Segato <daniele.bilug@gmail.com> wrote:
> I noticed that when i put a file in the git ignore If i switch to a
> branch where the file is present and versioned git delete my local
> ignored file replacing it with the content of the branch I switched
> this is done silently and the file is gone forever if I don't have a
> copy somewhere

This is on purpose. Commit f8a9d42 (read-tree: further loosen "working
file will be lost" check. - 2006-12-04) allowed ignored files to be
overwritten. Perhaps we can have a config to tighten the check again?
-- 
Duy
