From: Kevin O'Riordan <kor@compsoc.com>
Subject: Re: What shall we do with the GECOS field again?
Date: Mon, 19 Sep 2005 15:11:06 +0100
Message-ID: <20050919141106.GA31983@compsoc.com>
References: <20050919134838.GC2903@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 19 16:14:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHMNV-0002y0-35
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 16:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbVISOLN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 10:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbVISOLN
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 10:11:13 -0400
Received: from pagh.compsoc.com ([193.120.123.132]:16512 "EHLO
	pagh.compsoc.com") by vger.kernel.org with ESMTP id S932421AbVISOLM
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 10:11:12 -0400
Received: from kor by pagh.compsoc.com with local (Exim 3.36 #1 (Debian))
	id 1EHMMM-0008TS-00
	for <git@vger.kernel.org>; Mon, 19 Sep 2005 15:11:06 +0100
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050919134838.GC2903@pasky.or.cz>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8862>


Hi,

> [cutting] based on ',', ... might throw away the first name of gecos
> fields in the "Torvalds, Linus" name.
...
> ... a lot of them used the realname,phone,something,phone,... format.
...
> So my proposal ... is to cut everything after the first , or ; from
> the GECOS field.
...
> In the ... situation of the "Baudis, Petr"-like GECOS fields, this
> will just result in only the surname being in the realname field,
> which seems to be much less harmful and comparably less evil to me. 

In case this hasn't been suggested, how about cutting on "," but taking
the first and second fields instead of just the first, and then
discarding the second if it contains numbers (or is empty, or whatever) ?

-kor
