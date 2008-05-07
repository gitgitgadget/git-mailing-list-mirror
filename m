From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words configurable
Date: Wed, 7 May 2008 20:19:52 +0800
Message-ID: <46dff0320805070519m569d9653ja276412fde135f45@mail.gmail.com>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>
	 <46dff0320805040935n22354e1bta85b3f3fe7c16cad@mail.gmail.com>
	 <7v63ttq0y8.fsf@gitster.siamese.dyndns.org>
	 <46dff0320805041840g1b9362d3u138b9d40cde160f2@mail.gmail.com>
	 <7vprs1ny5e.fsf@gitster.siamese.dyndns.org>
	 <46dff0320805050510t3bc5fd0eq44e0d58d1bb57629@mail.gmail.com>
	 <46dff0320805051740o65eee07eqc7073e4fa7996277@mail.gmail.com>
	 <alpine.DEB.1.00.0805060954470.30431@racer>
	 <46dff0320805061815k6aca9020g285b09da2bcf29c3@mail.gmail.com>
	 <alpine.DEB.1.00.0805071223450.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 07 14:20:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtidY-0004nb-7g
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 14:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754801AbYEGMT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 08:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754796AbYEGMTz
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 08:19:55 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:30861 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680AbYEGMTx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 08:19:53 -0400
Received: by wx-out-0506.google.com with SMTP id h29so305514wxd.4
        for <git@vger.kernel.org>; Wed, 07 May 2008 05:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=w9ChQL2Y2NYHit5ot5sh4E4/UjxOy+l8uMRfdKRvA1Q=;
        b=APOg/zL9hQH49b0x9KE/9R8liYR1TMysOA2XNOAgOSRU56Kghp5zoNnr3KYrhnvd74JDY8ZwQ9ivWwKbAEhSqVLFQjL6azUlo0ImppAOFdGIXGcHQhak2g5r7EqG043HyrgcM0IrQW4M8iNyOty2T0Z3WOOx8D9kG9Gz1ZBQ4/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=vgazceHQC+jBtfNyhrRzkV55EYZOYn9Icvf7zMLgZczjWxiGCMUlOaSEK+FQbvrteAb2IANg7C7kq6vDX2euchAwhSCXP80JQ3NLCAjhnXhkHuBcF/aZJMp+vXsRI5Xn8p8Sg8cLfBOjY9GTQ793fyCFiKfSKknU5Ukioml6aBc=
Received: by 10.100.140.15 with SMTP id n15mr2568598and.87.1210162793035;
        Wed, 07 May 2008 05:19:53 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Wed, 7 May 2008 05:19:52 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805071223450.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81430>

On Wed, May 7, 2008 at 7:24 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>  > So how about this
>  >
>  > --color-words={char,punct,word}
>  >
>  >   - char: one char one token
>  >   - punct/word: a token can be either a run of word characters or a
>  > single punct character.  diff.punctchars is used for punct, and
>  > diff.wordchars is used for word.
>
>  I am rather interested in the semantics, i.e. if you can punch holes into
>  this 3-class approach.
>
>  Bikeshedding comes later ;-)

Sorry, but i can't parse both sentences, especially Bikeshedding and
"punch holes into".



-- 
Ping Yin
