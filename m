From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/5] t/t7006: ignore return status of shell's unset
 builtin
Date: Wed, 2 Jun 2010 00:47:37 -0500
Message-ID: <20100602054737.GA9369@progeny.tock>
References: <Wt_M4qptcPdpY0Q3jqUbfIk6yMCN9Ja5RCtRUsADK5OJGrz7R_Cq1oGpeQoN7A9uCvw38jm63Jo@cipher.nrlssc.navy.mil>
 <Wt_M4qptcPdpY0Q3jqUbfMMZpuKZEHudj8tavRDS41LEhIuAY6Jac5ja0dD0ZRTTyKV_0v7MM6g@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jun 02 07:47:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJgnk-0003C1-8H
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 07:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870Ab0FBFre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 01:47:34 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42860 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112Ab0FBFre (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 01:47:34 -0400
X-Greylist: delayed 5691 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Jun 2010 01:47:33 EDT
Received: by yxl31 with SMTP id 31so766487yxl.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 22:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=UoqjSKgsHISg7dRZHHaCdSviiQRroDh1tRuqx7ZgYxk=;
        b=ifyV2vbud9c2BY+bTbganCeKl7e5N0KRaS3zYaIc5xlkSlyK4jWncWqx6QsU++TIpw
         pcZ17742Clh28SzJ3Sw5Y7roR97PJZPBsgORy/dB4e1MT6Qh4Repcwf2kysaDJW77g7e
         lJgInW2n2k7AimwV5zTDayeE0WZyWpx/pLpig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vvqVeCBgGsC9SFpn1VpswLxEKCR2UYM5vSz3RMVJ6cVOEjyTnDxfyY9Kulf3kpg8PM
         5wPF4QQH/IC6eVFFwHwcL/0VjrIh/9F/6fH+bU7+O/S+5eVmHfxksOXsVST9uFo0QdZ/
         w2FT6OofE6+AvkyPpSTksDmnWjg4u7H3ts/a8=
Received: by 10.231.170.1 with SMTP id b1mr9267436ibz.13.1275457652614;
        Tue, 01 Jun 2010 22:47:32 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id d9sm34908980ibl.22.2010.06.01.22.47.30
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 22:47:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Wt_M4qptcPdpY0Q3jqUbfMMZpuKZEHudj8tavRDS41LEhIuAY6Jac5ja0dD0ZRTTyKV_0v7MM6g@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148202>

Brandon Casey wrote:

> The unset builtin of Solaris's xpg4/sh returns non-zero if it is passed a
> variable name which was not previously set.

This is historical ksh behavior (only changed in 2009-01-14) even if
it violates SUSv2.  It probably comes up on a lot of platforms.
Thanks.

Acked-by: Jonathan Nieder <jrnieder@gmail.com>
