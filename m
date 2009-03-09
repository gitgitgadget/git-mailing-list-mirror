From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [GSoC] Google Summer of Code 2009 - new ideas
Date: Mon, 9 Mar 2009 02:18:23 +0100
Message-ID: <200903090218.27132.jnareb@gmail.com>
References: <200903070144.17457.jnareb@gmail.com> <200903090059.36699.jnareb@gmail.com> <20090309115026.obsvt34miowwcw8w@webmail.fussycoder.id.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: thestar@fussycoder.id.au
X-From: git-owner@vger.kernel.org Mon Mar 09 02:20:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgU9z-0003yX-Il
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 02:20:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814AbZCIBSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 21:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753552AbZCIBSg
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 21:18:36 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:30561 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570AbZCIBSf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 21:18:35 -0400
Received: by fg-out-1718.google.com with SMTP id 16so772657fgg.17
        for <git@vger.kernel.org>; Sun, 08 Mar 2009 18:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=KIoxx0Fudd5Fheop0XwcereTAkPR9Qg7s+9oEWL8HU0=;
        b=blU7/aQEvV9OwqW8XoF0gJ+p0rCrcmpT1yoTNxy1Bb21fwHNQQF/HCF2ZT6c+38bXl
         2r9s9LR9wQiLbsgLh/5u5O/aZPM4oWRV7dyEL1NJlQ4K5MKSUOud8/Cg8QpWjMGnyYS6
         o5NuzbtdNkCkPjZ18kpl4/7HcKDouqmPhZ5p0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=BhW9a58fuIYEaUMIK2mZsVWoN2Q0o4t75XMRp4e40uJXoGgK7MczYSxjbGBhuVCpCx
         WVpVmTiuwa9YWjCmpI3ixb44qftSleaLzJ20j900A1k32j2cFYzckZnYpbbSyd3Gc6DF
         AIV7qf//FN1zWA3Fntvb0CF1X+OqrXJjHBljc=
Received: by 10.86.91.3 with SMTP id o3mr3642061fgb.17.1236561512459;
        Sun, 08 Mar 2009 18:18:32 -0700 (PDT)
Received: from ?192.168.1.13? (abvd146.neoplus.adsl.tpnet.pl [83.8.201.146])
        by mx.google.com with ESMTPS id d4sm2861879fga.5.2009.03.08.18.18.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Mar 2009 18:18:31 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090309115026.obsvt34miowwcw8w@webmail.fussycoder.id.au>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112662>

Please do not trim CC list; at least do not remove git mailing list
from addressees.

On Mon, 9 Mar 2009, thestar@fussycoder.id.au wrote:
> Quoting Jakub Narebski <jnareb@gmail.com>:
> 
> <snip>
> > I was thinking more about caching credentials by git rather than forcing
> > to use single connection.  Additionally you are solving the problem for
> > the HTTP(S) transport; admittedly for SSH there is much better solution
> > of using public/private keys, instead of asking for password.
> 
> What about public/private keys that also have a password?  Isn't that  
> the most recommended way to use ssh?

You use ssh-agent for that (via "ssh-add <private key>"), perhaps with
wrapper around it for example keychain. The "caching" is done by SSH,
no need to duplicate this in git.

-- 
Jakub Narebski
Poland
