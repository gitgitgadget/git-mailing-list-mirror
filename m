X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: svn versus git
Date: Fri, 15 Dec 2006 01:19:58 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612150118190.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200612132200.41420.andyparkins@gmail.com>  <20061213225627.GC32568@spearce.org>
  <200612140908.36952.andyparkins@gmail.com>  <7vodq695ha.fsf@assigned-by-dhcp.cox.net>
  <fcaeb9bf0612140708w6bc691f6k2e08fbab2a651421@mail.gmail.com> 
 <Pine.LNX.4.63.0612141630240.3635@wbgn013.biozentrum.uni-wuerzburg.de> 
 <fcaeb9bf0612140832v1c80bf7dgd61897111292d31@mail.gmail.com> 
 <Pine.LNX.4.63.0612141754420.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <fcaeb9bf0612140910t6aff44e1m9570b20850a41b87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 15 Dec 2006 00:20:14 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <fcaeb9bf0612140910t6aff44e1m9570b20850a41b87@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34452>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv0o2-0007gn-9W for gcvg-git@gmane.org; Fri, 15 Dec
 2006 01:20:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752061AbWLOAUA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 19:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbWLOAUA
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 19:20:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:38605 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1752061AbWLOAT7
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 19:19:59 -0500
Received: (qmail invoked by alias); 15 Dec 2006 00:19:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp037) with SMTP; 15 Dec 2006 01:19:58 +0100
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Fri, 15 Dec 2006, Nguyen Thai Ngoc Duy wrote:

> On 12/14/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > > - have you seen the patch for git-show today, which would include this
> > > > functionality?
> > >
> > > I didn't. From the patch, it seems git-show can show the index via
> > > ::file syntax. If so, I'd like withdraw my opinion. '::file' syntax is
> > > not intuitive though. Perhaps you should mention that it can show
> > > index (and how) in the git-show document
> > 
> > Well, you can reference blobs that way, but not trees.
> 
> Oh, yeah. Isn't this a good oppotunity to add --index option to git-show?
> git-show --index will show the index. git-show --index file will show
> the file content. This makes git-show a little unconsistent though as
> it may or may not require argument <object>.
> 
> Another option is treat '::' alone specially -- call git-ls-files.

Hmm. I don't know... It would make the code rather messy. And are you 
really interested in the content stored in the index? In all cases I can 
think of, you are better off with a diff vs. working directory or ref.

Ciao,
Dscho
