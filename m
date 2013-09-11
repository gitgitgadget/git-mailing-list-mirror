From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 00/21] np/pack-v4 updates
Date: Wed, 11 Sep 2013 12:25:48 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309111224460.20709@syhkavp.arg>
References: <xmqqtxhswexg.fsf@gitster.dls.corp.google.com>
 <1378879582-15372-1-git-send-email-pclouds@gmail.com>
 <CACsJy8C87k7K6dnr5N_mqz9w7YtdHzjB+jPwrwtMk1oeXxWYGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 18:26:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJnF8-00016F-Mo
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 18:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755042Ab3IKQ0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 12:26:10 -0400
Received: from relais.videotron.ca ([24.201.245.36]:29112 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792Ab3IKQ0J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 12:26:09 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSY00LKRYZ07WK0@VL-VM-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 11 Sep 2013 12:25:48 -0400 (EDT)
In-reply-to: <CACsJy8C87k7K6dnr5N_mqz9w7YtdHzjB+jPwrwtMk1oeXxWYGQ@mail.gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234579>

On Wed, 11 Sep 2013, Duy Nguyen wrote:

> Nico, if you have time you may want to look into this. The result v4
> pack from pack-objects on git.git for me is 35MB (one branch) while
> packv4-create produces 30MB (v2 is 40MB). I don't know why there is
> such a big difference in size. I compared. Ident dict is identical.
> Tree dict is a bit different (some that have same hits are ordered
> differently). Delta chains do not differ much. Many groups of entries
> in the pack are displaced though. I guess I turned a wrong knob or
> something in pack-objects in v4 code..

Will try to have a closer look.

Thanks for your dedication so far.


Nicolas
