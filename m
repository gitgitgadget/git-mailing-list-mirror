From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: problems installing git docs and gitweb on centos 5.5
Date: Wed, 29 Sep 2010 21:40:59 -0500
Message-ID: <20100930024059.GA2373@burratino>
References: <4CA3EFE6.2010306@brainstorm-digital.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dennis Huynh <dennis@brainstorm-digital.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 04:44:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1983-000464-TY
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 04:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258Ab0I3CoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 22:44:09 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59896 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452Ab0I3CoH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 22:44:07 -0400
Received: by ywh1 with SMTP id 1so476029ywh.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 19:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=o88AlnSwJt5+7Yu/0A8SEshL94Fl1livVLuBR6GsCM0=;
        b=RLe+pN6z0MfY2vnpfEjiQnxI6VQzC3Ux/Nb6vF2vdcJRlTDRJoSJv39Or1PJPsmOQw
         E6Pa234AVPpGOIS+QTGDa4uTfMJnG1CsXFEkE+4SXDosZxzxeFhyR9l5CJaVa/6jbIvR
         78myeOvKfxdU0FNK2irz6EQY3rp9SaEtqAu3w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hnpccGDF5W5aYq15V4D1VBtl1Y1LOis7EATsnc2z79LLZZQ/Yo33rgk5ylS60SOk+u
         VlAI4uVKKfFB4pQXUpHuY09ivsPpcO9ZiPoTid2+i7gHc4yG93KE2UPp8f8ehhY3GEWA
         SXbOZHqRLmmJ/c7HcV7I8uLRiiDDyyNBw+tcg=
Received: by 10.224.217.195 with SMTP id hn3mr1122444qab.96.1285814645112;
        Wed, 29 Sep 2010 19:44:05 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id t1sm10280990qcs.45.2010.09.29.19.44.02
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 29 Sep 2010 19:44:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4CA3EFE6.2010306@brainstorm-digital.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157627>

(-cc: security@centos)

Hi Dennis,

Dennis Huynh wrote:

> Am I the only one having issues installing git docs?

Here's my advice:

 1. Breathe in, breathe out.
 2. Look at the INSTALL file, section beginning "To build and install
    documentation suite".  Among other things, it describes how to
    retrieve pre-formatted documentation from the git.git repository
    itself.  So you can try:

	git clone git://git2.kernel.org/pub/scm/git/git.git
	cd git
	make quick-install-doc

    after installing git, which should be relatively painless.
 3. Look at gitweb/INSTALL.  The moment something seems unclear, note
    that, so we can come up with a patch to make it clearer for the
    next person.

[...]
>                                                              I then
> 'make install-doc' again and get an 'nbsp' not defined error.

I suspect you do not have docbook XSL installed completely.  Given
a more specific error message, maybe someone on this list could help.

> Also, is there anywhere I can get better documentation on installing
> gitweb and gitosis running properly?

I've never tried gitosis, but some gitosis users were very active on
#git when I last visited.  Maybe they could help?

The usual advice applies here, too: where the README is unclear,
please do let Tommi Virtanen know.  After an aha moment this might a
good way to make sure you are really on the right.

Hope that helps,
Jonathan
