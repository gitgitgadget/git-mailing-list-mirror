From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: builtin-fetch code with messy history
Date: Tue, 19 Jun 2007 12:13:06 +0200
Message-ID: <81b0412b0706190313g74765babk38309dd838f3f585@mail.gmail.com>
References: <Pine.LNX.4.64.0706190255430.4740@iabervon.org>
	 <Pine.LNX.4.64.0706191037590.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Daniel Barkalow" <barkalow@iabervon.org>, git@vger.kernel.org,
	"Junio C Hamano" <junkio@cox.net>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 19 12:13:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0ai1-0000BF-O2
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 12:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755923AbXFSKNL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 06:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755910AbXFSKNJ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 06:13:09 -0400
Received: from ik-out-1112.google.com ([66.249.90.180]:61745 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755682AbXFSKNH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 06:13:07 -0400
Received: by ik-out-1112.google.com with SMTP id b32so1530302ika
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 03:13:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=elkGTONm+tGfpA+U2I95v1s+DLDFNX8mXS0c4BWlb84l1mWhdjRDNU3OO6U+jzSy+zCg04fp43DYsyX+o7IhllJgPawatXqPJ7WzxxTMaWUbt86aQG4H9/X18qRDJZbP8Lv5VUfQvSX7Pp4gBcnG/bPYjGXO2EgJXl0lRirnpDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oaSR++/8zpfRaJsPsZ6f4pZdsEx94eVCrq4MgOjAkyD4ztvyJkBretfEm+cPZI4cy2SSR4hZzfngjHiN/d4UthPOhqncBQ0OGJ89BlQShf+bPOAMwoxkNlF92mYVGVrrovb/57tdY6Wr/7Kp7hHnurvWD/Vf9b5a9Se5lJOCnVc=
Received: by 10.78.183.15 with SMTP id g15mr2747496huf.1182247986607;
        Tue, 19 Jun 2007 03:13:06 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Tue, 19 Jun 2007 03:13:06 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0706191037590.4059@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50466>

On 6/19/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >  * when a branch config file section refers to a branches/* remote, the
> >    merge setting is used (if one is given), even though this isn't useful
> >    either way.
>
> Maybe this is the right time to cut off branches/* and remotes/*?
>

Seconded. Don't use the remotes/ since some months now.
But... isn't a git package with code of something like 1.4.4 is still
in some major distributions?
