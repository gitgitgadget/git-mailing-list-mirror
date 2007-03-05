From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Git checkout preserve timestamp?
Date: Mon, 5 Mar 2007 16:01:45 +0000
Message-ID: <200703051601.49370.andyparkins@gmail.com>
References: <17895.18265.710811.536526@lisa.zopyra.com> <200703051213.52513.andyparkins@gmail.com> <17900.11612.872928.633406@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Bill Lear <rael@zopyra.com>,
	Karl =?iso-8859-1?q?Hasselstr=F6m?= <kha@treskal.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 17:02:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOFdl-0007w0-Qc
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 17:02:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030579AbXCEQCQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 11:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933593AbXCEQCO
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 11:02:14 -0500
Received: from wx-out-0506.google.com ([66.249.82.232]:63367 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933594AbXCEQBz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 11:01:55 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1609680wxd
        for <git@vger.kernel.org>; Mon, 05 Mar 2007 08:01:55 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=W5ftF3BVffNqBwebCkTk/6umvjde9p4ySOJal3dcRxISTglUq55mv/IMqof0O57juWQxdnc9N30ug6V+PQJEj46o2WRrxUUGS/csPznVnFxTjYCghHCU6yKjXZkE9sRE4Id9IBG/Yc1p97qqtP3MlxBsYmKCD4oLAPLi87Exv9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gGyrZKrw6XlOEFWNIC5iXMhPELdgkXeZQhceuTn8x4zRebIzHWA5tDOe3cTkLz0LY4W5bXgZvY/jbHMtTiYGZZZKOqBOPlegO084DVXy2tSe9TteDSXLkgWzlEQl9QUqlkjOQQaXKm1ZACXRqEzGKpamtJLYDHe4nfrWiaSDCOQ=
Received: by 10.90.93.6 with SMTP id q6mr4721291agb.1173110514387;
        Mon, 05 Mar 2007 08:01:54 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id n22sm23361283nfc.2007.03.05.08.01.51;
        Mon, 05 Mar 2007 08:01:52 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <17900.11612.872928.633406@lisa.zopyra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41455>

On Monday 2007 March 05 14:46, Bill Lear wrote:

> All very wrong if you ignore what I wrote as part of my original note:
> keep compilation products separated by branch name, not in the same

I realise why it's causing you troubles.  However, I was hoping that that 
little example shows why it can never be right to use the timestamp out of 
the repository.

> place.  This is essential to my request: without it, it is indeed very
> wrong.  We currently separate out by compiler, options, machine
> architecture, and adding the branch to that is trivial.

I'm afraid that the unnecessary recompile is just a by-product of that 
organisation.  I still say that git is correct to touch the file dates.

[blatent plug]: perhaps my poorman's submodule support will get you by until 
real submodule support is implemented?

http://lists.zerezo.com/git/msg334639.html

I doubt it though - as you would probably want automatic checkout in your 
situation.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
