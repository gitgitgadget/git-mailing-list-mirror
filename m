From: Jared Hance <jaredhance@gmail.com>
Subject: Re: [PATCH] imap-send: link against libcrypto for HMAC and others
Date: Tue, 7 Dec 2010 20:51:44 -0500
Message-ID: <20101208015144.GA4868@localhost.localdomain>
References: <7vwro2sd83.fsf@alter.siamese.dyndns.org>
 <1290629033-20566-1-git-send-email-flameeyes@gmail.com>
 <1291613304.3339.12.camel@fixed-disk>
 <1291613978.4756.157.camel@yamato.local>
 <7v39qbtoq9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 08 02:52:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ9CS-0007Sf-3t
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 02:52:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160Ab0LHBv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 20:51:56 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:63362 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078Ab0LHBvz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 20:51:55 -0500
Received: by qwa26 with SMTP id 26so637127qwa.19
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 17:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=alYfvt+hJMspY/a8cHYkx6bgWtg8By7gWBhwR2A9L88=;
        b=bYFjEfpkMHVDvKexBsbRsxRMS93Gz0Ice1FDLBWTKlb2oQaTTaTO4N+ni7Qe46BhSD
         wlCOFWm7dCoPVHnv6t+qvilItypIMDDap5TcHNqxz6pBH5a3dXCBU4EJVCgyVv83AGU/
         2Axg0Y3Lq4plU8h6fz+FszPEDTj26Xfc2QidY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Z8rUdeVoBr1rzEacnojLhHMVZ142+NCOG54acr+5N5KgpDjIgbp8UxWq0urHd9m93A
         qbOIoZW+3/JiRjqVGab1arp/UeFG+56/N2N8l8TZ35tSPyUCQu8XIZp/M34OrcGhu4Wk
         2+MBSSQlZKoNxW6b2mQf33FrKBTCGnBtTF47k=
Received: by 10.224.20.15 with SMTP id d15mr6382407qab.394.1291773114378;
        Tue, 07 Dec 2010 17:51:54 -0800 (PST)
Received: from localhost.localdomain (cpe-174-101-219-169.cinci.res.rr.com [174.101.219.169])
        by mx.google.com with ESMTPS id nb14sm43901qcb.24.2010.12.07.17.51.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Dec 2010 17:51:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v39qbtoq9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163158>

> You are both correct; the point of NO_OPENSSL is not to link with anything
> from openssl suite, so we need a separate mechanism to address this.
> 
> Anders, wouldn't this be a better fix for NO_OPENSSL build, than reverting
> a fix for an incorrect ld invocation?

Could we get this fixup patch into master? Leaving the original patch
in without it doesn't seem like a good idea when it breaks the build.
