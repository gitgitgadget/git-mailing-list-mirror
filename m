From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 28/31] Checkbox images/screenshots
Date: Tue, 19 Aug 2008 20:24:59 +0200
Message-ID: <200808192025.00001.robin.rosenberg.lists@dewire.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com> <1219005852-21496-28-git-send-email-marek.zawirski@gmail.com> <1219005852-21496-29-git-send-email-marek.zawirski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spearce@spearce.org, git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 20:27:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVVvZ-0003uQ-AV
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 20:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697AbYHSS02 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Aug 2008 14:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752623AbYHSS02
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 14:26:28 -0400
Received: from av9-1-sn2.hy.skanova.net ([81.228.8.179]:53214 "EHLO
	av9-1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599AbYHSS02 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Aug 2008 14:26:28 -0400
Received: by av9-1-sn2.hy.skanova.net (Postfix, from userid 502)
	id 36301382DE; Tue, 19 Aug 2008 20:26:26 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av9-1-sn2.hy.skanova.net (Postfix) with ESMTP
	id 1C4EA38279; Tue, 19 Aug 2008 20:26:26 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 3719537E44;
	Tue, 19 Aug 2008 20:26:25 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1219005852-21496-29-git-send-email-marek.zawirski@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92893>

s=F6ndagen den 17 augusti 2008 22.44.09 skrev Marek Zawirski:
> Screenshots of checkboxes in various states, made at QT with Plastik
> style. These images may be used as workaround in cases when we can
> only display images and handle buttons pressed, but can't display But=
ton
> directly.
>=20
> I'm somewhat uncertain about license issues regarding these images.
> Recently, I realized that they are LGPL licensed perhaps. Is it possi=
ble
> to license that small stuff? If so, we may have to replace them by so=
me
> other images or create ours.

"Stealing" artwork is not good, though there are bordercases like this.=
 It
is also the wrong look on my box which uses check marks instead of X.

Are all options exhauested wrt to using the native L&F, commented out i=
n=20
patch 31. For example toucher caching of generated images so mac users
would only see less flicker. I see no problems with GTK when using the
out-commented portion. Windows (XP) seems fine too. A really ugly, code=
wise,
would be to detect OSX and use custom images only for it until we find =
a
fix.

-- robin
