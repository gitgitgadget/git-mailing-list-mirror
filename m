From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [RFC/RFH] Fun things with git-notes, or: patch tracking backwards
Date: Mon, 9 Feb 2009 17:19:07 +0100
Message-ID: <20090209161907.GA953@neumann>
References: <200902091508.11460.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 09 17:20:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWYsA-00075G-6n
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 17:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464AbZBIQTN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Feb 2009 11:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752636AbZBIQTL
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 11:19:11 -0500
Received: from francis.fzi.de ([141.21.7.5]:52740 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752461AbZBIQTL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 11:19:11 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 9 Feb 2009 17:19:06 +0100
Content-Disposition: inline
In-Reply-To: <200902091508.11460.trast@student.ethz.ch>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 09 Feb 2009 16:19:06.0443 (UTC) FILETIME=[215F51B0:01C98AD2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109090>

Hi Thomas,

On Mon, Feb 09, 2009 at 03:08:08PM +0100, Thomas Rast wrote:
> And the RFH: I don't have a full mail archive, not even since I joine=
d
> the list.  There also doesn't seem to be a convenient download button
> on gmane.

you can download emails in mbox format from gmane by running

  wget http://download.gmane.org/gmane.comp.version-control.git/X/Y

which will download all emails starting at the email with "gmane id" X
and ending at the email with "gmane id" Y-1.

So, if you want to download the whole archive, you could run

  wget http://download.gmane.org/gmane.comp.version-control.git/1/10909=
0

(but of course that 109090 will be larger by the time you will reading
this).  However, there's a catch, as gmane's script execution time is
limited to 30 sec, so you will not get the whole archive, but only the
first couple of thousands emails (in my case and network I got around
6k emails in one run).  Therefore you'll need some loop to download
only a few thousand emails in each iteration.


Best,
G=E1bor
