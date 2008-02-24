From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: on subtree checkout
Date: Sun, 24 Feb 2008 22:12:54 +0700
Message-ID: <fcaeb9bf0802240712u5bc7173du1fe67c3bcd89d1a4@mail.gmail.com>
References: <fcaeb9bf0802240134i46e276ajfe83071e0b18ce61@mail.gmail.com>
	 <m31w72d63a.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git mailing list" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 16:13:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTIXm-0003Uj-CY
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 16:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbYBXPM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 10:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbYBXPM5
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 10:12:57 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:32431 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbYBXPM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 10:12:56 -0500
Received: by fg-out-1718.google.com with SMTP id e21so947747fga.17
        for <git@vger.kernel.org>; Sun, 24 Feb 2008 07:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=PyKCP7cepqm3C+9oc/jcR96nDQEwpIpb1d7M+hILPOE=;
        b=wQUBB19HhgydEBWtSVSXx52IyM8F1VkdHBahCkci1yZIrHG79o6cXJKqf+sayfGVr9btWlsOzZf3nU5hICtcM6uznoZWwyQabF1GMpK/Ly3bu9mWc/t8bt0cUX0q7rdDvXp3/96wYR01RwRjLjbHO2wipdXblCukGvvXJBd+1Ks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FeQ1l09/jqBkz6nrdg6bavPn6/4HPmjBkUrCiaS2jDSaN/RIOZPHeMiJ9Y3TPFfHIcSKq9JdJkYaKtxPLyIA8uw2aVXtOE/V3fddCVboP0gVVp02e7jiG6gG68Jks2XCRb+gBP4jvCnyC7N+IxYqfKPAaAMW66/n6GIp4UXgmTQ=
Received: by 10.86.59.2 with SMTP id h2mr1726840fga.19.1203865974653;
        Sun, 24 Feb 2008 07:12:54 -0800 (PST)
Received: by 10.86.83.3 with HTTP; Sun, 24 Feb 2008 07:12:54 -0800 (PST)
In-Reply-To: <m31w72d63a.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74939>

On Sun, Feb 24, 2008 at 5:03 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>
> "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
>
>  > I'm going to implement subtree checkout. The plan is to save "index
>  > prefix" in GIT_DIR/prefix and update git commands to use index prefix
>  > when accessing the index. If I'm heading a wrong way, stop me now.
>
>  If I remember correctly previous trials to implement "partial
>  checkout" ("subtree checkout") feature, or at least discussions about
>  it, used index extension.
>
>  As far as I can see the problem lies in merging...

Can you elaborate? I'm really noob at merging.

>  --
>  Jakub Narebski
>  Poland
>  ShadeHawk on #git
>



-- 
Duy
