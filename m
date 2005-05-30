From: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: [PATCH] cg-pull: summarize the number of pulled objects
Date: Sun, 29 May 2005 21:48:49 -0600
Message-ID: <429A8D21.70609@tuxrocks.com>
References: <20050530015650.GB10715@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 05:47:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcbEW-0000f9-Kt
	for gcvg-git@gmane.org; Mon, 30 May 2005 05:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVE3DtA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 23:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVE3DtA
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 23:49:00 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:61196 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S261511AbVE3Ds5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 23:48:57 -0400
Received: from [10.0.0.10] (sorenson.dsl.csolutions.net [216.190.206.130])
	(authenticated bits=0)
	by tuxrocks.com (8.13.1/8.13.1) with ESMTP id j4U3mnTx009814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 29 May 2005 21:48:51 -0600
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20050530015650.GB10715@diku.dk>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jonas Fonseca wrote:
> +			if [ "$last_objects" != "$objecst" ]; then
                                                 ^^^^^^^^
Did you mean 'objects' ???

> +				last_objects=$objects
> +				echo;
> +			fi
> +			echo "$line"
> +			;;
> +		esac 
> +	done;
> +	[ "$last_objects" != "$objecst" ] && echo
                               ^^^^^^^
Here too?

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCmo0haI0dwg4A47wRAkJHAJ98i7xUZZVd3rzXdlor9f5+Lly7SgCfc4qK
dXkHJegPZLxP3CKzvm7SFHM=
=sKlv
-----END PGP SIGNATURE-----
