From: Rustom Mody <rustompmody@gmail.com>
Subject: Re: vc in emacs problem with git
Date: Sat, 29 Aug 2009 20:07:52 +0530
Message-ID: <f46c52560908290737r53e0732o2b552665f9c07098@mail.gmail.com>
References: <f46c52560908270828o574c0de6s17189a7326a1376d@mail.gmail.com>
	 <f46c52560908270914o7027dc0bo873544dc0687cc48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 29 16:38:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhP48-0003Ge-4t
	for gcvg-git-2@lo.gmane.org; Sat, 29 Aug 2009 16:38:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbZH2Ohv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Aug 2009 10:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbZH2Ohv
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Aug 2009 10:37:51 -0400
Received: from mail-vw0-f195.google.com ([209.85.212.195]:34218 "EHLO
	mail-vw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbZH2Ohu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Aug 2009 10:37:50 -0400
Received: by vws33 with SMTP id 33so2003723vws.33
        for <git@vger.kernel.org>; Sat, 29 Aug 2009 07:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=hBeC0Y7cA2j68rlHPHZNpIp72GAfH+8iyNCJLONKb+M=;
        b=PIqc3eAtqdV1i9pOlpscZAfAmruf1TEARYh0tV8JvqHcRCvW4GHyLk2soIldh2ufGe
         H0pXzaJL164tZurlokx7i5wFDwJ2xa60ODExtDbX8u7D/pr62CuOsIXaZzS1tAt/0d14
         yMs1YUzSYkHKINywYR2QlTzC+Qyru/CFfm+6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=wT79WZZFulibl3h63DfWRC+gBq4Of2Lr2E17+17gGYHoOqW/mhYEuwiW1/PElpHOPu
         o2vnILpOCvDjMplH5HQPSf0BApNf23xjobmJYCveF5FD1u/H7kVZtCk5BaL9wyxYKANQ
         d3lrBu/pQjd2Pg18ChQhmCsSqC/iMYIQuCUUQ=
Received: by 10.220.88.15 with SMTP id y15mr2907612vcl.62.1251556672399; Sat, 
	29 Aug 2009 07:37:52 -0700 (PDT)
In-Reply-To: <f46c52560908270914o7027dc0bo873544dc0687cc48@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127381>

On Thu, Aug 27, 2009 at 9:44 PM, Rustom Mody<rustompmody@gmail.com> wro=
te:
> Just updating my own question:
> when I do a C-x v v (vc-next-action)
> which is supposed to be the most basic operation for checking in a fi=
le I get
>
> =A0Wrong type argument: stringp, nil
>
> So vc can be assumed to be a broken I guess?

Answering my own question:
Short answer: vc-git.el from git breaks vc in emacs
Long answer: see emacs mailing list discussion
 http://groups.google.com/group/gnu.emacs.help/browse_thread/thread/657=
d9c58baed7b0f#
