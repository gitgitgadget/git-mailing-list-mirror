From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 5/6] gitweb: remove PATH_INFO from $my_url and $my_uri
Date: Mon, 29 Sep 2008 15:05:16 +0200
Message-ID: <cb7bb73a0809290605o106a34bbxc3e5e48f4b1a45f4@mail.gmail.com>
References: <1222030663-22540-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1222030663-22540-5-git-send-email-giuseppe.bilotta@gmail.com>
	 <1222030663-22540-6-git-send-email-giuseppe.bilotta@gmail.com>
	 <200809291033.34588.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@ucw.cz>,
	"Lea Wiemann" <lewiemann@gmail.com>,
	"Shawn O. Pearce (interim Git maintainer)" <spearce@spearce.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 29 15:06:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkISL-0001pF-IK
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 15:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbYI2NFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 09:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbYI2NFT
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 09:05:19 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:55355 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbYI2NFS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 09:05:18 -0400
Received: by yx-out-2324.google.com with SMTP id 8so304943yxm.1
        for <git@vger.kernel.org>; Mon, 29 Sep 2008 06:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=bSwPOGiFx5csI13SmpCUGx1ScwbUd15rDH172sQtTl0=;
        b=mIoyuq8xnoMt+gjJhP3ECod/0EPt6xWbY0o/tFyzTONxOzQ3xripx4i2cRTBIh30RN
         CThDFBdlsUw5YnESg7M119QHWFh4Dpupbw4W1eKoHp+8eNCTu166paba+udjYvYXnJ2k
         wa6fbk5dRtpZKaDGtMzePJd5Pb4ToAur4FF8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=XDAv+PZxdvSLvZiwD5ovgtUw4ZfYKEVDQJzyJQVOeVQ9ij9U+mgf/f0Eye1bwWR+Dd
         ffHnHLBieapycXGllzQ0UTtkAcSi5T4ruADgnXRBjAkpcHDgmxfnrL0WmirBmShxnrvM
         CoffaCCW5fKf3TOcLbzU6D4QK2sDjwNiia1T0=
Received: by 10.151.7.4 with SMTP id k4mr7833504ybi.128.1222693516878;
        Mon, 29 Sep 2008 06:05:16 -0700 (PDT)
Received: by 10.150.155.12 with HTTP; Mon, 29 Sep 2008 06:05:16 -0700 (PDT)
In-Reply-To: <200809291033.34588.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97008>

On Mon, Sep 29, 2008 at 10:33 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Sun, 21 Sep 2008, Giuseppe Bilotta wrote:
>
>> This patch (combined with appropriate server configuration) allows usage
>> of the gitweb CGI script as DirectoryIndex for the server root even when
>> the pathinfo feature is enabled.
>>
>
> This is IMHO a bugfix for a path_info handling bug, for which there
> was an ugly workaround of specifying base URL ($my_url and $my_uri)
> explicitly in gitweb configuration (GITWEB_CONFIG).
>
> Therefore I think that this patch should have been sent outside of
> the rest of "new path_info features" series, as a separate single
> patch, and now that it is there it really should be applied, perhaps
> even to the 'maint' branch.

Ok, I'll resend it separately, with the suggested fix.

-- 
Giuseppe "Oblomov" Bilotta
