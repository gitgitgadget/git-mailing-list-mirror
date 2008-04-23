From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Git on Windows, CRLF issues
Date: Wed, 23 Apr 2008 16:02:50 -0400
Message-ID: <32541b130804231302i732dbf08v88f8909f241ab99@mail.gmail.com>
References: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se>
	 <alpine.DEB.1.00.0804212104560.2298@eeepc-johanness>
	 <32541b130804211453x77f3fd49hef645a417a9919ca@mail.gmail.com>
	 <20080422023918.GA5402@sigill.intra.peff.net>
	 <32541b130804220951p224c9be7ya4e8de5056481fd1@mail.gmail.com>
	 <20080423080826.GA11935@sigill.intra.peff.net>
	 <480F1671.2060602@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Peter Karlsson" <peter@softwolves.pp.se>, git@vger.kernel.org
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 23 22:04:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JolBx-0005Mu-Oa
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 22:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754374AbYDWUC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 16:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754186AbYDWUC5
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 16:02:57 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:9398 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127AbYDWUCy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 16:02:54 -0400
Received: by mu-out-0910.google.com with SMTP id i10so2529960mue.1
        for <git@vger.kernel.org>; Wed, 23 Apr 2008 13:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Hd2bp6aIotfmkpXRmohr1J2UtvJaKiKNYykBRqeUVmU=;
        b=o/npFBXUQR4HxezdG4d+jtIA2B2wBGhGixuigFBdYGxfr4ikX8dp0+14yeCOiIPIAa31Q9y+mPFuKEcCvK1OAVD0p3cVuHOywYi1EE/7DEivq+qxJTuM5GN5n7aUC6iqPUwHmR6DnOzHWjuP5jQHNiLwtW3OBfQI8Lfthh/qCGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XmP3uRvyX6a4ri8HNJH+9mHmAuT3PUXajYl/+AUPVTN2BCpcFHhPwhvU3NliSGgjPiuIg9w2UEf7JE+NTLWJOQvbO6ZAaXMF0cR257lyAQNuFYJaF5FEdv0+rIUI68NUTBxhdF205DkTDeN892gQw4u6WjwKl97BS2xhgiVeONo=
Received: by 10.82.191.3 with SMTP id o3mr1665733buf.34.1208980970655;
        Wed, 23 Apr 2008 13:02:50 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Wed, 23 Apr 2008 13:02:50 -0700 (PDT)
In-Reply-To: <480F1671.2060602@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80253>

On 4/23/08, Johannes Sixt <j.sixt@viscovery.net> wrote:
> In practice, this is not sufficient. The blob filter must have an
>  opportunity to decide what it wants to do, not just blindly munge every
>  blob. The minimum is a path name, e.g. in $1:

Actually, it may not have been intentional, but because of the way
'eval' works, the munge script will find that $path already contains
the path of the file being munged.  Works for me.

Have fun,

Avery
