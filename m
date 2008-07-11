From: "Denis Bueno" <dbueno@gmail.com>
Subject: Re: git cherry-pick before archive
Date: Fri, 11 Jul 2008 14:49:20 -0400
Message-ID: <6dbd4d000807111149s4fb661cak9fac152864260901@mail.gmail.com>
References: <6dbd4d000807110846m2921ddb9r88eb3986762b8f81@mail.gmail.com>
	 <alpine.DEB.1.00.0807111649290.8950@racer>
	 <6dbd4d000807110909n1ced22eeraef45af441c20cca@mail.gmail.com>
	 <20080711161158.GD10347@genesis.frugalware.org>
	 <alpine.DEB.1.00.0807111924180.8950@racer>
	 <6dbd4d000807111128l4721113dh3713bc7abd3d837e@mail.gmail.com>
	 <alpine.DEB.1.00.0807111944000.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Miklos Vajna" <vmiklos@frugalware.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 11 20:50:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHNhE-0006uf-PE
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 20:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941AbYGKStX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 14:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755940AbYGKStX
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 14:49:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:57249 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754644AbYGKStW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 14:49:22 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1582639fgg.17
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 11:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=kLWtk2s55jPGcAMqeykUb7IhFHYL7YeTlNsNUh3RZaw=;
        b=Vrs8SW74bcecD4ivlYX5iTdyT4gC8Auwk+awO7k7kwiRuHYVSsFytNBOlK4SkqlHoS
         mbtfPpdfceSD0JiTuQaxbV38QoLCMs+nLWtMn+vsZLWUi2Wd2VQxKhATW+2UZsfp0y/l
         OVqJG4Xln+WGxXNA/SsX2vW4cO1W2xFvNq8bo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=f/IgEaPeXfrxCT5CtjNYwrGz+uPTYbym3xjvoDKfO4ipAlUCjHxQIQ65tEU1XSJSDS
         IR+2LDNmQxOoukte1qQSQ2+j+dj7ficnG+0JDhSoJQN1B4Yrbsui+SF5HqoLdW9exx+P
         UdODib+fkbyHOaq1kCFK64gPwfO4BgkhqFBGo=
Received: by 10.86.70.8 with SMTP id s8mr10341789fga.31.1215802160438;
        Fri, 11 Jul 2008 11:49:20 -0700 (PDT)
Received: by 10.86.59.7 with HTTP; Fri, 11 Jul 2008 11:49:20 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807111944000.8950@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88156>

On Fri, Jul 11, 2008 at 14:46, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> BTW in your case, I would suggest this:
>
>        INDEX_FILE=.git/bla git read-tree HEAD &&
>        INDEX_FILE=.git/bla git apply --cached patchfile &&
>        INDEX_FILE=.git/bla git archive [...] &&
>        rm .git/bla
>
> IOW: Just use a temporary index for your work.

What is the rationale?  So I can relieve the assumption that the index is clean?

-- 
 Denis
