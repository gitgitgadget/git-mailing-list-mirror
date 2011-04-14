From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: BUG: git-svn dcommit and concurrency (Re: git svn dcommit errors
 all no-yet-commited changes are left squashed/uncommited?)
Date: Thu, 14 Apr 2011 15:05:52 +0200
Message-ID: <BANLkTi=zPehpahLZ8--GShey1kpxf85Tqg@mail.gmail.com>
References: <BANLkTikdGPW+B7rAEVj2DZhOS1HrtXjZ4Q@mail.gmail.com>
	<20110413224010.GA7640@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 15:06:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAMFD-0003iI-T7
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 15:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758372Ab1DNNFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 09:05:54 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49880 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431Ab1DNNFx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 09:05:53 -0400
Received: by vws1 with SMTP id 1so1247978vws.19
        for <git@vger.kernel.org>; Thu, 14 Apr 2011 06:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4E9IZDZfvmLXiKLGEHttEywb0RI0k40Hb8uWtQuFfOk=;
        b=Ch+x12XfcuzXDwqueNvSgcZQEH95NIqILpCDtP5qB33Pym+CDCSDd509EDJYLV7Rwv
         ll4y711shu5DwLHqreEnKQNgTsK4qeWtWGwimYK0bMelQNW9mAqj0etl753jfwlfCGWp
         X55k1fvhTSj5p3p7S8D3Z7TD4K3PjAdPnxpkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=CzxArYA464pdIZXO2MBJ+Nf8NObvUoz7GK/MnevXft5iavg65HxUc9QeZ7s7On7OqC
         DkjBKVBQZseTk2L9mhtnGfNM7wbvgq5FlN48UFsXEMOiXFIYvsGk1r1LpUjlZrJBn8W/
         p7Cszyd1n7bGMsdzNoONzXnC2ivfiG0shXIYo=
Received: by 10.220.96.130 with SMTP id h2mr223433vcn.121.1302786352647; Thu,
 14 Apr 2011 06:05:52 -0700 (PDT)
Received: by 10.220.180.202 with HTTP; Thu, 14 Apr 2011 06:05:52 -0700 (PDT)
In-Reply-To: <20110413224010.GA7640@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171514>

On Thu, Apr 14, 2011 at 12:40 AM, Eric Wong <normalperson@yhbt.net> wrote:
> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> wrote:
>> resending mail, this time with involved people on CC and with clearer message.
>
> Sorry, I don't have time to deal with this in the near future.
> Hopefully someone else can fix it.

OK, I'll try to debug this more later today.

I found a blog post about how to act when dcommit fails halfway -
providing for convenience:

http://blogs.gnome.org/diegoe/2009/03/18/saving-your-neck-when-git-svn-dcommit-fails/


-- 
Piotr Krukowiecki
