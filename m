From: bill lam <cbill.lam@gmail.com>
Subject: Re: how to split a hunk
Date: Wed, 28 Oct 2009 23:16:31 +0800
Message-ID: <20091028151631.GB3956@debian.b2j>
References: <20091028022105.GE3938@debian.b2j>
 <200910281406.12923.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Oct 28 16:18:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3AHr-0004DZ-T8
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 16:18:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754394AbZJ1PRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 11:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754275AbZJ1PRF
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 11:17:05 -0400
Received: from gv-out-0910.google.com ([216.239.58.191]:11825 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318AbZJ1PQe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 11:16:34 -0400
Received: by gv-out-0910.google.com with SMTP id r4so112466gve.37
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 08:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rMWQiD6mP57F+LWvvBW9o/HABo5Fwd+L+hMVaTfPIqU=;
        b=QQrKsCYdN36c2igemqeO9E1DBN5b0fG5xvGvwzHtkiyFOy3Ns3HHWRyvmHEwHS6uL4
         ix6SLhBHvPmBCY+S6sjTWjXSSF4oqGhCHCzgyKG2p3vRg5n2l87yI8SHiFAgYpUVaWEU
         oh7OjeEgGUwbsab1xr960QddDmAuTC/aSdCV4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=euJX6ukjcUO/XrMKcys2RuvsDc0qoks+CZOuggLHGeVJwsPXQRheaumjYHeesvYy04
         +71WvOxeNHnsXIQgCqW7hhtnSS9/T/dNLhS8pv635IXFC4NmbtstsHOxH3T1XsP4r6Mp
         7br8zdS9cZad6PWuNQd1V/zyTclNVAj5aqoEc=
Received: by 10.216.90.76 with SMTP id d54mr2210044wef.55.1256742998122;
        Wed, 28 Oct 2009 08:16:38 -0700 (PDT)
Received: from localhost (n218103227169.netvigator.com [218.103.227.169])
        by mx.google.com with ESMTPS id t12sm421298gvd.22.2009.10.28.08.16.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 08:16:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200910281406.12923.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131470>

On Wed, 28 Oct 2009, Thomas Rast wrote:
> There's also the 'git add -p' [e]dit feature, which pops up the patch
> in an editor.  There are instructions in that file, but in this case,
> you can simply remove one of the additions.

Thank you for pointing out the [e], incidentally after trying it, I
also noticed and tried the add -e which belongs to a similar format.

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
