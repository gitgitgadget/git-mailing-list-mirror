From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: builtin-fetch code with messy history
Date: Tue, 19 Jun 2007 13:47:12 +0200
Message-ID: <81b0412b0706190447y37c3aedbya42b7a3d5703322c@mail.gmail.com>
References: <Pine.LNX.4.64.0706190255430.4740@iabervon.org>
	 <Pine.LNX.4.64.0706191037590.4059@racer.site>
	 <81b0412b0706190313g74765babk38309dd838f3f585@mail.gmail.com>
	 <Pine.LNX.4.64.0706191210020.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Daniel Barkalow" <barkalow@iabervon.org>, git@vger.kernel.org,
	"Junio C Hamano" <junkio@cox.net>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 19 13:47:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0cB5-0002Y2-NU
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 13:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756075AbXFSLrO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 07:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755572AbXFSLrO
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 07:47:14 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:11086 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756AbXFSLrN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 07:47:13 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1255069wra
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 04:47:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LmGaIHoeRYxgTs9WRInJTEr5z2AcIY3/dmOaY0DEVj91qmEKEANTpI0vLtjIbig/fqrY0wsWVvzYNibji46QyVYJxMuzHNT1YJfuhvNnaBT9R+pg13TiGtaYFUijvw054MWcB/NkrQ04I70U6WP57M1TEZOfT7CjnYroD8frh2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bJ1TaUzdFDNohZ22obxg2zJZKCkF/yCZ4bvQ+1Az9PYKYsKsj2BbMCHBj8bSHr0+Cx9jRS0tbHeMjmwlsQlmWMSq1JiIK8kPe37kVNhbUwNqS4ShpH41+AUS/Rf4fzxpGnsJb3cY2i2nY31Aw0NhERgn4MGCnzYEq57YrPX3BMU=
Received: by 10.78.204.1 with SMTP id b1mr2798969hug.1182253632599;
        Tue, 19 Jun 2007 04:47:12 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Tue, 19 Jun 2007 04:47:12 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0706191210020.4059@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50471>

On 6/19/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > Maybe this is the right time to cut off branches/* and remotes/*?
> >
> > Seconded. Don't use the remotes/ since some months now.
> > But... isn't a git package with code of something like 1.4.4 is still
> > in some major distributions?
>
> Yes, AFAICT it is Ubuntu "the most up-to-date distro there is". At least
> many questions on the list and in IRC suggest that.
>
> So, how about checking (at least for a year) in builtin-fetch, if
> "branches/" or "remotes/" exist, and fail, with a nice message how to move
> to config-based remotes?

...by suggesting to use a nice conversion script which we don't
have.

BTW, as far as I can see, git-remote reads old configuration just fine,
so it probably will a very simple script: read all and write all. Well,
the "all" part of it can be a bit complicated, but aside from that...
