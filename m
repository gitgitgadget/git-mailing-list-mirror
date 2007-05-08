From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] Add --no-reuse-delta, --window, and --depth options to git-gc
Date: Mon, 7 May 2007 20:38:51 -0700
Message-ID: <56b7f5510705072038y17509aaamaf8bca00bb53102@mail.gmail.com>
References: <E1HlFqU-0002ir-GK@candygram.thunk.org>
	 <alpine.LFD.0.99.0705072305270.24220@xanadu.home>
	 <20070508032122.GA10940@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>, "Junio C Hamano" <junkio@cox.net>,
	git@vger.kernel.org, danahow@gmail.com
To: "Theodore Tso" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue May 08 05:38:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlGXP-0001WG-Ui
	for gcvg-git@gmane.org; Tue, 08 May 2007 05:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967653AbXEHDix (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 23:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967675AbXEHDix
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 23:38:53 -0400
Received: from nz-out-0506.google.com ([64.233.162.225]:42218 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966549AbXEHDiw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 23:38:52 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1826963nzf
        for <git@vger.kernel.org>; Mon, 07 May 2007 20:38:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tjVUy5Jc5cEZIzNGZYUUlOtbtR4ZB/sycQEpn7BLqSNP41nv/CjCpdFXWkbRm9wxCt6X3vKUB0YMG4TmocGtlb9UVQ2P15SFOkWNvVnaqIUvS3IuVDc6Q9WOAVNEXVy6ygXrAuCTXqwTV9iQ9FnzlAvJyAHG8iSnDdiAy+yFymg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cPyYVY81K/F3rR5uByzJIDXlC8qyM3eTwjDahpU1zVXcXZOIq62fq8nEeF7otmUk1ubx5t5NbgQDakH7Y3DxrSYWPiz+bNJRj1a2/4DruSURrTmm/d1mtEiZvMuawR64USLG5M6yQQefyQhuvVLwzOpLWEr3bV3V6pPSxG1evLc=
Received: by 10.115.17.1 with SMTP id u1mr2410472wai.1178595531414;
        Mon, 07 May 2007 20:38:51 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Mon, 7 May 2007 20:38:51 -0700 (PDT)
In-Reply-To: <20070508032122.GA10940@thunk.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46528>

On 5/7/07, Theodore Tso <tytso@mit.edu> wrote:
> On Mon, May 07, 2007 at 11:13:58PM -0400, Nicolas Pitre wrote:
> > On Mon, 7 May 2007, Theodore Ts'o wrote:
> > > Sometimes users might want to use more aggressive packing options
> > > when doing a git-gc.  This allows them to do so without having
> > > to use the low-level plumbing commands.
> > In the context of "gc", having an option that reads "window" looks a bit
> > strange too.
> I suppose, but you either need to then know all of the other commands
> which git-gc runs, and do them manually, skipping git-gc altogether,
> or use git-gc, and end up rewriting the pack twice, ince using the
> git-repack in git-gc, and then once manually so you can give the
> options that you really want to give to git-repack.
>
> Maybe the right approach is to have a way to specify default --window
> and --depth as git configuration variables?  Looks like there is a
> pack.window already, but not a pack.depth.
>
> What if we add a pack.depth configuration option, and add only
> --no-reuse-delta to git-gc?   Would that be better?

I would use pack.depth .

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
