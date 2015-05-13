From: Trevor Saunders <tbsaunde@tbsaunde.org>
Subject: Re: [PATCH v2] bisect: improve output when bad commit is found
Date: Tue, 12 May 2015 20:54:32 -0400
Message-ID: <20150513005432.GF31257@tsaunders-iceball.corp.tor1.mozilla.com>
References: <1431472751-20974-1-git-send-email-tbsaunde@tbsaunde.org>
 <xmqqwq0dcrcf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 13 02:55:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsKwz-0001k5-PC
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 02:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbbEMAzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 20:55:00 -0400
Received: from tbsaunde.org ([66.228.47.254]:44946 "EHLO
	paperclip.tbsaunde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965165AbbEMAyn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 20:54:43 -0400
Received: from tsaunders-iceball.corp.tor1.mozilla.com (unknown [66.207.208.102])
	by paperclip.tbsaunde.org (Postfix) with ESMTPSA id EAF48C072;
	Wed, 13 May 2015 00:54:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqwq0dcrcf.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268909>

On Tue, May 12, 2015 at 04:24:00PM -0700, Junio C Hamano wrote:
> Trevor Saunders <tbsaunde@tbsaunde.org> writes:
> 
> > When the first bad commit has been found git bisect prints something
> > like this:
> >
> > 	<40 char sha1> is the first bad commit
> > 	Commit <40 char sha1>
> > 	...
> >
> > 	:100644 100644 10f5e57... a46cfeb... M  bisect.c
> > 	:100755 100755 ae3fec2... 65a19fa... M  git-bisect.sh
> >
> > The raw diff output is not really useful, and its kind of silly to print
> > the sha1 twice.  Instead lets print something like this:
> >
> > 	The first bad commit is
> > 	Commit <sha1>
> > 	...
> 
> According to +CCouder, this change will break existing people's use
> cases.
> 
> See $gmane/268881

Well, technically he just said it might be that people are parsing the
output and could be broken, but if you'd rather not take that risk then
I guess we just have to leave things the way they are.

Trev
