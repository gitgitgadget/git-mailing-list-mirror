From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: diff against a tag ?
Date: Thu, 28 Apr 2005 19:14:22 -0400
Message-ID: <118833cc05042816141ba672a4@mail.gmail.com>
References: <20050428200953.GD8514@redhat.com>
	 <7vpswe7hvj.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0504281358060.18901@ppc970.osdl.org>
Reply-To: Morten Welinder <mwelinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, Dave Jones <davej@redhat.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 01:09:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRI81-0006M6-98
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 01:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbVD1XOZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 19:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbVD1XOZ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 19:14:25 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:4915 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262276AbVD1XOW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 19:14:22 -0400
Received: by rproxy.gmail.com with SMTP id a41so455793rng
        for <git@vger.kernel.org>; Thu, 28 Apr 2005 16:14:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pNRQ+cFy7ZdrVhV+xx9sPpKy9Z797/ekJK1UWZuBnrKNGDdqprQENAB2k3G8O4mlbaebN3tFnAP7kq0NfGB5bnlDN7V6gr3mDj8GKet/lsiRf6UtCtpXPUn+S4gBAl7c6ZoAImkGSfQF1N/5Zrdpsy01KvxxJMUMkUqBLw7rU24=
Received: by 10.38.74.73 with SMTP id w73mr2963514rna;
        Thu, 28 Apr 2005 16:14:22 -0700 (PDT)
Received: by 10.38.76.77 with HTTP; Thu, 28 Apr 2005 16:14:22 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504281358060.18901@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> Right now fsck is the only thing that reports tags that aren't referenced
> some other way. 

Which begs the question: why wasn't the type of the object made part of the
file name?

commit-babe1234...
tag-deadbeef5678...
tree-c0ca4321...
blob-cafe8765...

That would have simplied scripts a good deal and listing all tags
would be trivial.

Morten
