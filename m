From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] Documentation: Fix git.7 dependencies.
Date: Fri, 19 Jan 2007 20:38:52 +0100
Message-ID: <8aa486160701191138v7fc29e53xbf809b1495e30b3d@mail.gmail.com>
References: <873b67735m.fsf@gmail.com>
	 <7vbqkuhlhi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 19 20:39:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7zZh-000154-UL
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 20:38:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932862AbXASTiz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 14:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932844AbXASTiz
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 14:38:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:22352 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932862AbXASTiy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 14:38:54 -0500
Received: by ug-out-1314.google.com with SMTP id 44so535652uga
        for <git@vger.kernel.org>; Fri, 19 Jan 2007 11:38:53 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q4kQTPJkrRQpGye7bGOj3ZUPyA51wsmttx2Ieio4jSA6cdKKrF7sVj+Nm4o8WaOhsRgSKnfMnmZrfuBb+hnMhRVkFzDNgONHTSL5S43S3UxAgsuyUtB/drCJGlW68s+6gYfnvpP1oAqaoqicgWFwWmMMdoLJFyENROvC8GVT2UY=
Received: by 10.82.162.14 with SMTP id k14mr962831bue.1169235532805;
        Fri, 19 Jan 2007 11:38:52 -0800 (PST)
Received: by 10.78.68.8 with HTTP; Fri, 19 Jan 2007 11:38:52 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vbqkuhlhi.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37195>

On 1/19/07, Junio C Hamano <junkio@cox.net> wrote:
> > -git.7 git.html: git.txt core-intro.txt
> > +git.7 git.html: git.txt core-intro.txt $(cmds_txt)
>
> I do not think this is needed; doesn't doc.dep catch cmds_txt as
> well?

It's not needed. I didn't see the doc.dep.

Santi
