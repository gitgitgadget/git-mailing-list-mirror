From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: My git repo is broken, how to fix it ?
Date: Fri, 23 Mar 2007 09:40:24 +0600
Message-ID: <200703230940.25103.litvinov2004@gmail.com>
References: <200702281036.30539.litvinov2004@gmail.com> <Pine.LNX.4.64.0703220924590.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0703220931120.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 23 04:40:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUadr-0006uo-4n
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 04:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422665AbXCWDkg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 22 Mar 2007 23:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422668AbXCWDkg
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 23:40:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:20698 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422660AbXCWDkd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2007 23:40:33 -0400
Received: by ug-out-1314.google.com with SMTP id 44so894244uga
        for <git@vger.kernel.org>; Thu, 22 Mar 2007 20:40:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=k/BMCt61TJNq1kDkAiEDwOd7RRz8NPctCk3XxUpJBQ4jsy6l5auzEVtefoCkyd0S+YNG+oYC9LVlIRrqdaaFdAuvrYuzH1h/C/qizNEURv0etyrQv0oogdbs+8vo/Hb5bz9QZ/ByX/RBMJ+URHzLrLN9qKqyWyTbVKVAENzLKDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EIqY9HkMKxatE4oGTAAmFhP+AGvjk0P7BanTu6yACSgfzVmIkfVjlWS6mFxHzhklolGpnf6waA7snTmrUHyiZa8+C4/xpwS5hFOreBfdXqjwl0hlwr+77lEX3SV2h8B/8L82ds1Hl/8cJXKVjDpuct38ubJUntcmDO6mZRPMA30=
Received: by 10.67.98.9 with SMTP id a9mr6012091ugm.1174621231773;
        Thu, 22 Mar 2007 20:40:31 -0700 (PDT)
Received: from lan.ac-sw.lcl ( [81.1.223.2])
        by mx.google.com with ESMTP id p32sm3099143ugc.2007.03.22.20.40.30;
        Thu, 22 Mar 2007 20:40:30 -0700 (PDT)
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.64.0703220931120.6730@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42900>

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 Thursday 22 March 2007 22:48 Linus Torvalds =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BB(a):
> In "try_create_file()", we do:
>
> 	...
>         if (convert_to_working_tree(path, &nbuf, &nsize)) {
>                 free((char *) buf);
>                 buf =3D nbuf;
>                 size =3D nsize;
>         }
> 	...
>
> I think the easy temporary fix is to just remove that "free()" and le=
ak a
> bit of memory. That gets it through that test with efence for me.
>
> Does that fix it for you, Alexander?

Yes, commenting out free fix repo breakage.

Thanks for help !
