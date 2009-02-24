From: Jan Kara <jack@suse.cz>
Subject: Re: git bisect goes wild?
Date: Tue, 24 Feb 2009 20:28:10 +0100
Message-ID: <20090224192809.GG22108@duck.suse.cz>
References: <20090224184414.GE22108@duck.suse.cz> <eaa105840902241059y70143c43s7d12b10fe35127e6@mail.gmail.com> <20090224191002.GF22108@duck.suse.cz> <87prh7abqz.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Tue Feb 24 20:31:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc2zf-0002fo-EB
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 20:31:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592AbZBXT2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 14:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753402AbZBXT2O
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 14:28:14 -0500
Received: from cantor.suse.de ([195.135.220.2]:50050 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751557AbZBXT2O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 14:28:14 -0500
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 2431945657;
	Tue, 24 Feb 2009 20:28:11 +0100 (CET)
Received: from duck.suse.cz (duck.suse.cz [10.20.1.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.suse.cz (Postfix) with ESMTP id 9714862807F;
	Tue, 24 Feb 2009 20:28:10 +0100 (CET)
Received: by duck.suse.cz (Postfix, from userid 10005)
	id 486081F1E2F; Tue, 24 Feb 2009 20:28:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87prh7abqz.fsf@iki.fi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111332>

On Tue 24-02-09 21:14:12, Teemu Likonen wrote:
> On 2009-02-24 20:10 (+0100), Jan Kara wrote:
> 
> >   Ho, hum, right. But if I do:
> > git describe 9ec76fbf7d6da3e98070a7059699d0ca019b0c9b
> >   I get v2.6.23-rc3-215-g9ec76fb which is a bit strange for bisecting
> > between 2.6.23 and 2.6.24. Also the kernel gets named 2.6.23-rc3 and
> > kernel config options get also to some pre 2.6.23 state. That's what
> > is confusing me. It seems like the kernel checked out is some old one.
> > I'm not a git expert so it might be fine but it just seems really
> > strange.
> 
> Maybe this explanation helps:
> 
> http://thread.gmane.org/gmane.comp.version-control.git/99967/focus=99977
  OK, thanks for the pointer. I'll trust that the result will be sensible
:).

									Honza
-- 
Jan Kara <jack@suse.cz>
SUSE Labs, CR
