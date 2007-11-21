From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: Re: [PATCH 0/3] Implement git-svn: info
Date: Tue, 20 Nov 2007 22:59:07 -0800 (PST)
Message-ID: <220901.13065.qm@web52408.mail.re2.yahoo.com>
References: <1195627399-25209-1-git-send-email-ddkilzer@kilzer.net>
Reply-To: ddkilzer@kilzer.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "David D. Kilzer" <ddkilzer@kilzer.net>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Nov 21 07:59:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IujYb-0006qV-1t
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 07:59:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616AbXKUG7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 01:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752596AbXKUG7K
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 01:59:10 -0500
Received: from web52408.mail.re2.yahoo.com ([206.190.48.171]:41764 "HELO
	web52408.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750914AbXKUG7J (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Nov 2007 01:59:09 -0500
Received: (qmail 13540 invoked by uid 60001); 21 Nov 2007 06:59:07 -0000
X-YMail-OSG: urYGHNEVM1l9XNQ_AmZrWgrYI7GuApj0GPdjvnn2WsvIoLdAsg2THVa_u.nR49.62i7zaqdueHZfHS_esZpbdVNXFFhQwQlRVn4YVNywLtTgGIiKfTdHiB9WkrmN4pVaHng0JtzOgPY-
Received: from [24.7.124.164] by web52408.mail.re2.yahoo.com via HTTP; Tue, 20 Nov 2007 22:59:07 PST
X-RocketYMMF: ddkilzer
In-Reply-To: <1195627399-25209-1-git-send-email-ddkilzer@kilzer.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65605>

"David D. Kilzer" <ddkilzer@kilzer.net> wrote:
> Eric Wong <normalperson@yhbt.net> wrote:
> > Can we expect the output of "svn info" to not change between
> > versions?  I know "svn status" has changed between versions of
> > svn.  I'd prefer if we keep the expected.* files hard-coded
> > in a test directory and compare those instead.  Maybe use sed
> > to substitute placeholders for timestamps..
> Done.

Grrr.  I remember the reason I didn't do this in the first place.  In Patch
2/3, there are now hard-coded directory paths and my username in the static
expected-* files.

That means that either I need to replace the "URL:", "Repository Root:" and
"Last Changed Author:" fields with place-holders (weakening the effectiveness
of the tests), or switch back to more dynamic tests.

Thoughts?

Dave
