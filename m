From: Frank Li <lznuaa@gmail.com>
Subject: Re: Implement --password option for git svn perl script
Date: Wed, 3 Feb 2010 07:47:13 +0800
Message-ID: <1976ea661002021547ue22909cy27009c1b8743ecd4@mail.gmail.com>
References: <a362e8011001290617n326a9dcx7c345ec31dff4ebe@mail.gmail.com>
	 <001636ed7681994278047e4e4a6f@google.com>
	 <a362e8011001290618g542be5f5y2777a925ba9bd936@mail.gmail.com>
	 <1976ea661001290704h3ed4761dscf95ba848b373555@mail.gmail.com>
	 <be6fef0d1002012015q2a10af1cq4c5e5f968039ee45@mail.gmail.com>
	 <1976ea661002012030h23aa415ek30aa6db23cb88d0e@mail.gmail.com>
	 <a362e8011002012237t640dd8b9sa1da0d221f5d03b6@mail.gmail.com>
	 <20100202090538.GA28437@dcvr.yhbt.net>
	 <a362e8011002020516i5d5adcf7k6553d62e633cec88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Wong <normalperson@yhbt.net>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Laszlo Papp <djszapi@archlinux.us>
X-From: git-owner@vger.kernel.org Wed Feb 03 00:47:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcSSl-0005lw-Pm
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 00:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523Ab0BBXrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 18:47:14 -0500
Received: from mail-yx0-f189.google.com ([209.85.210.189]:63705 "EHLO
	mail-yx0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806Ab0BBXrN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 18:47:13 -0500
Received: by yxe27 with SMTP id 27so624889yxe.4
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 15:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=aDLfqdZs5yDZzKmPCAKE/lFILk3D18blAT11keQOGg0=;
        b=Acn8g8XjGiqlGNT1tt+aEJFQJ4QPiX0z09U823ntVmnXqF25sQDXXF4T7I1rDSnfbF
         8PXm+uBVQr+6bYnZyDEKLrXoGVLCAYkk3hd+fd3PdiOqGu6nyZ5gf2B5Ihsc0m8TYd8Q
         vBf91yVC7+A8+tuKu/1EhfMJifMBbZRHoRIog=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=qK2TL3gkH4nyv5K07QwX6qfAb0kEmPZ8zLjW7XeRz6nmNTS7vNuN9ISi+VOwhGvqOb
         /iV6aZN3L38UA6QIWBZ+3SCjQ7PaKsPrl9fgrNesFhyttCFso9acERTwALMaKcqkqO59
         pnTnw8e+0cS83yIA2MjmhTw6YfOPZe/vs2t90=
Received: by 10.151.21.8 with SMTP id y8mr9608815ybi.211.1265154433081; Tue, 
	02 Feb 2010 15:47:13 -0800 (PST)
In-Reply-To: <a362e8011002020516i5d5adcf7k6553d62e633cec88@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138786>

Is it possible use OpenSSH method to let GUI to input passwd.
environment SSH_ASKPASS, which point to a application. when
passwd need, openssh launch this GUI application,  user can input
passwd at this GUI application.
