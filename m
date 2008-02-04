From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [RFC/PATCH] Fast forward strategies only, common, fork and path
Date: Sun, 3 Feb 2008 23:19:54 -0800
Message-ID: <402c10cd0802032319j757e6f9arddca84255a9f9fad@mail.gmail.com>
References: <402c10cd0802031654r3e0275a8s1d2163af9525e7d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 08:20:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLvcy-0005cl-Gr
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 08:20:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036AbYBDHT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 02:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753045AbYBDHT4
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 02:19:56 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:40023 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885AbYBDHTz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 02:19:55 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1913201fga.17
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 23:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=YX353e9xmmq04TeeRMAJejR6hYRBuHZFYwgtFut8S7Q=;
        b=n1+wyatt4gU1vAO3rwQq+wZ5neafpMorhK0RDVy1dtQkyX+Fp3X/02ZfkqqnyYKraMJXNxzb9apovuJW1i2cnhMcNAS1vERkHvXPO94Rs8QPduQLl06YuiMW306y06gJFCm5u10PcWt5A1k7vQZbxYSf/E4u0JZ4h9TgQDdVhCc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BVU4Z3XTciSlBXHUv++4ra4G+tt1QZNYV/7eQ2Pf1i5D2ZKZOOQOgCpt5r0X9+A1VywbkDZ2CbtmBGke9kxwKPw4MsnzYre0La6RZ8TWp1n0K+c0sYBXnK6NTehhv8jDF8KdT8JioQ8LNDW34TKfBSvI57+gBsPXPfW6Nm4Uk0w=
Received: by 10.82.107.15 with SMTP id f15mr12509981buc.0.1202109594240;
        Sun, 03 Feb 2008 23:19:54 -0800 (PST)
Received: by 10.82.156.13 with HTTP; Sun, 3 Feb 2008 23:19:54 -0800 (PST)
In-Reply-To: <402c10cd0802031654r3e0275a8s1d2163af9525e7d2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72468>

On Feb 3, 2008 4:54 PM, Sverre Hvammen Johansen <hvammen@gmail.com> wrote:
> find_real_parents ()

We should probably implement this using "git show-branch --independent
<heads>".  Will this command do the same job (except showing which
branch is ff_head)?

-- 
Sverre Hvammen Johansen
