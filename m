From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/6] Disable IPv6 support for Haiku
Date: Sun, 17 Aug 2008 22:33:35 +0200
Message-ID: <20080817203335.GB6366@steel.home>
References: <7CCFCB0B-382F-4A94-B8A7-796156A73CEF@web.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Andreas =?iso-8859-15?Q?F=E4rber?= <andreas.faerber@web.de>
X-From: git-owner@vger.kernel.org Sun Aug 17 22:34:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUoxV-00008Y-OJ
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbYHQUdj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Aug 2008 16:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbYHQUdj
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:33:39 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:39070 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbYHQUdi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:33:38 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44getV
Received: from tigra.home (Fa92c.f.strato-dslnet.de [195.4.169.44])
	by post.webmailer.de (fruni mo6) (RZmta 16.47)
	with ESMTP id z01215k7HF9Mtq ; Sun, 17 Aug 2008 22:33:36 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C4A60277AE;
	Sun, 17 Aug 2008 22:33:35 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id AEA2E56D2A; Sun, 17 Aug 2008 22:33:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7CCFCB0B-382F-4A94-B8A7-796156A73CEF@web.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92628>

Andreas F=E4rber, Sun, Aug 17, 2008 10:56:56 +0200:
> +ifeq ($(uname_S),Haiku)
> +	NO_IPV6 =3D YesPlease
> +endif

Does Haiku have no IPv6 support at all, or it is just the getaddrinfo
and the like functions which are missing?
