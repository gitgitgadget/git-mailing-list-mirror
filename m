From: Victor Engmark <victor.engmark@terreactive.ch>
Subject: Re: Tracking database changes.
Date: Thu, 8 Sep 2011 14:12:25 +0200
Message-ID: <20110908121225.GC32087@victor.terreactive.ch>
References: <30328581.178675.1315346163453.JavaMail.trustmail@mail1.terreactive.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Rodrigo =?iso-8859-1?Q?Cort=E9s?= <rcortes.ing@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 08 14:42:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1dvs-0001MW-TZ
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 14:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932632Ab1IHMmK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Sep 2011 08:42:10 -0400
Received: from gate.terreactive.ch ([212.90.202.121]:56791 "EHLO
	mail.terreactive.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932607Ab1IHMmK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 08:42:10 -0400
X-Greylist: delayed 1770 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Sep 2011 08:42:09 EDT
Mail-Followup-To: Rodrigo =?iso-8859-1?Q?Cort=E9s?= <rcortes.ing@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <30328581.178675.1315346163453.JavaMail.trustmail@mail1.terreactive.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-terreActive-From: victor.engmark@terreactive.ch
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180967>

On Tue, Sep 06, 2011 at 06:55:56PM -0300, Rodrigo Cort=E9s wrote:
> Is there a way to use git to track database changes?

1. Export the data and/or data model with a tool like mysqldump.
2. Remove output which would clutter up your diffs without adding any
useful information. This could include things like date and time of the
export and user name of the exporter.
3. Commit and enjoy!

Optionally create a cron job to export and commit automatically during
off-peak hours.

Cheers,
Victor

--=20
terreActive AG
Kasinostrasse 30
CH-5001 Aarau
Tel: +41 62 834 00 55
=46ax: +41 62 823 93 56
www.terreactive.ch

Wir sichern Ihren Erfolg - seit 15 Jahren
