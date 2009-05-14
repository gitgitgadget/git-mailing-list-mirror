From: layer <layer@known.net>
Subject: Re: how to update origin/<branch> after a push to origin <branch>?
Date: Wed, 13 May 2009 22:21:09 -0700
Message-ID: <20329.1242278469@relay.known.net>
References: <19640.1242276135@relay.known.net> <32541b130905132158s44cc5b19n974901c05cf025b2@mail.gmail.com>
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 07:21:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4TNe-0006lv-S2
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 07:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753547AbZENFVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 01:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753434AbZENFVJ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 01:21:09 -0400
Received: from relay.known.net ([67.121.255.169]:43757 "EHLO relay.known.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752122AbZENFVI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 01:21:08 -0400
Received: from localhost (127.0.0.1) by relay.known.net
    (Allegro Maild v1.2.19) id 000000039342; Wed, 13 May 2009 22:21:09 -0700
In-reply-to: <32541b130905132158s44cc5b19n974901c05cf025b2@mail.gmail.com>
Comments: In-reply-to Avery Pennarun <apenwarr@gmail.com>
   message dated "Thu, 14 May 2009 00:58:09 -0400."
X-Mailer: MH-E 8.1; nmh 1.3; GNU Emacs 22.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119140>

Avery Pennarun <apenwarr@gmail.com> wrote:

>> Short answer:
>> 
>>    git fetch origin

I wasn't doing exactly this, but I was doing the equivalent of 

  git fetch $(git config --get remote.origin.url)

Why would these be different?

Kevin
