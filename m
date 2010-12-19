From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Commiting automatically (2)
Date: Sun, 19 Dec 2010 12:36:19 -0600
Message-ID: <20101219183619.GB11955@burratino>
References: <loom.20101219T090500-396@post.gmane.org>
 <20101219150850.GC12136@foodlogiq3-xp-d620.thebe.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Maaartin <grajcar1@seznam.cz>, git@vger.kernel.org
To: Taylor Hedberg <tmhedberg@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 19 19:36:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUO7u-0000xf-MN
	for gcvg-git-2@lo.gmane.org; Sun, 19 Dec 2010 19:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413Ab0LSSgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Dec 2010 13:36:35 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49455 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932242Ab0LSSgc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Dec 2010 13:36:32 -0500
Received: by yxt3 with SMTP id 3so1020532yxt.19
        for <git@vger.kernel.org>; Sun, 19 Dec 2010 10:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=sEbgzK9+F0eknxc7heQlzx8CqoP5zSpRdGqz+QMpoIs=;
        b=bh7lBdH10rDa7QO3Nhji90brQfTwT8g41T3/NuoGcpZ5PeinEYxNOFKXx4T29nY4VW
         oWQIzwhO/Hs4vGmSSiaYdkQWRBsfZEbkn/ESZSSeztTxfp1fHKM5RkRszaA7phta3VHv
         S1Qzf72P1Wj+m9dEZpvfFB2X3v7WfzUvzXM6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VFTW8zaS26Ye/gBYwY/pnWW9tB00kt0RGjBEVkDRHseuhi5GdHEVGSAOeYWmnXVUIW
         vpVcEmiZITwcK/VQ9Br8FP0qiNthnV7vfGSiRAVd9qdxK9lquFK5vN0hYrq7nxi1Q03c
         kZEGjW2qmHoeYEZxU2UUUvykAqCfEYzb+AZUI=
Received: by 10.150.190.4 with SMTP id n4mr5363154ybf.386.1292783791084;
        Sun, 19 Dec 2010 10:36:31 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id v8sm3729015ybe.13.2010.12.19.10.36.28
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 19 Dec 2010 10:36:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101219150850.GC12136@foodlogiq3-xp-d620.thebe.ath.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163965>

Taylor Hedberg wrote:
> On Sun, Dec 19, 2010 at 08:29:50AM +0000, Maaartin wrote:

>> There's one more problem. My script doesn't recognize deleted files, since
>> git add -A
>> does nothing to them. I'm quite sure I saw a solution to this, but can't find 
>> it now...
>
> I believe "git add -u" will do the same thing as "git add -A", plus
> handle deleted files.

Hmm, the "git add" manual suggests it is the other way around:

 -A, --all
	Like -u, but match <filepattern> against files in the working
	tree in addition to the index. That means that it will find new
	files as well as staging modified content and removing files
	that are no longer in the working tree.

So I would expect "git add -A" to do the same thing as "git add -u",
plus handling added files.

Maaartin, could you give an example showing where add -A goes wrong?
