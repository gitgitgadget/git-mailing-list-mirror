From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: What is the difference between git-gc, git-repack and git-prune?
Date: Tue, 6 May 2008 22:53:22 -0400
Message-ID: <32541b130805061953s7ef38990r44d9966af0c8d9ea@mail.gmail.com>
References: <873aoux284.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: DigitalPig <digitalpiglee@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 04:54:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtZnJ-0007ZY-Qi
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 04:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755317AbYEGCxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 22:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755165AbYEGCxZ
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 22:53:25 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:27244 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017AbYEGCxY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 22:53:24 -0400
Received: by fk-out-0910.google.com with SMTP id 18so105972fkq.5
        for <git@vger.kernel.org>; Tue, 06 May 2008 19:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=7IF7e+XIkvgnWMtNG5cbJivISffsNf7mKM0ss9YuCO8=;
        b=PFAwBKhY3uAgCsUpHfc9RPbjEWvMLTwAZAChfyYPPwW7c2j98FS/nbmZc+24+T8ck0ZpuUD9gop1akKjr97rMNIm9UchAeukkLVwCyqygCyF0jxHtVszrXQmiNr82dcNK+5nU0dGz02oLKG5FBu4wdVmCX5Zsk1fIGpnFtXG2Vw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Oir1Se311tZmzSwde0gceWAynbi/+/U+CxHiNmnM7UtQAYY4s6zCYaIHjugX17ctUiUL2xKaG6uHzlyb64W5u6PO1rGEvoZD6DtUhG0VKz+tCd9Ch6m8o62aB/iC3B7+R8inQGuPWUk2fZED23hB6SOghbCae6b6njUm8EfzfKY=
Received: by 10.82.145.7 with SMTP id s7mr139840bud.71.1210128802541;
        Tue, 06 May 2008 19:53:22 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Tue, 6 May 2008 19:53:22 -0700 (PDT)
In-Reply-To: <873aoux284.fsf@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81401>

On 5/6/08, DigitalPig <digitalpiglee@gmail.com> wrote:
>  For git-prune, according to the manual, it will delete all the dangling
>  objects. So it is easy to understand. However, in the git-gc manpage,
>  there is another option named "--prune". Does that make git-gc do the
>  same thing as git-prune?
>
>  And manpage of git-gc says it cleans unnecessary files and compresses
>  the objects, and git-repack also compresses the objects too. Are there
>  any difference between these two operations? Or do I need to invoke
>  git-repack after running git-gc? Thanks!

git-gc is a fancy wrapper that automatically calls git-repack and
git-prune for you with the most commonly used options, so you usually
don't need to run the others yourself.

Avery
