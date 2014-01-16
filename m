From: Alexander Berntsen <alexander@plaimi.net>
Subject: Re: [PATCH] .gitignore: Ignore editor backup and swap files
Date: Thu, 16 Jan 2014 23:15:59 +0100
Message-ID: <52D85A1F.1010702@plaimi.net>
References: <1389907164-13400-1-git-send-email-alexander@plaimi.net> <xmqqtxd3y43b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 16 23:15:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3vE0-0007ZM-AL
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 23:15:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbaAPWPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 17:15:40 -0500
Received: from 107.4.189.109.customer.cdi.no ([109.189.4.107]:53369 "EHLO
	mail.plaimi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbaAPWPk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 17:15:40 -0500
Received: by mail.plaimi.net (Postfix) with ESMTPSA id 3DC49402FE;
	Thu, 16 Jan 2014 23:15:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=plaimi.net; s=leet;
	t=1389910538; bh=/0gJAVn7SoexLA/tde4vMIIeKNfAYwqt3aFUcxv1uYY=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=l1JYtIt6C8HeSluP2y7r2bB71NSqz2A5O1vd1vm8VrU+i9caxxRbQJUEGZDhxJZwO
	 wfMmI5VgI/vRyU/4QdGtSt+EtxeBBkvFOmSKjRFOmTFgaAxNhV8lagt99Lc/8idfA0
	 UDniOm57ekOkIygqYC9nkzf/yGcTaqaIwoYiWfA0=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <xmqqtxd3y43b.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240541>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 16/01/14 23:06, Junio C Hamano wrote:
> I personally do not mind listing these common ones too much, but if
> I am not mistaken, our policy on this file so far has been that it
>  lists build artifacts, and not personal preference (the *.swp
> entry is useless for those who never use vim, for example).
I don't see any downside to having this in .gitignore. However, not
including it doesn't significantly impede my workflow either. I will
not argue ferociously for this patch's inclusion. :-)

- -- 
Alexander
alexander@plaimi.net
http://plaimi.net/~alexander
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlLYWh8ACgkQRtClrXBQc7X7WAD9GTUId4ipGdL334Oo6Yn9duSA
qixEG95nJ2FsGz5/KNsA/icUkn2BYZRCHevsnYyUFkinOiApckkqpMOTAk5Wsd4D
=7Fvb
-----END PGP SIGNATURE-----
