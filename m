From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 0/2] Reorganise options in git-fast-import(1)
Date: Wed, 9 Jan 2013 19:43:16 +0000
Message-ID: <cover.1357760256.git.john@keeping.me.uk>
References: <20130105164415.39B144044B@snark.thyrsus.com>
 <20130105231151.GD3247@elie.Belkin>
 <7vy5g6okdi.fsf@alter.siamese.dyndns.org>
 <20130106132915.GG6440@serenity.lan>
 <20130106135109.GF22081@elie.Belkin>
 <20130106142825.GH6440@serenity.lan>
 <7va9slnc07.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org,
	David Michael Barr <b@rr-dav.id.au>,
	Pete Wyckoff <pw@padd.com>, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 20:53:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt1iF-0008BW-9O
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 20:53:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431Ab3AITxB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 14:53:01 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:57606 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932413Ab3AITxA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 14:53:00 -0500
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jan 2013 14:53:00 EST
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 93D6D23073;
	Wed,  9 Jan 2013 19:43:30 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b5CvVFwtmhyl; Wed,  9 Jan 2013 19:43:30 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id 5C09922FE7;
	Wed,  9 Jan 2013 19:43:29 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 464C3161E56B;
	Wed,  9 Jan 2013 19:43:29 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z+duL5-2OtbO; Wed,  9 Jan 2013 19:43:29 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 6E3AD161E491;
	Wed,  9 Jan 2013 19:43:17 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7va9slnc07.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213090>

Here's a second attempt at this taking into account the feedback received so far.

Changes since v1:

 * Left dedup '--done' as a separate patch (now merged)
 * Split combining '--[no-]relative-marks' into a separate patch
 * '--force' moved to the top of the options, making the catchall
   section alphabetically sorted
 * Section headings changed:
    'Options related to the input stream' => 'Options for Frontends'
    'Options related to marks' => 'Locations of Marks Files'
    'Options for tuning' => 'Performance and Compression Tuning'
 * '--export-pack-edges' moves to 'Performance and Compression Tuning'
 * '--cat-blob-fd' moves to 'Options for Frontends'


John Keeping (2):
  git-fast-import(1): combine documentation of --[no-]relative-marks
  git-fast-import(1): reorganise options

 Documentation/git-fast-import.txt | 98 +++++++++++++++++++++------------------
 1 file changed, 52 insertions(+), 46 deletions(-)

-- 
1.8.1.468.g3d9f9b6
