From: bill lam <cbill.lam@gmail.com>
Subject: Re: unmerged files listed in the beginning of git-status
Date: Wed, 2 Sep 2009 17:04:01 +0800
Message-ID: <20090902090401.GA11464@debian.b2j>
References: <20090901145213.GB4194@debian.b2j>
 <7vljkypqfi.fsf@alter.siamese.dyndns.org>
 <200909012140.08953.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, bill lam <cbill.lam@gmail.com>,
	git <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Sep 02 11:04:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MillP-0006vn-1V
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 11:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbZIBJEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 05:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752033AbZIBJEK
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 05:04:10 -0400
Received: from mail-px0-f204.google.com ([209.85.216.204]:48893 "EHLO
	mail-px0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbZIBJEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 05:04:09 -0400
Received: by pxi42 with SMTP id 42so719528pxi.20
        for <git@vger.kernel.org>; Wed, 02 Sep 2009 02:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=NM9nIoxrQZp60ByM13YOIHd11sDiJ2r9e3pN7N5Rezo=;
        b=VqpK4krQH9hUHaJyv9WOudepyoTqBJu2sGzSj+oYP9YuRDbpuPjMLMp1urGzCxgmC1
         396auesH/hZB8giwMgv59Ln5shNhmFdKKrbcbTjYDp2a3JxLSxNQQC4Us71LA3FBXu9m
         pfaJ20DFZjHRm7KLYIyopXDIeSPNdwg4zmP44=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=sW0TRAcdCD4fk0h23BPSXI2yGOjGUyoDar97Nul5O1OVio94k8bA4QsYJ6Sjm7rOvG
         lY5/Ub2lPmM9XD5Y0/qnwpp5V8YgQ/ih+YNitOj6XcfW41eaC9X28WAnI+3PETncGJwt
         ZSPiQ3byDlIOlI42fS9A4iKpjZrAfagi81MMQ=
Received: by 10.114.248.7 with SMTP id v7mr6074677wah.92.1251882251556;
        Wed, 02 Sep 2009 02:04:11 -0700 (PDT)
Received: from localhost (n219078080082.netvigator.com [219.78.80.82])
        by mx.google.com with ESMTPS id g25sm580980wag.8.2009.09.02.02.04.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Sep 2009 02:04:10 -0700 (PDT)
Mail-Followup-To: Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200909012140.08953.j6t@kdbg.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127598>

On Tue, 01 Sep 2009, Johannes Sixt wrote:
> > But unmerged entries are something you need to deal with _first_ before
> > being able to go further, so in that sense it is more important than
> > anything else in the traditional output.
> 
> This is actually an argument to place the unmerged entries *last* because this 
> is what will be visible after 'git status' finished. Remember that we don't 
> pass its output through the pager.

If output of git-status is read indirectly such as by gui client, then
it usually shows the top portion, in such cases, it might be desirable
to put unmerged file (the most important port) immediately visible.
But I don't have that experience.

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
