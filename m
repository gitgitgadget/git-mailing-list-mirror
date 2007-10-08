From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: Merge problems with git-mingw
Date: Mon, 8 Oct 2007 15:10:20 +0200
Message-ID: <8c5c35580710080610y739fb51aga82964e212c7917f@mail.gmail.com>
References: <Pine.LNX.4.64.0710081203020.29715@ds9.cixit.se>
	 <8c5c35580710080500n78259210v1b087e1ef506c0ee@mail.gmail.com>
	 <Pine.LNX.4.64.0710081333350.29715@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Peter Karlsson" <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Oct 08 15:10:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IesNT-0007Xn-Mc
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 15:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790AbXJHNKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 09:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752735AbXJHNKW
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 09:10:22 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:26765 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295AbXJHNKU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 09:10:20 -0400
Received: by rv-out-0910.google.com with SMTP id k20so750343rvb
        for <git@vger.kernel.org>; Mon, 08 Oct 2007 06:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=np8Cm8LXmwGNxw18uT/nuR67hnofyJ31dvH5YT22qXc=;
        b=aGRKmKHUCG2dy5F/owPDFoOlTO/qUmRmB1PA5dt9Jv3pfRg6cIJc/VbsACr1YRZx8bB3ReyeBlXibqa0B80I+FKE9jOLzJC/4D6DwiOKuQ1r/XKXuSm3ek2SV6ZR/IDKAv20wW4LedCusZXMXlOrJU8u5b4G/MW5wtjn377JF84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ghz58RSvHzRKdU6FBqec5q1YtmeUp9zUFXpc1xvUR4JfzoykaTADm3bMXBv87d4NS0Ew/xcXOZ7NsOeqN9u+49aABcFPL2+rKpOoNZ+56mEbOr4zZSMi2HCGgojACLhuUb8pCpK9sw5du+nNOk5QnXovFsmdB/4OW0k3k/x9hgs=
Received: by 10.114.177.1 with SMTP id z1mr4426774wae.1191849020306;
        Mon, 08 Oct 2007 06:10:20 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Mon, 8 Oct 2007 06:10:20 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710081333350.29715@ds9.cixit.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60318>

On 10/8/07, Peter Karlsson <peter@softwolves.pp.se> wrote:
> > What does this command return?
> >
> >   $ git var GIT_COMMITTER_IDENT
>
> Doesn't seem to work:
>
>   $ git var GIT_COMMITTER_IDENT
>   usage: git-var [-l | <variable>]

Something is weird with your setup and/or the mingw port, but you can
probably work around the issue by doing this:

$ git config user.name "your name"
$ git config user.email "your email"

Optionally, you can add the --global flag to both commands to make the
config visible in all of your repos.

--
larsh
