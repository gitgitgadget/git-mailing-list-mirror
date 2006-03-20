From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [ANNOUNCE] qgit 1.1.1
Date: Mon, 20 Mar 2006 13:13:45 +0100
Message-ID: <e5bfff550603200413i22a37a43n4d5a9b0ba63e880d@mail.gmail.com>
References: <e5bfff550603190853m2db7bb38gecc94934c4dfb89e@mail.gmail.com>
	 <20060319214907.GA7294@elte.hu>
	 <e5bfff550603191401h2c206950w1a0e04cd50fc5370@mail.gmail.com>
	 <e5bfff550603191404l7511e76awe980fad51ffde98d@mail.gmail.com>
	 <20060320102022.GA21917@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, proski@gnu.org
X-From: git-owner@vger.kernel.org Mon Mar 20 13:14:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLJGq-0001ZJ-8i
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 13:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWCTMN4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Mar 2006 07:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWCTMN4
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 07:13:56 -0500
Received: from pproxy.gmail.com ([64.233.166.177]:38734 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932231AbWCTMN4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Mar 2006 07:13:56 -0500
Received: by pproxy.gmail.com with SMTP id i49so1478725pyi
        for <git@vger.kernel.org>; Mon, 20 Mar 2006 04:13:46 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xczt31iYSLr887wQqecoBUf/EE/90Z2/DcY5KYQj/DqBjMRCdBWJHEBUNdaxWMDqRoIUSIkTLgalvwoH6F4tZPwSOEqwwLKJ0nD9yHw1AHd/gzRLf2h9seujSTlX/aHoK5dZyh/8IWuWExaSkM+QIiNn85YkccmN4nllvGBZ2Vw=
Received: by 10.64.232.15 with SMTP id e15mr308090qbh;
        Mon, 20 Mar 2006 04:13:45 -0800 (PST)
Received: by 10.64.131.10 with HTTP; Mon, 20 Mar 2006 04:13:45 -0800 (PST)
To: "Ingo Molnar" <mingo@elte.hu>
In-Reply-To: <20060320102022.GA21917@elte.hu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17750>

On 3/20/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Marco Costalba <mcostalba@gmail.com> wrote:
>
> > > Put in this way it seems a very major bug! really not a small one!
> > >
> > > I cannot reproduce it. Please can you give me some more info as repository
> > > (linux tree?) and commit sha.
> > >
> >
> > And please also the error message that appears in qgit window so to
> > know what git command failed.
>
> i've attached a screenshot of the failure message. It's plain Linus'
> kernel git tree, clicking on any merge commit produces this window. FC4
> box.
>

The wrong command is git-diff-tree -r -c -p 46571...

I think it's about the quite new option -c of git-diff-tree.

Please upgrade your git to latest version, better upstream one, but
1.2.4 should be enough.

Marco
