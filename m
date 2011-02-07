From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] cache-tree: do not cache empty trees
Date: Mon, 7 Feb 2011 06:32:50 -0600
Message-ID: <20110207123250.GA11854@elie>
References: <1296899427-1394-1-git-send-email-pclouds@gmail.com>
 <1296914835-808-1-git-send-email-pclouds@gmail.com>
 <20110207091740.GA5391@elie>
 <20110207095713.GA19653@do>
 <20110207121855.GA7298@LK-Perkele-VI.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Mon Feb 07 13:33:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmQHG-00048A-9j
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 13:33:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527Ab1BGMdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 07:33:04 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:54788 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762Ab1BGMdD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 07:33:03 -0500
Received: by qwa26 with SMTP id 26so3428123qwa.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 04:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=/JkXpJWryIoTH6zUKPzcMcpgMqfAaJDHn/yPVRVZYZE=;
        b=OcCtLilO6zFQbBVFuphCMWgMivGUZcGMyWF7EMq00aHOCzIEd0VHShwgcBGvj5O2TG
         euesWBLuyq22HZdZ9eKEcn2L1FZgtUyKDOi+oy8DIItCJGjkNWFzywQccIDLb/rILx/L
         c2VWMSVJsow/Ky4BlEIcVSNn1ujpNoclKswoI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=srwgfPe45HuHh6LmCFGAA6zuiX8KulGqdMeSKBD0dOXznZosLsTRL8unmLhHIfQGZ0
         +K+PaGin3ATcQh6f11LJbvYY3ZUhIserEFXnvrxBEDeoeEke6nrZVI9xsKKMhP25Ep4q
         UT037jMUclX0Bhj7h63encdGxwfs530uNHKAo=
Received: by 10.224.11.71 with SMTP id s7mr14384913qas.13.1297081982261;
        Mon, 07 Feb 2011 04:33:02 -0800 (PST)
Received: from elie ([76.206.235.233])
        by mx.google.com with ESMTPS id g32sm2807664qck.34.2011.02.07.04.32.57
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 07 Feb 2011 04:33:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110207121855.GA7298@LK-Perkele-VI.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166260>

Ilari Liusvaara wrote:

> Remember, many distros ship with old versions of Git. Debian stable
> is now at 1.7.2.3 (Squeeze became Debian 6.0) and it'll take years
> before next release. What about these?

The next Debian point release is scheduled for a month from now. :)
There will probably be more point releases after that.
