From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: Commit ID in exported Tar Ball
Date: Thu, 17 May 2007 19:13:40 +0200
Message-ID: <20070517171340.GF4095@cip.informatik.uni-erlangen.de>
References: <20070517163803.GE4095@cip.informatik.uni-erlangen.de> <59ad55d30705171002m503feb17l64fea9ffe2cf2297@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@bitplanet.net>
X-From: git-owner@vger.kernel.org Thu May 17 19:14:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HojYV-0001M2-L5
	for gcvg-git@gmane.org; Thu, 17 May 2007 19:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756879AbXEQRNm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 13:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757315AbXEQRNm
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 13:13:42 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:63105 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756879AbXEQRNm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 May 2007 13:13:42 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id D75873F2F7; Thu, 17 May 2007 19:13:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <59ad55d30705171002m503feb17l64fea9ffe2cf2297@mail.gmail.com>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47541>

Hello,

>  $ gzip -cd snapshot.tar.gz | git-get-tar-commit-id

not good enough. What he wants is:

        - user loads tar tree down from gitweb via the 'snapshot'
          button.

        - user extracts the tarball and types make

        - The output of the produced binary contains a unique
          identifier.

        Thomas
