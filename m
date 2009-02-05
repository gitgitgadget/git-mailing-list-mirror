From: Pascal Obry <pascal@obry.net>
Subject: Re: 026fa0d5ad Breaks installs with absolue $(gitexecdir) and 
	$(template_dir) variables using older GNU makes
Date: Thu, 5 Feb 2009 08:57:22 +0100
Message-ID: <a2633edd0902042357s35ab8fe7g59cb3ef109e9b0bb@mail.gmail.com>
References: <4985E8E1.90303@gmail.com>
	 <7v63jpibe8.fsf@gitster.siamese.dyndns.org>
	 <a2633edd0902042338n25dc7be4vbb202d011eb4ad78@mail.gmail.com>
	 <7vvdrpgvzl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitzilla@gmail.com, Steffen Prohaska <prohaska@zib.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 08:58:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUz8N-0007uT-Pe
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 08:58:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522AbZBEH50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 02:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753511AbZBEH5Z
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 02:57:25 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:46998 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036AbZBEH5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 02:57:25 -0500
Received: by fxm13 with SMTP id 13so140045fxm.13
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 23:57:23 -0800 (PST)
Received: by 10.223.124.75 with SMTP id t11mr52731far.73.1233820642295; Wed, 
	04 Feb 2009 23:57:22 -0800 (PST)
In-Reply-To: <7vvdrpgvzl.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108518>

Junio,

> Does your patch address the lack of $(abspath) in older GNU make?

Don't think so.

> Regardless, I think your patch to config.mak is independently good,
> because the way Makefile defines these directories is without the trailing
> slash, and it would be better to be consistent.

Right, better to have no slash ending directories to avoid double
slashes in $(dir)/file.c.

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
