From: Sean <seanlkml@sympatico.ca>
Subject: Re: [ANNOUNCE] GIT 1.5.3
Date: Sun, 2 Sep 2007 19:16:44 -0400
Message-ID: <20070902191644.29d46cd2.seanlkml@sympatico.ca>
References: <7vodglr32i.fsf@gitster.siamese.dyndns.org>
	<46DA5F33.2020005@zytor.com>
	<85odgltrtj.fsf@lola.goethe.zz>
	<46DA88EF.7080103@zytor.com>
	<20070902133803.1b46f599.seanlkml@sympatico.ca>
	<7v4picpvgq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>, David Kastrup <dak@gnu.org>,
	git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 01:16:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRygW-0003HL-Ew
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 01:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755006AbXIBXQs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 19:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754312AbXIBXQs
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 19:16:48 -0400
Received: from bay0-omc1-s1.bay0.hotmail.com ([65.54.246.73]:58941 "EHLO
	bay0-omc1-s1.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754395AbXIBXQr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Sep 2007 19:16:47 -0400
Received: from bayc1-pasmtp06.bayc1.hotmail.com ([65.54.191.166]) by bay0-omc1-s1.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 2 Sep 2007 16:16:46 -0700
X-Originating-IP: [64.231.205.174]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([64.231.205.174]) by bayc1-pasmtp06.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 2 Sep 2007 16:17:51 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with smtp (Exim 4.43)
	id 1IRygO-0003bk-CN; Sun, 02 Sep 2007 19:16:44 -0400
In-Reply-To: <7v4picpvgq.fsf@gitster.siamese.dyndns.org>
X-Mailer: Sylpheed 2.4.2 (GTK+ 2.10.14; i686-pc-linux-gnu)
X-OriginalArrivalTime: 02 Sep 2007 23:17:51.0375 (UTC) FILETIME=[7BB731F0:01C7EDB7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57402>

On Sun, 02 Sep 2007 15:13:09 -0700
Junio C Hamano <gitster@pobox.com> wrote:

Hi Junio,

> For majority of general public, I thought the spec file _I_
> ship, along with RPM files _I_ build, are contrib status
> already.  Don't distro people do their own RPM packages, instead
> of using what I placed on k.org?

Didn't know you used RPM yourself, so I guess this is just
a case of something slipping through rather than the spec file
needing a maintainer.  Having said that, it seems odd that you
would say the spec file included with git is "contrib status
already".   How can something be contrib status unless it
is in the contrib directory of Git?
 
> Assuming that we do not give the old git-p4import script
> packaged in "git-p4 package", would the following patch be all
> that is needed, or do we need other things in the spec file?

Given the comment from David, I suspect your patch is all
that's needed; hopefully Peter can give it a quick test.

Sean
