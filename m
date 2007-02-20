From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 20 Feb 2007 14:30:54 +0600
Message-ID: <200702201430.54852.litvinov2004@gmail.com>
References: <7v7iudz33y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 20 09:31:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJQOy-0004QV-Bg
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 09:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965294AbXBTIbF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 20 Feb 2007 03:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965301AbXBTIbF
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 03:31:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:44822 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965294AbXBTIbD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Feb 2007 03:31:03 -0500
Received: by ug-out-1314.google.com with SMTP id 44so739752uga
        for <git@vger.kernel.org>; Tue, 20 Feb 2007 00:31:02 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qdOUEVXN7eaxl0NHqQCA2vfLefT4cm2Styzqy6b/hPufDFOWftCiohub6MzQyUtaIZKPHByVhHDXHQySmbXqW0fEj6QWWqfZyXYdq8Q23GZu0rWC8i0wsxVsBhlodF5Q4CZT+Oyx9RO0tv5hjMg8bEvHaO9AxYVStasgnOCTw+g=
Received: by 10.67.40.12 with SMTP id s12mr1456603ugj.1171960262410;
        Tue, 20 Feb 2007 00:31:02 -0800 (PST)
Received: from lan.ac-sw.lcl ( [81.1.223.2])
        by mx.google.com with ESMTP id 39sm8330004ugb.2007.02.20.00.31.00;
        Tue, 20 Feb 2007 00:31:01 -0800 (PST)
User-Agent: KMail/1.8
In-Reply-To: <7v7iudz33y.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40210>

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 Tuesday 20 February 2007 13:42 Junio C Hamano =D0=BD=D0=B0=D0=BF=D0=
=B8=D1=81=D0=B0=D0=BB:
>
> * lt/crlf (Sat Feb 17 12:37:25 2007 -0800) 4 commits
>  + Teach core.autocrlf to 'git apply'
>  + t0020: add test for auto-crlf
>  + Make AutoCRLF ternary variable.
>  + Lazy man's auto-CRLF
>
> The above two series are to help MinGW and people who suffer
> from CRLF in general.  I think they are good enough for general
> consumption now.  Will perhaps push them out sometime this week.

I use the auto crlf convertion as far as Linus made it. Under cygwin it=
 works=20
and I have not seen any problems except converting repo from \r\n to \n=
=20
style. Convertion produce a lot of confilcts then merge branches.

All other sides of git I am using works well.
