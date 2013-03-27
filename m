From: John Keeping <john@keeping.me.uk>
Subject: Re: What's cooking in git.git (Mar 2013, #07; Tue, 26)
Date: Wed, 27 Mar 2013 22:07:23 +0000
Message-ID: <20130327220723.GR2286@serenity.lan>
References: <7v620dss3j.fsf@alter.siamese.dyndns.org>
 <20130327203535.GA5220@sigill.intra.peff.net>
 <878v58worp.fsf@linux-k42r.v.cablecom.net>
 <7vy5d8jz0y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Matthew Blissett <matt@blissett.me.uk>,
	David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 23:08:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKyVu-0004ls-1y
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 23:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661Ab3C0WHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 18:07:42 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:38684 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685Ab3C0WHl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 18:07:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id CAE4C23034;
	Wed, 27 Mar 2013 22:07:40 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id id4ol5ParK21; Wed, 27 Mar 2013 22:07:40 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id D050122FEE;
	Wed, 27 Mar 2013 22:07:25 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vy5d8jz0y.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219338>

On Wed, Mar 27, 2013 at 02:47:25PM -0700, Junio C Hamano wrote:
> > * jk/difftool-dir-diff-edit-fix (2013-03-14) 3 commits
> >   (merged to 'next' on 2013-03-19 at e68014a)
> >  + difftool --dir-diff: symlink all files matching the working tree
> >  + difftool: avoid double slashes in symlink targets
> >  + git-difftool(1): fix formatting of --symlink description
> 
> I lost track of various discussions on "difftool" and its "symlink
> so that the user can edit working tree files in the tool".

Would it be easiest if I send a new series incorporating
jk/difftool-dirr-diff-edit-fix and the proposed change to not overwrite
modified working tree files, built on top of t7800-modernize?

The "overwrite modified working tree files" issue isn't new, but
jk/difftool-dir-diff-edit-fix makes it more likely to happen so it might
be best to include those in one topic, and building on
jk/t7800-modernize will avoid conflicts in the tests.
