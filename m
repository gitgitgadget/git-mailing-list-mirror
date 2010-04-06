From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v4] Documentation/remote-helpers: Add invocation
 section
Date: Tue, 6 Apr 2010 00:03:52 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1004060000200.14365@iabervon.org>
References: <x2zf3271551003311240i53ecb2fck173c8f34bdb3257@mail.gmail.com> <7v1vetmrl1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 06:03:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz018-0007UT-FU
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 06:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775Ab0DFEDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 00:03:54 -0400
Received: from iabervon.org ([66.92.72.58]:49163 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716Ab0DFEDx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 00:03:53 -0400
Received: (qmail 16343 invoked by uid 1000); 6 Apr 2010 04:03:52 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Apr 2010 04:03:52 -0000
In-Reply-To: <7v1vetmrl1.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144092>

On Mon, 5 Apr 2010, Junio C Hamano wrote:

> I would think that INVOCATION section needs to specify how the helper is
> selected (e.g. taking "frotz" out of "frotz::<some info>", or using the
> configuration variable remote.origin.vcs), and where the one or two
> parameters given to the program come from, to help such a developer who
> wants to add his own remote helper.

I think where the helper gets selected should be described in the (more 
user-centric) documentation of how git uses external helpers; helper 
developers (who are writing their helper in the context of git) should 
generally be familiar with this from the user documentation. I'd like to 
keep this document as little specific to git being what calls the helper 
as possible.

	-Daniel
*This .sig left intentionally blank*
