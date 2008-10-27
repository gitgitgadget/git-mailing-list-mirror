From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Mon, 27 Oct 2008 15:57:36 +0100
Message-ID: <200810271557.37196.jnareb@gmail.com>
References: <ge0rla$mce$1@ger.gmane.org> <200810271157.20313.jnareb@gmail.com> <fa27bd940810270729w488edd2clbd309093062558d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: mercurial@selenic.com, git@vger.kernel.org
To: "0000 vk" <0000.vk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 15:59:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuTYb-0005VJ-0R
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 15:59:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbYJ0O5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 10:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbYJ0O5r
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 10:57:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:9599 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbYJ0O5r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 10:57:47 -0400
Received: by nf-out-0910.google.com with SMTP id d3so692400nfc.21
        for <git@vger.kernel.org>; Mon, 27 Oct 2008 07:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=dd8VHpe6gG/Ay2kTiyURo5f6YQX8G6LcdNIPORQfuVQ=;
        b=l3WRnCnp4sad8Ax4Avti9n93u68daprRunt4HCYO6ZTrMy4dQsFvNXk6MbRKYd981l
         AghhKBMARBRd8rL7//TUaT8SeFm8G4v1WqSy1S1+tvZ1j24FVGj8zogS7RSX9pKIZlC+
         NBcpigGrzPBsmIWRxpmnP4ALlxiCtMHBFN4iI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=PEeUwFBHpt20FcLAo44YBMlGAoqqkmXE19Y16AWNHbfegMkDzKZ1itbUx7GjLBspDL
         GYPcTgJU5Wu0ky1O3EgoH6A55c5Yhbtil1tIpufZQTmD1wYu2q2oySFM2D66s3L5Ilrk
         HtXWcu3On9u+jnbZr90GBTZjpbyRYX2nSae84=
Received: by 10.210.46.12 with SMTP id t12mr6782079ebt.114.1225119465352;
        Mon, 27 Oct 2008 07:57:45 -0700 (PDT)
Received: from ?192.168.1.11? (abvq236.neoplus.adsl.tpnet.pl [83.8.214.236])
        by mx.google.com with ESMTPS id c24sm19284ika.8.2008.10.27.07.57.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Oct 2008 07:57:42 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <fa27bd940810270729w488edd2clbd309093062558d6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99235>

On Mon, 27 Oct 2008, 0000 vk wrote:
> 2008/10/27 Jakub Narebski <jnareb@gmail.com>

> > By the way, going back to the matter of choosing version control
> > system for DragonflyBSD; some time ago I have written post
> >  * "Mercurial's only true "plugin" extension: inotify...
> >    and can it be done in Git?"
> >   http://thread.gmane.org/gmane.comp.version-control.git/76661
> >   (current answer: it is possible using 'assume unchanged' bit)
> > about how nearly every Mercurial extension has equivalent functionality
> > in Git.
> >
> > But what about the reverse, about the following features and
> > issues in Mercurial:
[...]

> 
> Jakub,
> 
> Do you know if git supports the equivalent of hg bundle?
> Thanks.

The equivalent of "hg bundle" (http://www.selenic.com/mercurial/hg.1.html#bundle)
would be "git bundle" (http://git.or.cz/man/git-bundle). I think
git-bundle was inspired by Mercurial feature, just like fast-import
format and bisect went in other direction.

P.S. Could you _please_ quote only relevant fragments of email you are
replying to, especially if it is so long?

-- 
Jakub Narebski
Poland
