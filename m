From: John Keeping <john@keeping.me.uk>
Subject: Re: git submodule update needs to be at the toplevel of working
 tree, why?
Date: Fri, 22 Nov 2013 13:47:47 +0000
Message-ID: <20131122134747.GC15033@serenity.lan>
References: <1385126550.10973.50760825.6B70B959@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Odin =?iso-8859-1?Q?H=F8rthe?= Omdal <odinho@opera.com>
X-From: git-owner@vger.kernel.org Fri Nov 22 14:53:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjr5S-0001Wh-5w
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 14:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755770Ab3KVNrx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Nov 2013 08:47:53 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:39236 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755766Ab3KVNrx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 08:47:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id C6C14606502;
	Fri, 22 Nov 2013 13:47:52 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=no
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rQSrYiWI1WZ5; Fri, 22 Nov 2013 13:47:52 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 7CD2C6064D7;
	Fri, 22 Nov 2013 13:47:49 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <1385126550.10973.50760825.6B70B959@webmail.messagingengine.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238187>

On Fri, Nov 22, 2013 at 02:22:30PM +0100, Odin H=F8rthe Omdal wrote:
> I'm usually in a subfolder doing actual work. A very common problem I
> have is wanting to do a submodule update, but git really hates that. =
And
> I wonder why?
>=20
> It wouldn't be hard to cd to the toplevel working directory, do the
> update, and cd back. It's what I have to do manually every time now
> already:

This restriction was removed in Git 1.8.4.
