From: Kevin D <me@ikke.info>
Subject: Re: [Feature REQ]Add CURLOPT_SSL_CIPHER_LIST to git for allowing
 custom cipher usages
Date: Tue, 7 Apr 2015 12:42:15 +0200
Message-ID: <20150407104215.GD9387@vps892.directvps.nl>
References: <20150406122753.GA29626@desktop.luxing.im>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Huang <steven@accsc.im>
X-From: git-owner@vger.kernel.org Tue Apr 07 12:42:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfQxe-0002UN-Sd
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 12:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbbDGKmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 06:42:20 -0400
Received: from ikke.info ([178.21.113.177]:48038 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753367AbbDGKmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 06:42:16 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id 4212944007E; Tue,  7 Apr 2015 12:42:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150406122753.GA29626@desktop.luxing.im>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266907>

On Mon, Apr 06, 2015 at 09:27:53AM -0300, Steven Huang wrote:
> Hi,
> 
>     We know git uses cURL to grab https repositories from the Internet. Nowadays
>     the SSL-enabled git repos are getting more and more, especially self-hosted
>     ones.
> 
>     Some of the websites including those enabled by CloudFlare, however, does
>     not support common encryption ciphers provided by cURL. For example,
>     TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256 will not be support by default in
>     both cURL or git, and it is not a common cipher, Debian/RHEL does not even
>     support it by default (but Fedora does, maybe others, didn't test).
> 
>     Is it possible to add this feature (this opt is set by calling by curl
>     --cipher cipher_name) to git, allowing custom cipher usage?
> 
>     Thank you very much.
> 

curl through git will honor settings in ~/.curlrc. So you can just add
the cipher to your ~/.curlrc, and it should work.
