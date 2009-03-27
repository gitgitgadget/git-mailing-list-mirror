From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] difftool: add support for an extended revision syntax
Date: Fri, 27 Mar 2009 11:16:15 -0700
Message-ID: <20090327181547.GA4933@gmail.com>
References: <1237803348-9329-1-git-send-email-davvid@gmail.com> <m33acz2byv.fsf@localhost.localdomain> <20090327162849.GA2853@gmail.com> <7vab76evaj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 19:17:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnGcG-0002h6-M8
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 19:17:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116AbZC0SPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 14:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbZC0SPo
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 14:15:44 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:34119 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbZC0SPn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 14:15:43 -0400
Received: by qyk16 with SMTP id 16so2100427qyk.33
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 11:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=dlOmOZAb66JUBq6HfwSqhqBJ9LKjDRtO5xJpFG+bGyY=;
        b=NfIBPEIWXrEQ795TxswZ5JdRLvX4cCw0MuZzLNONnJ+oISbzKQzm7H+OqlFeJMlZVl
         Qg10DPw63a4/FanLewL+OfD/H/y/l2zNCw9xPFHpK6ZkD2S6Z/5heCHZRabfN+arh2ax
         y3JjIEsQVUdKxOXWfvGbVLSKBFXP8XIM4ed2U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HDcSYfoXuWCaX3t0TMxWgzUKWdmSpFrAgTW+6lPA6z9SrvojWkAeV889DpoJ1zq/1Y
         aUjxWemXU1wwDLIHUDSv7yYwXWofKxh7KMr8pHH+Cyy5aRQ2vV4y5TtlF8bxpX4zlshq
         rG7RsVGhEWshjFI13A8VpDs84Fi/34AK0IMPg=
Received: by 10.224.2.67 with SMTP id 3mr3286088qai.257.1238177741015;
        Fri, 27 Mar 2009 11:15:41 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 8sm2495279qwj.6.2009.03.27.11.15.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Mar 2009 11:15:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vab76evaj.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114920>

On  0, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > I noticed that my patches for "add tests to difftool" and "add
> > the -y shortcut for --no-prompt" were in git.git's pu branch
> > the other day but aren't there anymore.  Was that intentional?
> 
> Yes, it makes 'pu' not pass the self test.


Oops, was this related to your suggestions about the patch
that added the tests?  I sent a v2 patch that included the
fixups.  I'll try running the tests when I get back home to my
Linux machine on Monday (I'm currently in Chicago on a trip)
though I'm not sure if I'd be able to reproduce the failure if
it's platform-specific.

Sorry 'bout that.

-- 

	David
