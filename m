From: <dag@cray.com>
Subject: Re: organizing multiple repositories with dependencies
Date: Tue, 24 Apr 2012 18:38:46 -0500
Message-ID: <nng1unc1z09.fsf@transit.us.cray.com>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com>
	<CAPZPVFbHseYHdPOXmbyGxncZmmzSHwY_fJkNRRQAMVtGZBA0CQ@mail.gmail.com>
	<CAE1pOi3XuiDA1f-NaBGeGYKcWqnCxNer4Ce-MsfjPD2hXU_mgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Eugene Sajine <euguess@gmail.com>,
	Namit Bhalla <namitbhalla@yahoo.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 01:39:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMpK4-0002S9-Tx
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 01:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758561Ab2DXXiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 19:38:55 -0400
Received: from exprod6og116.obsmtp.com ([64.18.1.37]:33541 "EHLO
	exprod6og116.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756742Ab2DXXix (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 19:38:53 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob116.postini.com ([64.18.5.12]) with SMTP
	ID DSNKT5c5il64wIK5O+m6pA5XC8g5dYePGWYI@postini.com; Tue, 24 Apr 2012 16:38:53 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 24 Apr
 2012 18:38:49 -0500
In-Reply-To: <CAE1pOi3XuiDA1f-NaBGeGYKcWqnCxNer4Ce-MsfjPD2hXU_mgg@mail.gmail.com>
	(Hilco Wijbenga's message of "Tue, 24 Apr 2012 15:11:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196292>

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:

> On 24 April 2012 12:48, Eugene Sajine <euguess@gmail.com> wrote:

> So how do you handle implementing features/changes that involve more
> than one project? Surely, you do not manually create topic branches in
> each of the involved repos?

That is indeed what integrators usually do for release branches.  For
features, developers create topic branches for whatever component
they're working on and these never hit a shared repository anyway so it
doesn't really matter.

Again, it's just another model which works well in a lot of cases, but
not all.

                           -Dave
