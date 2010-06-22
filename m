From: "J.H." <warthog9@kernel.org>
Subject: Re: DSA key
Date: Mon, 21 Jun 2010 17:16:54 -0700
Message-ID: <4C2000F6.3020405@kernel.org>
References: <3E984B93-F2DB-4F32-BBF9-C6DA3730C54E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Gaston Fiore <gaston.fiore@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 22 02:56:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQrnJ-0004Eh-VS
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 02:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758495Ab0FVA4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 20:56:48 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:58242 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758245Ab0FVA4s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 20:56:48 -0400
X-Greylist: delayed 2388 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Jun 2010 20:56:47 EDT
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id o5M0GsB8011983
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Mon, 21 Jun 2010 17:16:54 -0700
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Lightning/1.0b2pre Thunderbird/3.0.4
In-Reply-To: <3E984B93-F2DB-4F32-BBF9-C6DA3730C54E@gmail.com>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Mon, 21 Jun 2010 17:16:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149460>

Gaston,

You might want to try:

gpg --recv-keys 517D0F0E

or read the following information on gpg signatures from kernel.org:

http://www.kernel.org/signature.html

- John 'Warthog9' Hawley

On 06/21/2010 05:07 PM, Gaston Fiore wrote:
> Hello,
> 
> I'm trying to verify the download of Git and I get the following:
> 
> gbrain:Downloads gafiore$ gpg --verify git-1.7.1.tar.bz2.sign 
> gpg: Signature made Fri Apr 23 22:49:17 2010 EDT using DSA key ID 517D0F0E
> gpg: Can't check signature: public key not found
> 
> How do I know whether I should trust the downloaded file?
> 
> Thanks,
> 
> -Gaston
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
