From: "David Ho" <davidkwho@gmail.com>
Subject: Moving a file back to an earlier revision.
Date: Fri, 31 Mar 2006 16:13:13 -0500
Message-ID: <4dd15d180603311313t7781f2ebk616276e9134f6472@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Mar 31 23:14:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPQwK-0004Cx-3h
	for gcvg-git@gmane.org; Fri, 31 Mar 2006 23:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWCaVNR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Mar 2006 16:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWCaVNQ
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Mar 2006 16:13:16 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:58515 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932382AbWCaVNO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Mar 2006 16:13:14 -0500
Received: by zproxy.gmail.com with SMTP id k1so971489nzf
        for <git@vger.kernel.org>; Fri, 31 Mar 2006 13:13:13 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mOvSScCY3p30lgJq+WoYId6Ni5E1kizXCo5+CPpg5ogVVXJPOpDYoRBlYZ0KtIrh+Vgs18lNoaodSY0BCD10i82au72clz+FdMBuzpjtBOwdaufY/aYzGsBieyxZ8hCnZdxkjgRiz6yDwVL04jZ3F24gSCIo4t15FHts71uASNE=
Received: by 10.64.209.3 with SMTP id h3mr464594qbg;
        Fri, 31 Mar 2006 13:13:13 -0800 (PST)
Received: by 10.65.22.11 with HTTP; Fri, 31 Mar 2006 13:13:13 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18233>

Hi,

Another user question.  Other may actually have similar needs.

I am working on a board port on a separate branch.  The branch has
accumulated several revision of changes to a driver I worked on.  Now,
someone has come along with a better fix so I want to help test his
patch.  To do that I have to revert my changes to that driver (several
revisions back) before I can apply his patch.

What would be a convenient way to do that with git?

TIA, David
