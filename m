From: Lars Damerow <lars@pixar.com>
Subject: Re: [PATCH] Add support for GIT_ONE_FILESYSTEM
Date: Mon, 15 Mar 2010 16:36:45 -0700
Message-ID: <20100315233645.GG11157@pixar.com>
References: <20100315214003.GB11157@pixar.com> <fabb9a1e1003151616m4c0e9100g77170433f6a67912@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 00:36:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrJq7-0001ZC-PB
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 00:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934323Ab0COXgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 19:36:46 -0400
Received: from cmx.pixar.com ([199.108.77.24]:28357 "EHLO cmx.pixar.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933017Ab0COXgq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 19:36:46 -0400
X-PixarMID: 1908251
X-PixarRecvListener: OutboundMail
X-PixarRemoteIP: 138.72.131.152
X-IronPort-AV: E=Sophos;i="4.49,646,1262592000"; 
   d="scan'208,223";a="1908251"
Received: from helper.dynamic.pixar.com ([138.72.131.152])
  by cirrus.pixar.com with ESMTP; 15 Mar 2010 16:36:45 -0700
Received: from helper.dynamic.pixar.com (localhost [127.0.0.1])
	by helper.dynamic.pixar.com (8.14.3/8.14.3) with ESMTP id o2FNajS0003774;
	Mon, 15 Mar 2010 16:36:45 -0700
Received: (from lars@localhost)
	by helper.dynamic.pixar.com (8.14.3/8.14.3/Submit) id o2FNajXW003772;
	Mon, 15 Mar 2010 16:36:45 -0700
Content-Disposition: inline
In-Reply-To: <fabb9a1e1003151616m4c0e9100g77170433f6a67912@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142279>

>From Sverre Rabbelier <srabbelier@gmail.com>, Tue, Mar 16, 2010 at 12:16:19AM +0100:
> Heya,
> 
> On Mon, Mar 15, 2010 at 22:40, Lars Damerow <lars@pixar.com> wrote:
> > if (buf.st_dev != current_device)
> >     die("refusing to cross filesystem boundary '%s/..'", cwd);
> 
> Great, that's going to tell the unfortunate user who runs into this a
> whole lot of nothing. Shouldn't you at least tell them what git was
> trying to do, how they can fix it if this is not the desired behavior,
> etc. etc.?

Hi Sverre,

You're right, that's a badly-worded error. How about this?

    Not a git repository (or any parent up to /path/to/mountpoint)
    Stopping at filesystem boundary since GIT_ONE_FILESYSTEM is set.

-lars

--
lars r. damerow :: button pusher :: pixar animation studios

Science Factoid:  The common cockroach shares 99.5 percent of its DNA code
                  with e-mail spammers and telemarketers.
