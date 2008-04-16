From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Re: fsck --full is Ok, but clones are not, "missing commits"?!
Date: Wed, 16 Apr 2008 15:26:46 +0400
Message-ID: <20080416112646.GA4831@dpotapov.dyndns.org>
References: <86lk3ecgak.fsf@lola.quinscape.zz> <a537dd660804160245q5fd3a0d9jc37802765601b176@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Foster <blf@utvinternet.ie>
X-From: git-owner@vger.kernel.org Wed Apr 16 13:27:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm5nf-0000IV-Kc
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 13:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758146AbYDPL0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 07:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758060AbYDPL0y
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 07:26:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:2725 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063AbYDPL0y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 07:26:54 -0400
Received: by nf-out-0910.google.com with SMTP id g13so667567nfb.21
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 04:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=70+qVAvTffPLz6wVUWU7mnkNGGS8lubTaZeCTcx3xrc=;
        b=c6ThIBK95QWdCHyXFYSrANfobQoWaqGSfY9Qtibmp4OO/unOVKuIZOwY7UqPRwSfUoL0xn4IzidR0N/xKm2sDjhsFIM6KzGVoJMkGxZ1ZquXZDGCX+g6hZN9tFa1BamYn75QMRsgGXY4QOdgJicKG0gOUrni557yxdIx2L8PThs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=c4e7US+jaxpEI2yxKYGL9ruvBM+HMOB3cRo86lZisZcNd0F2Eb0Fubhl/MoGvUtUIfLJjqvdKBZrPRuNcnMhl8+1MkuEZzFHRY60GachGC6bCA8uzSbTzy3M9JWHTZPZPL23ZGeePfVUZB6a5uHiW7pKg9G21KVb9l0jLxgptSg=
Received: by 10.78.197.9 with SMTP id u9mr5439115huf.111.1208345211655;
        Wed, 16 Apr 2008 04:26:51 -0700 (PDT)
Received: from localhost ( [85.140.171.61])
        by mx.google.com with ESMTPS id h7sm9052266nfh.19.2008.04.16.04.26.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Apr 2008 04:26:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <a537dd660804160245q5fd3a0d9jc37802765601b176@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79692>

Hi Brian,

On Wed, Apr 16, 2008 at 11:45:39AM +0200, Brian Foster wrote:
> David Kastrup <dak@gnu.org> sensibly asks:
> >  Brian Foster <brian.foster@innova-card.com> writes:
> >  >  I've recently inherited a bare git repository,
> >  >  which, as far as I can tell (I'm something of
> >  >  a newbie with git), seems Ok: `git fsck --full'
> >  >  does not report any problems.    however, any
> >  >  clones I make from it are not Ok:
> >  >
> >  >       $ git-fsck --full   # clone (same command for bare repo is Ok)
> >  >       broken link from  commit dd3f3c0636cfd50719c706b030db5473b0270add
> >  >                     to  commit 0fed9c2eb14eee47097e1d870fe8e55a6430edeb
> >  >       missing commit fb57c018d15005b60f104e57f198ff34a6035b99
> >  >       missing commit f8947cb0b5fe605e6cb5f73c89f262424b64ef3c
> >  >       missing commit 0fed9c2eb14eee47097e1d870fe8e55a6430edeb
> >  >       missing commit dff364d8da15be0b856a174062fb785acb1c363e

I suspect your original git repository has info/grafts

Dmitry
