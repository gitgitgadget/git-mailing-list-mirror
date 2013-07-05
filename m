From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH v9 1/5] t4041, t4205, t6006, t7102: use iso8859-1 rather
 than iso-8859-1
Date: Fri, 5 Jul 2013 12:00:11 +0400
Message-ID: <20130705080011.GB32072@ashu.dyn1.rarus.ru>
References: <cover.1372939482.git.Alex.Crezoff@gmail.com>
 <cover.1372719264.git.Alex.Crezoff@gmail.com>
 <cover.1372939482.git.Alex.Crezoff@gmail.com>
 <38cdab6c314e858ec580b1d0fbf87098c2d92cb0.1372939482.git.Alex.Crezoff@gmail.com>
 <7vy59la4gn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 10:00:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv0wJ-0001nE-Sx
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 10:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757149Ab3GEIAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 04:00:17 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:35017 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757096Ab3GEIAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 04:00:16 -0400
Received: by mail-la0-f43.google.com with SMTP id gw10so1870180lab.30
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 01:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+WGeRnRahTUQi18XkIdyJed6+O2nx0L8IcGwtIxvVdU=;
        b=lIBGFXT3ysX0zicRoH+Gq3kFZeeX9v15C4KWNgA0mx0bSyQ9LlYjKOP/MF9Rqym1sU
         Nt5eG/QkHxILH8hOC3auUORU4vAcodxJdI+UNpCaNQT7gqFZP2QGbVZa7QufhDtm2CwT
         Xm+xWhwQ+wZrzig8R+ouvGnxtRiefJ+yO5xqEqcNoEiBF3iSlcER54P5EQU+g+TPUFhA
         Kra3qhXhsRwLpkzEL6GqfVNTk1y4PINCryXgMcnkPXCVKlGEq0v8oGUG31WsLd4enU4/
         i3b/3S97m+ynr6/lPIJsEv2G4kCif6nsuNXWIu6j8ZSjDqDKnzej9JbYAvXKvUzivIy3
         2MCA==
X-Received: by 10.112.4.4 with SMTP id g4mr5113744lbg.64.1373011214358;
        Fri, 05 Jul 2013 01:00:14 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id i9sm2406910lai.4.2013.07.05.01.00.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jul 2013 01:00:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vy59la4gn.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229633>

On Thu, Jul 04, 2013 at 11:47:04PM -0700, Junio C Hamano wrote:
> Alexey Shumkin <alex.crezoff@gmail.com> writes:
> 
> > This is actually a fixup of de6029a2d7734a93a9e27b9c4471862a47dd8123,
> > which was applied before final patch series was sent.
> >
> > Also, see 3994e8a98dc7bbf67e61d23c8125f44383499a1f for the explanation
> > of such a replacement.
> 
> These are not very useful in a log message.  People who read the
> history 6 months down the road would want to see why we want to use
> iso8859-1 not iso-8859-1 explained.
> 
> 	Both "iso8859-1" and "iso-8859-1" are understood as latin-1
> 	by modern platforms, but the latter is not understood by
> 	older platforms;update tests to use the former.
> 
>         This is in line with 3994e8a9 (t4201: use ISO8859-1 rather
> 	than ISO-8859-1, 2009-12-03), which did the same.
Yep, it whould be better, I thought to do like this but I didn't )
> 
> > Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
> > Reviewed-by: Johannes Sixt <j.sixt@viscovery.net>
> 
> I do not recall this exact patch reviewed by J6t, but perhaps I
> missed a message on the list?
I've reread 'SubmittingPatches' doc, and I can say I used "Reviewed-by"
incorrectly. Sorry for this. It must be "Suggested-by" there, I guess.


-- 
Alexey Shumkin
