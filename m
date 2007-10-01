From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: git-http-push / webDAV
Date: Mon, 1 Oct 2007 19:54:55 +0400
Message-ID: <20071001155454.GU975@void.codelabs.ru>
References: <4700F6BC.2070701@jentro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: Thomas Pasch <thomas.pasch@jentro.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 17:55:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcNbz-0006kQ-6i
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 17:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbXJAPzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 11:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbXJAPzB
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 11:55:01 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:49311 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbXJAPzB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 11:55:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=qrglhnGe90I4hBuShwsZ3hGnW+NffiC/rDWm2UrPWSUIh1KH55SFetq57j82fNjDnyTpFPKaZjoTblAybFVT5MmSe7qNJXDAUeP/0b04szRkK10SgZuX1B8+4EoejYhPyFap/S8gjXrfScygR3dtOYi352hqhvCku0aE5VUpGSQ=;
Received: from void.codelabs.ru (void.codelabs.ru [144.206.177.25])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1IcNbn-000NWD-Ek; Mon, 01 Oct 2007 19:54:59 +0400
Content-Disposition: inline
In-Reply-To: <4700F6BC.2070701@jentro.com>
X-Spam-Status: No, score=-1.8 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_40
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59624>

Thomas, good day.

Mon, Oct 01, 2007 at 03:31:40PM +0200, Thomas Pasch wrote:
> trying to set up a webDAV enabled http push
> git server (1.5.3.3) like it is described in
> 
> http://www.kernel.org/pub/software/scm/git/docs/howto/setup-git-server-over-http.txt
> 
> Tested the apache2 (2.2.6) DAV setup with
> cadaver (and tried the browser as well).
> With cadaver I could lock files, download
> and upload content.
> 
> However,
> 
> > git push -v upload master
> Pushing to http://test@x.x.x.x/git/DepTrack.git/
> Fetching remote heads...
>   refs/
>   refs/heads/
>   refs/tags/
> updating 'refs/heads/master'
>   from 0000000000000000000000000000000000000000
>   to   d75dce3fe0e9ec5915feda5574f214bd432ccb14
>     sending 89 objects
>     done
> Updating remote server info
> UNLOCK HTTP error 400

And how is your Apache configuration looks like?  I used to
make 2.2.4 work flawlessly with git.  Perhaps I will get it
a shot with the 2.2.6.
-- 
Eygene
