From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: Gitweb and submodules
Date: Fri, 27 Jul 2007 16:31:42 +0200
Message-ID: <8c5c35580707270731l1fa5bd1dw94c9955d314b4ce6@mail.gmail.com>
References: <200707271322.50114.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 16:31:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEQr7-00023z-VS
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 16:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932749AbXG0Obq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 10:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbXG0Obq
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 10:31:46 -0400
Received: from nz-out-0506.google.com ([64.233.162.231]:56176 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932184AbXG0Obp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 10:31:45 -0400
Received: by nz-out-0506.google.com with SMTP id s18so749334nze
        for <git@vger.kernel.org>; Fri, 27 Jul 2007 07:31:43 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AxtbqZm8VWZ32CH0rpe9M9EDTHQPcbTADxrxFJphhMG0ybpsyDQluAMaD6hbKhh3RCuqrwPSA/Y0Maug0wFSgGaUUd1DZb06KSU5An6uP7Xlnn9myKzkBIYh2b2yIQpMPOZ+hvFreGyLX3qqGagZnc+wrxUt8bD455Sjiy4Vltg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JYtegm0llN2CLGWL6K/S7An1smQ65OP+75WaDvLS362F/34kCDGgLky+XOzdcnDIeik3RZ9OuCRlPsRXPyQlzp5/lraELjX8LVvakSnEDNKmFHM6b2LZPjxxDRzk2L+P16bPNd0kgtgoz/CWVOdVOk1kNQ1n+m2e3BE5+3rFKz0=
Received: by 10.114.144.1 with SMTP id r1mr2979964wad.1185546702495;
        Fri, 27 Jul 2007 07:31:42 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Fri, 27 Jul 2007 07:31:42 -0700 (PDT)
In-Reply-To: <200707271322.50114.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53928>

On 7/27/07, Jakub Narebski <jnareb@gmail.com> wrote:
> I'd like to add submodule support to gitweb, among others marking
> submodules as such in the 'tree' view and adding 'log' view link to
> them.

A bit of advertising:
  http://hjemli.net/git/cgit/tree

The implementation can be found here:
  http://hjemli.net/git/cgit/tree/ui-tree.c#81

> But for that I need a question answered: how to find GIT_DIR of
> repository which contains submodule objects?

Generally, you can't. But if you just want to show the log of the
submodule path, you probably don't need to do anything at all (except
the special handling in 'tree' view). If you do want to show the log
of the referenced repository, I guess a new entry  in .gitmodules
could be helpful.

--
larsh
