From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] optionally disable gitattributes
Date: Wed, 27 Jan 2016 16:25:54 +0100
Message-ID: <20160127152553.GA2380@ecki.hitronhub.home>
References: <20160127095021.GA25281@ecki.hitronhub.home>
 <xmqqy4bb8c86.fsf@gitster.mtv.corp.google.com>
 <56A8DC87.2080307@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jan 27 16:32:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOS1R-0008Jn-Kb
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 16:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933173AbcA0P2g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jan 2016 10:28:36 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:21983 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932740AbcA0P2f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 10:28:35 -0500
Received: from [127.0.0.1] (ip5f5adbb8.dynamic.kabel-deutschland.de [95.90.219.184])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3pr8334kXzz5tlQ;
	Wed, 27 Jan 2016 16:28:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <56A8DC87.2080307@web.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284916>

On Wed, Jan 27, 2016 at 04:04:39PM +0100, Torsten B=F6gershausen wrote:
>
> It feels like a workaround for something that could be fixable, or is=
 already ongoing.
> Before going into more details,
> could you tell us which attributes you are typically using (when havi=
ng this problems) ?
> Is it
> * text=3Dauto
> or
> *.sh text=20
> or something else?

My concrete use case is the text attribute, as in your example: "*.sh
text". But I think of the patch as a more general solution for cases
where we want to work with the files as they are committed, without
having to deal with not normalized files or other conversions due to
gitattributes.

Please note that you may also want to read my reply to the other thread
that Junio mentioned: [PATCH] travis-ci: run previously failed tests
first, then slowest to fastest.
