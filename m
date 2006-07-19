From: Panagiotis Issaris <takis@issaris.org>
Subject: Re: Problems using cg to clone Dave Millers repository
Date: Wed, 19 Jul 2006 17:55:58 +0200
Message-ID: <44BE560E.10606@issaris.org>
References: <44BE5143.70005@uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, davem@davemloft.net
X-From: git-owner@vger.kernel.org Wed Jul 19 17:56:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3EPM-00052i-6d
	for gcvg-git@gmane.org; Wed, 19 Jul 2006 17:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbWGSP4R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Jul 2006 11:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWGSP4R
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Jul 2006 11:56:17 -0400
Received: from alpha.uhasselt.be ([193.190.2.30]:1954 "EHLO alpha.uhasselt.be")
	by vger.kernel.org with ESMTP id S1030194AbWGSP4Q (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jul 2006 11:56:16 -0400
Received: from localhost (datastorage.uhasselt.be [193.190.2.17])
	by alpha.uhasselt.be (Postfix) with ESMTP id EDD571AB183;
	Wed, 19 Jul 2006 17:56:15 +0200 (CEST)
X-Virus-Scanned: by Amavisd antivirus & antispam cluster at uhasselt.be
Received: from [172.18.16.239] (edm-006.edm.uhasselt.be [193.190.10.6])
	by alpha.uhasselt.be (Postfix) with ESMTP id 418041AB16E;
	Wed, 19 Jul 2006 17:56:15 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
To: Panagiotis Issaris <takis.issaris@uhasselt.be>
In-Reply-To: <44BE5143.70005@uhasselt.be>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24004>

Hi,

Just wanted to add, that cloning Torvalds' tree works:

takis@issaris:/tmp/a$ cg-clone 
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
defaulting to local storage area
Fetching head...
Fetching objects...
Getting alternates list for 
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
Getting pack list for 
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
Getting index for pack 1d309de746f2b624d754622834d93b394bf43488
progress: 0 objects, 1660856 bytes, now fetching 1d309de746f2... 
(1660856 bytes)


Panagiotis Issaris wrote:
> [...]
>
> takis@issaris:/tmp/a$ cg-clone 
> http://kernel.org/pub/scm/linux/kernel/git/davem/net-2.6.git
> defaulting to local storage area
> Fetching head...
> Fetching objects...
> Getting alternates list for 
> http://kernel.org/pub/scm/linux/kernel/git/davem/net-2.6.git/
> Also look at http://kernel.or
> error: Couldn't resolve host 'kernel.orobjects' (curl_result = 6, 
> http_code = 0, sha1 = ae1237750a9178b81d61308f9228f4f92a7402b2)
> Getting pack list for 
> http://kernel.org/pub/scm/linux/kernel/git/davem/net-2.6.git/
> Getting pack list for http://kernel.or
> error: Couldn't resolve host 'kernel.or'
> error: Unable to find 27fd37621255799602d74e94d670ff7a1658d40a under 
> http://kernel.org/pub/scm/linux/kernel/git/davem/net-2.6.git/
> Cannot obtain needed blob 27fd37621255799602d74e94d670ff7a1658d40a
> while processing commit 322045cc61d1dae9ff9e9ba2d7d4768fe1b3385d.
> Waiting for 
> http://kernel.org/pub/scm/linux/kernel/git/davem/net-2.6.git/objects/d3/a269671c4c20a942bda04579d8d0e6ebf82c73 
>
> progress: 8 objects, 6468 bytes
> cg-fetch: objects fetch failed
> [...]


With friendly regards,
Takis
