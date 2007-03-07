From: "Mark Levedahl" <mlevedahl@gmail.com>
Subject: Re: [PATCH] git-bundle: fix pack generation.
Date: Wed, 7 Mar 2007 11:34:15 -0500
Message-ID: <30e4a070703070834s3dd5bdd7x2e1639aa2979d1cf@mail.gmail.com>
References: <45ECEB40.4000907@gmail.com>
	 <7vejo2stlw.fsf@assigned-by-dhcp.cox.net> <45EE1242.8080405@gmail.com>
	 <7vhcsxkb8n.fsf@assigned-by-dhcp.cox.net> <45EE2ECA.60403@gmail.com>
	 <Pine.LNX.4.63.0703070419410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <45EE36A1.30001@gmail.com>
	 <Pine.LNX.4.63.0703070504140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 07 17:34:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOz5x-0007mJ-PF
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 17:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbXCGQeX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 11:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbXCGQeX
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 11:34:23 -0500
Received: from mu-out-0910.google.com ([209.85.134.191]:38663 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965153AbXCGQeW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 11:34:22 -0500
Received: by mu-out-0910.google.com with SMTP id g7so236279muf
        for <git@vger.kernel.org>; Wed, 07 Mar 2007 08:34:20 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HM2vPWmL2iHBvw00iS5yyh1QH0VkpKFB1WsGNLWGRJoqWPVLSIZJExW+FkFr9UO4wKjCdmNjBs0dUDoHOzizRiLdv9I5vn+yKaGvUG9zGyG1BmkPseiDQFHq/xLC8o4l8xqXEQ/bYavH0AjdXg1eumeArVxmbZgiHyDjLDFaiK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OWM0nhsUC+arWzNYbEJllsowjFPW/xppU3HkdvzPiBdbpDI3R4FkhTut6v3cKFfr6ZFA+nXHHCwRJPMJiWsfjElvd6CrG8yUD6pBb4V+goSBnxa/KCqKCAObtJ93preOMD4Yn27iviaeBQZJSgxo5sYCE729501L3pVHbcgj/wY=
Received: by 10.82.177.3 with SMTP id z3mr9506436bue.1173285260570;
        Wed, 07 Mar 2007 08:34:20 -0800 (PST)
Received: by 10.82.186.1 with HTTP; Wed, 7 Mar 2007 08:34:15 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0703070504140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41674>

On 3/6/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> >
> > git-bundle create test.bdl HEAD --since=1.day.ago  ==>> pack with 1531
> > objects
>
> Did you test with "--since=1.day.ago HEAD", i.e. with the correct order? I
> know you'd like the options to be interminglable, but "HEAD" really is not
> an option, but an argument.
>

Changing the order of arguments makes no difference, same result either way.

Mark
