From: John Keeping <john@keeping.me.uk>
Subject: Re: difftool -d symlinks, under what conditions
Date: Wed, 13 Mar 2013 18:01:06 +0000
Message-ID: <20130313180106.GL2317@serenity.lan>
References: <20130312210630.GF2317@serenity.lan>
 <CAJELnLGBr1wOX4-3rCNjPpPLezc_6FgyeuPqty268JR0==qtvQ@mail.gmail.com>
 <7vehfk5kn2.fsf@alter.siamese.dyndns.org>
 <3222724986386016520@unknownmsgid>
 <20130313001758.GH2317@serenity.lan>
 <CAJDDKr7ZU16XWtCfYX9-RMzcpKa_FF80Od+mUMG4n8dUKeLsvw@mail.gmail.com>
 <7vtxof48sg.fsf@alter.siamese.dyndns.org>
 <7v1ubj45ac.fsf@alter.siamese.dyndns.org>
 <20130313170821.GK2317@serenity.lan>
 <7vppz32o60.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Matt McClure <matthewlmcclure@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 19:02:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFpzy-0002Eb-Ll
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 19:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934124Ab3CMSBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 14:01:20 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:60067 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933095Ab3CMSBR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 14:01:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id EA924CDA5E4;
	Wed, 13 Mar 2013 18:01:16 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tdLYbGioEbQo; Wed, 13 Mar 2013 18:01:16 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 16C6CCDA5BE;
	Wed, 13 Mar 2013 18:01:08 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vppz32o60.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218080>

On Wed, Mar 13, 2013 at 10:40:55AM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > git-hash-object(1) implies that it will apply the clean filter and EOL
> > conversion when it's given a path to a file in the working tree (as it
> > is here).  Is that not the case?
> 
> Applying clean to smudged contents _ought to_ recover clean version,
> but is that "ought to" something you would want to rely on?

How does git-status figure out that file that has been touch'd does not
have unstaged changes without relying on this?  Surely this case is no
different from that?


John
