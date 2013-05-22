From: Andreas Krey <a.krey@gmx.de>
Subject: java zlib woes (was: Reading commit objects)
Date: Wed, 22 May 2013 06:51:31 +0200
Message-ID: <20130522045131.GA6257@inner.h.apk.li>
References: <CABx5MBQ57-=MPamvV-peZUdD_KDLX+5cy9vD7CL7p_Vz9BkvTg@mail.gmail.com> <CAEBDL5XwrD8ZbRRSrM1iJGtcRgziH5bFVwRHzg9=_PYzaTfgAg@mail.gmail.com> <CABx5MBSnpZTthOHECqkbpdbFfkb4e_uSo-rh4owBc8B_oSKjJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Szakmeister <john@szakmeister.net>, git <git@vger.kernel.org>
To: Chico Sokol <chico.sokol@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 06:52:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf11t-0002Mi-I5
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 06:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287Ab3EVEv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 00:51:57 -0400
Received: from continuum.iocl.org ([217.140.74.2]:37588 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab3EVEv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 00:51:56 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r4M4pVD07743;
	Wed, 22 May 2013 06:51:31 +0200
Content-Disposition: inline
In-Reply-To: <CABx5MBSnpZTthOHECqkbpdbFfkb4e_uSo-rh4owBc8B_oSKjJQ@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225128>

On Tue, 21 May 2013 19:18:35 +0000, Chico Sokol wrote:
> Ok, we discovered that the commit object actually contains the tree
> object's sha1, by reading its contents with python zlib library.
> 
> So the bug must be with our java code (we're building a java lib).

That's interesting. We ran in a similar problem: We had a fetch
with jget hanging within the zlib deflater code in what looked
like a busy loop. Unfortunately we don't yet have a publishable
repo on which this happens.

Andreas
