From: linux@horizon.com
Subject: Re: A look at some alternative PACK file encodings
Date: 7 Sep 2006 05:07:56 -0400
Message-ID: <20060907090756.30111.qmail@science.horizon.com>
Cc: git@vger.kernel.org, linux@horizon.com
X-From: git-owner@vger.kernel.org Thu Sep 07 11:08:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLFrd-0007wy-4A
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 11:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWIGJH6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 05:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWIGJH6
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 05:07:58 -0400
Received: from science.horizon.com ([192.35.100.1]:64556 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751322AbWIGJH5
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Sep 2006 05:07:57 -0400
Received: (qmail 30112 invoked by uid 1000); 7 Sep 2006 05:07:56 -0400
To: gitzilla@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26621>

> Support for 'thin' packs would pretty much require mixing IDs and
> (relative) offsets in the same pack file.

An alternative would be to create a small "placeholder" object that
just gives an ID, then refer to it by offset.

That would avoid the need for an id/offset bit with every offset,
and possibly save more space if the same object was referenced
multiple times.

And it just seems simpler.
