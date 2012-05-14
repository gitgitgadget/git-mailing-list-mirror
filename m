From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: submodule update --force
Date: Mon, 14 May 2012 22:16:15 +0200
Message-ID: <20120514201615.GI58058@book.hvoigt.net>
References: <7vobpwpoyi.fsf@alter.siamese.dyndns.org> <7vk40kpnia.fsf@alter.siamese.dyndns.org> <CAHOQ7J_6+sfU6egjvVSPj-FAS6zjSUT=a057=kz_wYbogHLMMA@mail.gmail.com> <7v8vh0ozge.fsf@alter.siamese.dyndns.org> <20120510185738.GE76400@book.hvoigt.net> <CABURp0rFQ+330X8g3C2rmozQ77zxqhZhReZhaYMi1FE4uKeQtA@mail.gmail.com> <20120514165231.GB58058@book.hvoigt.net> <CAHOQ7J_O=8NL0wp0Pu6pfjN_Y6NDJhKZUft9G2FL0vUWL7aEBw@mail.gmail.com> <20120514191802.GE58058@book.hvoigt.net> <CAHOQ7J8Wq+jHdghgNEGD+7aWNCv3rpPu1erCK4V_pu3sgXQLxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Hjemli <hjemli@gmail.com>
To: Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Mon May 14 22:16:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SU1gs-0005qG-JA
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 22:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325Ab2ENUQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 16:16:18 -0400
Received: from t2784.greatnet.de ([83.133.105.219]:40264 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932231Ab2ENUQR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 16:16:17 -0400
Received: (qmail 3270 invoked from network); 14 May 2012 20:16:15 -0000
Received: from localhost (127.0.0.1)
  by darksea.de with SMTP; 14 May 2012 20:16:15 -0000
Content-Disposition: inline
In-Reply-To: <CAHOQ7J8Wq+jHdghgNEGD+7aWNCv3rpPu1erCK4V_pu3sgXQLxA@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197807>

On Mon, May 14, 2012 at 12:29:02PM -0700, Stefan Zager wrote:
> On Mon, May 14, 2012 at 12:18 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> 
> > On a side note: I am surprised that cloning through git is really that
> > much slower than copying a zip from the network. Do you run git gc
> > regularly enough on the server?
> 
> Don't know about running `git gc`, but I can tell you that the
> 'resolving deltas' step on the client side is very slow; anecdotally,
> it appears to take longer than the network transfer.  We also would
> like to relieve the server of the burden of creating large pack files
> many times a day (the repo is frequently cloned).  I'll check to see
> whether `git gc` can help us.

I do not think you need to do this many times a day a cronjob during the
night should be sufficient. Maybe also do a gc --aggressive one a week?

Cheers Heiko
