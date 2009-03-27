From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Merge format documented?
Date: Fri, 27 Mar 2009 09:05:31 -0700 (PDT)
Message-ID: <m3y6ur0x4m.fsf@localhost.localdomain>
References: <200903230419.50000.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Fri Mar 27 17:09:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnEbM-0006A0-Rd
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 17:08:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755230AbZC0QFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 12:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754597AbZC0QFg
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 12:05:36 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:63521 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153AbZC0QFf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 12:05:35 -0400
Received: by ewy9 with SMTP id 9so1122918ewy.37
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 09:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=ZxbaFmLTW9pLSnAoxs4K9+9xcj6CT/FYYbtSWcFa2rA=;
        b=bFFNZtdKqy3tywmy0Lr+yi5l+RAbKbCKZBN8Z8mmCmb+Dx45sRDnBsLfDp3jqs9Sbe
         GOM7fP4XQrhdIkwul4fd7x0enzreF6RePUIQZPuFRetfvIBGQgCSDm7EYnhF5QMGFACV
         LMEI0+EDvk6iq6QZu4aG8pNO3iEjnp7XhZpJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=wasBhuKhH9rtJ1uaxENfsqlWQxtH7Md8jpjnWWDSFeoFzH2A26bzSSGG0Xpdt37KTD
         s7S3HNh7eg2L6AH9emkRzEsRkTevKb5eF4hBbC4B0YC2C/DEhQwRR80nYdrenS+l56pw
         3MgLOsacnPG2+VrdVyF7e+KG+wQ3gLP6y/+VQ=
Received: by 10.216.54.83 with SMTP id h61mr882336wec.69.1238169932097;
        Fri, 27 Mar 2009 09:05:32 -0700 (PDT)
Received: from localhost.localdomain (abvq19.neoplus.adsl.tpnet.pl [83.8.214.19])
        by mx.google.com with ESMTPS id j8sm2458875gvb.21.2009.03.27.09.05.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Mar 2009 09:05:31 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n2RG5T3R009784;
	Fri, 27 Mar 2009 17:05:30 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n2RG5TAA009781;
	Fri, 27 Mar 2009 17:05:29 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <200903230419.50000.agruen@suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114906>

Andreas Gruenbacher <agruen@suse.de> writes:

> Hello,
> 
> is the format that git normally uses for indicating merge conflicts in files 
> (the <<< === >>> markers) documented somewhere?  How exactly does it differ 
> from the diff3 format (<<< ||| === >>>)?  Diff3's -m mode seems to come close 
> to what git does, except that git doesn't produce the ||| section:

It is rcmerge / merge from RCS / CVS output format (and I think it is
also format used for other VCS), and IIRC it is equivalent to "diff3
-E" format

> Does git ever output a ||| section?

You can ask for it with merge.conflictstyle configuration variable, or
--conflict=<style> option to git-checkout.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
