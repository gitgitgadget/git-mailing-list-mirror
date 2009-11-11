From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.6.5.2
Date: Wed, 11 Nov 2009 23:23:56 +0100
Message-ID: <200911112323.57995.jnareb@gmail.com>
References: <7vljiypw9s.fsf@alter.siamese.dyndns.org> <m3ljicsrg0.fsf@localhost.localdomain> <20091111215952.GR31109@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 23:27:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Lbn-0002J6-GM
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 23:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759353AbZKKWYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 17:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759315AbZKKWX7
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 17:23:59 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:62581 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758868AbZKKWX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 17:23:59 -0500
Received: by fxm21 with SMTP id 21so1568938fxm.21
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 14:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=HJHlxKIQsZWC/9Tvf9OBqC6BRG7RYHhf0R7fRavGS/A=;
        b=BiU8w7wqr2mVdbPCt0ArFUZ44GI9GXk16vC9RSr1S+o70mrmpZDxn/fEVvheqdmqkv
         IVqJGnXZ3BhjorRL3TQdYrFCpBi7y/qQiZsXStdG0yk9/LX3WnK6nJNHCfr0v9fnpgaI
         FsehWDoTj8bSQtG7EasvgsQIP+LdRMTXnT2bA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=DMyIFcaD61YKxXcwv93ru/GnVFh72eCwik9p5IRCF4QzR7joe8P3OCVyznPgBoo9NT
         9PYCqNjlCDibh8HXLfqfO5dpXQyeSjaeCfopgjiqow5uqs+PZnU7DcsDxDLFTvkB//bB
         JvHuAN5dNLfHZCO5w/2TpkniWc4wfkGUR1o3o=
Received: by 10.204.2.196 with SMTP id 4mr380097bkk.7.1257978243008;
        Wed, 11 Nov 2009 14:24:03 -0800 (PST)
Received: from ?192.168.1.13? (abwa45.neoplus.adsl.tpnet.pl [83.8.224.45])
        by mx.google.com with ESMTPS id 14sm736542fxm.7.2009.11.11.14.24.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 14:24:01 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20091111215952.GR31109@inocybe.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132713>

On Wed, 11 Nov 2009, Todd Zullinger wrote:
> Jakub Narebski wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > > The RPM binary packages for a few architectures are found in:
> > >
> > >   RPMS/$arch/git-*-1.6.5.2-1.fc9.$arch.rpm	(RPM)
> >
> > I tried to install git from source RPM... and failed:
> >
> >   $ rpmbuild --rebuild git-1.6.5.2-1.fc11.src.rpm
> >   Installing git-1.6.5.2-1.fc11.src.rpm
> >   warning: user junio does not exist - using root
> >   warning: group junio does not exist - using root
> >   error: unpacking of archive failed on file
> >     /home/local/builddir/SOURCES/git-1.6.5.2.tar.gz;
> >     4afb1f6a: cpio: MD5 sum mismatch
> >   error: git-1.6.5.2-1.fc11.src.rpm cannot be installed
> >
> > Error messages are line wrapped for better readibility.
>
> It looks like the kernel.org builders are now using Fedora 11 to
> create the packages.  Unfortunately, there were backward-incompatible
> changes in rpm.  Stronger hashes are now used and older rpm versions
> do not understand these, leading to the error you got.

Thanks for an information.  

Well, it looks like I would have to use "make rpm" to generate RPM
to install, at least until I finally upgrade my Linux distribution.

-- 
Jakub Narebski
Poland
