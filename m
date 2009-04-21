From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Cryptic error messages?
Date: Tue, 21 Apr 2009 16:08:14 +0400
Message-ID: <20090421120814.GL25059@dpotapov.dyndns.org>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE0030@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 14:10:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwEnq-0006Vz-OV
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 14:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711AbZDUMIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 08:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753119AbZDUMIp
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 08:08:45 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:46238 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777AbZDUMIo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 08:08:44 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1318691wah.21
        for <git@vger.kernel.org>; Tue, 21 Apr 2009 05:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Ox5Ny6phRlgJ8SieCuXAfNujT/1+WMvM7wDv9VQflUs=;
        b=HgRooLbVNdkyjA5v0EfbR1apOspCHS96i7wWp0776tXa7tZm6r5Fk9xGU/+jagYwZO
         G5HTTTB9W1lK3fNz+wI+o3qdxrkt6FFUFxB8BztehpIneHzkIpZy4iugi1BoLNevd+FN
         LDlm31q0ir2aLtKUHRsdNaOQQJn7Ufq+3Jeqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IkincnZXC+GQW6pe0NvB7kWF4kJzFSXHcKQC6aB67pe7RhieHEHrGxdUxIHVNdAzH/
         YGSCSUYdQvPRMW5dNPrQanLzr2QE2lPxo7s5tzaDUYANZn+Avu9M2BRpHxKD2xDTl9Rh
         9Pznfnue9fdzCmYOnnphh3A/xybwXncVAaL/A=
Received: by 10.114.202.15 with SMTP id z15mr3933955waf.67.1240315724087;
        Tue, 21 Apr 2009 05:08:44 -0700 (PDT)
Received: from localhost (ppp91-78-51-18.pppoe.mtu-net.ru [91.78.51.18])
        by mx.google.com with ESMTPS id m28sm26388708poh.11.2009.04.21.05.08.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Apr 2009 05:08:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70ACE0030@EXCHANGE.trad.tradestation.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117125>

On Mon, Apr 20, 2009 at 04:18:09PM -0400, John Dlugosz wrote:
> $ git push
> Counting objects: 9, done.
> Compressing objects: 100% (8/8), done.
> Writing objects: 100% (8/8), 3.62 KiB, done.
> Total 8 (delta 4), reused 0 (delta 0)
> Unpacking objects: 100% (8/8), done.
> fatal: unresolved deltas left after unpacking

I think that is the key message...

> error: unpack failed: unpacker exited with error code
> To //tx01fs01/sys/dev/git/repositories/aardvark.git
>  ! [remote rejected] dev -> dev (n/a (unpacker error))
> error: failed to push some refs to
> '//tx01fs01/sys/dev/git/repositories/aardvark
> .git'
> 
> 
> 
> Huh?  I'm having trouble defending git's reputation.

I don't think that information is very helpful. It would be far more
useful to know what version of Git on client and server sides are
running. Also, running "git fsck --full" may be helpful.

I suspect you have a very old Git version on the server side.


Dmitry
