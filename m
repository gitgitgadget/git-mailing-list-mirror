From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Alternate .gitignore
Date: Fri, 8 Oct 2010 12:45:55 +0000
Message-ID: <AANLkTimG188_8qg-DTtJtvX-wkpotgp7+f8Bu4b4ayMn@mail.gmail.com>
References: <loom.20101008T141929-221@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Fri Oct 08 14:46:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4CL5-0002vW-46
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 14:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757302Ab0JHMp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 08:45:57 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40897 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757296Ab0JHMp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 08:45:56 -0400
Received: by iwn6 with SMTP id 6so618822iwn.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 05:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=AbVGed/PWahUoEk4xAW++f93J0mz7Y2n61kQjLYi8xY=;
        b=qpNZiGieRrE4UvOh45j/moZ99+PSI+rcn0+Sg2/gRRKnolhdcFXDWCcJr590i0z/H7
         Xn71MQsnS5oxaueyrwAEtVSzw6TH10KFryplf/dd1DnE+SUazYdugR4++OIXzEaDXQ93
         1zC5KfQwv5NIJOG5wDFqRnQiJ8wWETaXlwQNE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=HJnriO7FutQQt9xa5u/weT7tDbRNSJXbcCeC368XAPV/SY9vImZUzC5wL8wc/M61zD
         ceMRVVarHyyPd+qgGtCn1X5eJXON1g3+seWQo4ug37uYFckWYN13nBj5aKd/kUGOeBUR
         p6j9g+vWPaugMD037YRsRVsyHdLrbHMoSf6tk=
Received: by 10.231.15.8 with SMTP id i8mr2227474iba.12.1286541955402; Fri, 08
 Oct 2010 05:45:55 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Fri, 8 Oct 2010 05:45:55 -0700 (PDT)
In-Reply-To: <loom.20101008T141929-221@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158499>

On Fri, Oct 8, 2010 at 12:31, Maaartin <grajcar1@seznam.cz> wrote:
> I'm using git for a project, where I'd like to store not only the sources but
> some quite large generated files, too. However, I'd like to keep them separated,
> so my source depository doesn't grow too much. The problem could be solved
> nicely if there was a possibility to use .gitignore for the source tree and let
> say .gitignore2 for the extended tree. I'd use two depositories: .git and .git2.
>
> The content if .gitignore2 could be a subset of the content of .gitignore, so
> the extended tree would contain the sources as well, which is not really a
> problem. Or maybe I could make the depositories disjoint, I'm not sure now.
>
> Is something like this possible or is it too strange requirement?

Have you looked into storing your binaries in a git-submodule(1) ?
