From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git-archimport
Date: Fri, 11 Nov 2005 11:21:12 +1300
Message-ID: <46a038f90511101421o7988a1bfi89eb0e33bd34e4bb@mail.gmail.com>
References: <D92ED0A1-B83A-43C3-B39C-AA8A21934D7F@desertsol.com>
	 <46a038f90511101332r3389734uc1aa1effd2898e15@mail.gmail.com>
	 <20051110214959.GO9131@raven.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 23:22:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaKnI-0003B3-JA
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 23:21:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbVKJWVR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 17:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbVKJWVQ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 17:21:16 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:3386 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932207AbVKJWVP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 17:21:15 -0500
Received: by zproxy.gmail.com with SMTP id k1so514832nzf
        for <git@vger.kernel.org>; Thu, 10 Nov 2005 14:21:12 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ptL1uxSsfv8aHwJnPvsHFVK3/rruTgJI7xFaqFUVv07BWfn44gW2j+P+jbjiBPDIux8bUc1CkfPG24ZgFFOc4z70uNa5tCiHcFykwY7ZbrfrkTCP/LTmNYQbfsK8dV7QhFDQFaTuCNdMyeaYDviTyq5h9g8Jr5FAQG7/zXTiY1g=
Received: by 10.65.180.11 with SMTP id h11mr1499138qbp;
        Thu, 10 Nov 2005 14:21:12 -0800 (PST)
Received: by 10.64.242.4 with HTTP; Thu, 10 Nov 2005 14:21:12 -0800 (PST)
To: Kevin Geiss <kevin@desertsol.com>
In-Reply-To: <20051110214959.GO9131@raven.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11530>

On 11/11/05, Kevin Geiss <kevin@desertsol.com> wrote:
> Cannot find patchset for 'kevin@desertsol.com--files/scripts--oco--0--patch-1' at /usr/bin/git-archimport line 784

Hmmm. The script uses tla itself to get the patch. What happens if you do

  tla get-changeset -A kevin@desertsol.com--files/scripts--oco--0--patch-1

In short, you must have a recent tla configured and with the archive
registered.

cheers,



martin
