From: Marco <netuse@lavabit.com>
Subject: Re: Why doesn't git commit -a track new files
Date: Thu, 24 Feb 2011 15:20:27 +0100
Message-ID: <20110224152027.05aed833@glyph>
References: <20110224112246.3f811ac2@glyph>
	<AANLkTinDT6jBxQZ5eukA6Fa=-xRMJsHTJ4pM+Hz4KER_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 24 15:20:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psc3s-0002c7-40
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 15:20:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755649Ab1BXOUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 09:20:51 -0500
Received: from lo.gmane.org ([80.91.229.12]:33182 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755495Ab1BXOUu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 09:20:50 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Psc3k-0002WT-EH
	for git@vger.kernel.org; Thu, 24 Feb 2011 15:20:48 +0100
Received: from miun108-177.dynamic.miun.se ([193.10.108.177])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 15:20:48 +0100
Received: from netuse by miun108-177.dynamic.miun.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 15:20:48 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: miun108-177.dynamic.miun.se
X-Newsreader: Claws Mail 3.7.6 (GTK+ 2.22.0; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167809>

On 2011-02-24 Pascal Obry <pascal@obry.net> wrote:

> Marco,
> 
> > I don't understand why there's not switch (is there?) for commit to
> > commit new and deleted files, like -A for git add? Is the only thing to
> > do this sth like
> >
> > git add -A && git commit -m "Message"
> 
> Never had the need for this. The reason is maybe when you are trying to have
> a small set if incremental commits, you usually don't want to add
> everything but you review the change carefully with "git add -p".

Of course not as default behaviour. Just as a switch (e.g. -A). If one wishes
this behaviour one can use it. Nobody forces you to use it (like -a).

> Now in some circumstances it could probably be useful.

Yes.


Marco
