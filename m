From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git history and file moves
Date: Wed, 22 Oct 2008 13:19:26 +0200
Message-ID: <81b0412b0810220419q43f6985fs1c608e3d3cbcf8f3@mail.gmail.com>
References: <1224640967.14280.0.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>
To: "Lin Ming" <ming.m.lin@intel.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 13:20:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsblY-0006Y6-P9
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 13:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbYJVLT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 07:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbYJVLT2
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 07:19:28 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:49984 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbYJVLT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 07:19:27 -0400
Received: by an-out-0708.google.com with SMTP id d40so165939and.103
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 04:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=+YE9dQ/yRXMGSggPXT4sMKrNDPQPrRZdPMiydMU96d0=;
        b=A0+XamX7E+Xv9+xpva9db19X3J9WXYhtMqv0M5dvWuW6fUEl1sI+4jPnCbPctQco5k
         RKyplW3rpJIplAPfhSFJui+vkIfTf+Pv1zRvm6eaIHHSan2+5Oyew9ndcMXRXuCKSmxy
         ydzQ1/w6as++JAAbApfA87ZyMlu1fLmjdLGC8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=VZWLUxKjCyA86oDwA4VmuwAKS9/N6ptjqnPp0OG8tCCIYHlc5gAc9g3f8n7BvS9VRh
         LVxXwj4ArBL4NEB17fTEKA/20KxhGjuBuicBlA0WDWWpGDhTEqbRxurlGljVcQnBZiwM
         JTyMJYjhwn4PxPxJL5nwOgDqsvkwhEgl6GLlU=
Received: by 10.100.205.15 with SMTP id c15mr11424594ang.37.1224674366448;
        Wed, 22 Oct 2008 04:19:26 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Wed, 22 Oct 2008 04:19:26 -0700 (PDT)
In-Reply-To: <1224640967.14280.0.camel@minggr.sh.intel.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98857>

2008/10/22 Lin Ming <ming.m.lin@intel.com>:
> I'm looking for a way to move files to a new directory and have the
> full history follow the file automatically. Is this possible?
>
> I know about --follow, but I want the history to just follow the file
> transparently. ...

Of all Git tools, what does not do this "transparently" or "automatically"?
How more transparent do you imagine this?
What do you think should follow what?

I ask, because it is hard to understand what exactly is it you're missing:
merge support (which we have), git log listing the files as copied/renamed
(which is what --follow is for, and the suggestion for you is to make an
alias or something), git blame (ever looked at git gui blame?) or gitk
(which follows renames in default configuration)

> Also, we have a git web interface and we want the full
> history for the moved files to be available.

It is available. Whether it is shown is another question. git-web can
be improved (or just configured?)
