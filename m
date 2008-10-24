From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git history and file moves
Date: Fri, 24 Oct 2008 23:43:15 +0200
Message-ID: <81b0412b0810241443t75e2022fg984df400585cb254@mail.gmail.com>
References: <1224640967.14280.0.camel@minggr.sh.intel.com>
	 <81b0412b0810220419q43f6985fs1c608e3d3cbcf8f3@mail.gmail.com>
	 <48FF1EDB.8010503@drmicha.warpmail.net>
	 <4911F71203A09E4D9981D27F9D8308580AA7FFFB@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Michael J Gruber" <git@drmicha.warpmail.net>,
	"Lin, Ming M" <ming.m.lin@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Moore, Robert" <robert.moore@intel.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 23:44:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtUSP-0001ES-0o
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 23:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338AbYJXVnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 17:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751669AbYJXVnR
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 17:43:17 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:11729 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbYJXVnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 17:43:16 -0400
Received: by an-out-0708.google.com with SMTP id d40so121993and.103
        for <git@vger.kernel.org>; Fri, 24 Oct 2008 14:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=7Sf1uzi6v52KwmiiqnaJD0+83Vfs6mTLcOx0e9XSLaw=;
        b=WguAVje5vr0qf33eoOSKVwZJ+iddLKgob8VU2C0i4UtR6hSCSg8hHWSNr3DFJTbzYs
         1CPQGJHHsdAN7WlpNIjlRzSa0iZto/kioLdMT+/i8I7S66T6mVXorDWI+aSfSd821kx8
         mXdsknT5VSgDX3h67vSpLZVxjVKh6DpSadJ+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=v7YBO6raDOaerNMLwGjk5M9FO+s374HBUQ7YHPPD1jl3L+qarrbj9aieNvc0PXMT+c
         9+URWHRWJYvXKTU0XPHe8WiygvnMxLJEQmD2H1INpfHvPsuwVTotiQ7ASgUEoU3KkRVL
         xmAFgiz7YMibCtwKj/R7VhxlH/433zZ9xoEB4=
Received: by 10.101.70.15 with SMTP id x15mr3442609ank.112.1224884595285;
        Fri, 24 Oct 2008 14:43:15 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Fri, 24 Oct 2008 14:43:15 -0700 (PDT)
In-Reply-To: <4911F71203A09E4D9981D27F9D8308580AA7FFFB@orsmsx503.amr.corp.intel.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99068>

2008/10/24 Moore, Robert <robert.moore@intel.com>:
> Here's what we have:
>
> /var/www/cgi-bin/gitweb.acpica/gitweb.conf
>
> Containts this : GITWEB_CSS = "/icons/gitweb.css";
>
> What should we add to automatically get all file history?
>

Nothing. It is the default. You can change the variable Michael
mentioned to use "-M -M -C -C" but it is very-very slow on any
kind of history worth its commits.

And you almost never talk about _file_ history in Git. It is all
_project_ history, filtered for commits which touch the file you're
interested in at the moment of looking.
