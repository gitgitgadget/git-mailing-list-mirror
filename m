From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: [RFC PATCH] gitweb: Support filtering projects by .htaccess files.
Date: Mon, 3 Nov 2008 20:26:44 +0300
Message-ID: <bb6f213e0811030926n32c1befcj5d9add6378f7dce4@mail.gmail.com>
References: <200811031943.30033.angavrilov@gmail.com>
	 <200811031754.00545.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Francis Galiegue" <fg@one2team.net>
X-From: git-owner@vger.kernel.org Mon Nov 03 18:28:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx3Db-0007KE-VG
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 18:28:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbYKCR0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 12:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbYKCR0p
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 12:26:45 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:13492 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbYKCR0p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 12:26:45 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2695720rvb.1
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 09:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=sxkAu6lpxLzTetSwB1XrZCh4hSXkKvM0x6vxLoCNNDA=;
        b=iXnVL4SWXzhuUHCqhWIX9aSWWOELJ52EhSWEtuGpWlmnpQMG1axaq7ITBbzbB/LPgW
         pJr2AYVGyWXIyN5b2uZw7G90Tfvid71d74KFg5opJQBE8UlEU4l3to9zk+43J8RRhON5
         0Z82WEbEexQVxhnLRt5fPgd3IB6w6zBey4p9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=YSZNPUbUIDvZQvJsaBqW7QYHd1bsMAXAfa4J527ZfjcMdmOYZ4+yLq5AvKDOK6ieBo
         gRX9oYlJV/XYtqpUHz/9LuIOroNBrrNrrbFWMbZzMWK7EGEUEgEmJhCHemj5WijyFjNN
         iop8omeWjFb3BUK5vCd+TCwkZsF0D1gER/sQs=
Received: by 10.142.231.7 with SMTP id d7mr182427wfh.246.1225733204087;
        Mon, 03 Nov 2008 09:26:44 -0800 (PST)
Received: by 10.142.216.21 with HTTP; Mon, 3 Nov 2008 09:26:44 -0800 (PST)
In-Reply-To: <200811031754.00545.fg@one2team.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99965>

On Mon, Nov 3, 2008 at 7:54 PM, Francis Galiegue <fg@one2team.net> wrote:
> It just seems to me that this is emulating functionality that multiple Web servers already provide...
>
> What's more, knowledge about these Web servers are _much_ more widespread than knowledge about gitweb.
>
> Why reinvent the wheel?

If you are speaking of web servers as in 'GitHub', then it is
irrelevant, because its server software is nonfree.

If you are speaking of web servers as in 'Apache', then how would it
know which files are going to be accessed when it executes
cgi-bin/gitweb.cgi?p=very/private/project.git to check permissions?

Alexander
