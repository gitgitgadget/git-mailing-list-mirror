From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 1/2] New stg command: assimilate
Date: Mon, 23 Oct 2006 12:52:20 +0100
Message-ID: <b0943d9e0610230452m70d25e91x9e9604ed4eac33ea@mail.gmail.com>
References: <20061022130559.17015.51385.stgit@localhost>
	 <20061022130802.17015.50188.stgit@localhost>
	 <20061022174308.GQ20017@pasky.or.cz>
	 <20061022181256.GA30295@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Petr Baudis" <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 13:52:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbyLx-0003hy-Az
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 13:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWJWLwW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 23 Oct 2006 07:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWJWLwW
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 07:52:22 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:31332 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932141AbWJWLwV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 07:52:21 -0400
Received: by py-out-1112.google.com with SMTP id z74so147302pyg
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 04:52:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XrtnEH4ic9/AYzpJkFnPu6Pljp1ML6pudVLUwvU4bxD3nLtqo5NGgR6jpkipzBw378GstyJR8IqCiEwwDFxakQaKsDAWFrh/G/nvNMkU151UbrnB4U76VF9EGKsYsk/f01oojAcQiNMxS6gBPPMcbmZzZ9hSMxnpQXMPS14iKWE=
Received: by 10.35.97.17 with SMTP id z17mr6401229pyl;
        Mon, 23 Oct 2006 04:52:20 -0700 (PDT)
Received: by 10.35.103.18 with HTTP; Mon, 23 Oct 2006 04:52:20 -0700 (PDT)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
In-Reply-To: <20061022181256.GA30295@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29827>

On 22/10/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2006-10-22 19:43:08 +0200, Petr Baudis wrote:
>
> > Dear diary, on Sun, Oct 22, 2006 at 03:08:02PM CEST, I got a letter
> > where Karl Hasselstr=F6m <kha@treskal.com> said that...
> >
> > > Introduce an "assimilate" command, with no options. It takes any
> > > GIT commits committed on top of your StGIT patch stack and
> > > converts them into StGIT patches.
> >
> > Hmm, isn't this what stg uncommit does?
> >
> > Well, I'm not sure if what uncommit takes is from below the stack o=
r
> > above the stack, but if it's the former, it would still IMHO make
> > more sense to just tell that StGIT with a switch or something.
>
> Yes, you're correct in that uncommit and assimilate add existing
> commits to the StGIT stack, but in different ends: uncommit grows the
> stack by incorporating commits that precede it, while assimilate grow=
s
> the stack by incorporating commits that follows it.

I think I also prefer a separate command for this as they have
slightly different goals and users could easily confuse the options of
a more powerful 'uncommit'.

--=20
Catalin
