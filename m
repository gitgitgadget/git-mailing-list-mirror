From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] completion: add new _GIT_complete helper
Date: Sun, 6 May 2012 15:47:21 -0500
Message-ID: <20120506204721.GD3063@burratino>
References: <1336231400-6878-1-git-send-email-felipe.contreras@gmail.com>
 <20120505155423.GA14684@burratino>
 <20120506103006.GI2164@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun May 06 22:47:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR8Mz-0000Da-Qs
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 22:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754516Ab2EFUr0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 May 2012 16:47:26 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34627 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365Ab2EFUrZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2012 16:47:25 -0400
Received: by obbtb18 with SMTP id tb18so7270779obb.19
        for <git@vger.kernel.org>; Sun, 06 May 2012 13:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QMhVXc2FCPgbewvtHWfsKCSdE0sJVYakDkuAtmsw9zk=;
        b=BohmtWbWnRZuAh9jzreJ3Uksw71akupRNhWwJ8/37x9Ji0f7KkvpMBqNQI0wY4Co6K
         aD6Sg9gjn9NVco9zDGqXmSP45ab3xWHccxi+kkltmxEhcNVaX0EzZ+n9cwzTaG19JWEk
         u58OHQICmW+XVX7s8ZfhKc0xlpC79UPgiF0An8fyidCUtzP2NWcZrdggtZ6bsNx8TZcu
         KcQaLMLVC6KrP0l19Lfs+ZLJb8QrDA9mFTMwf+5Ka3uIzI7emrzLaI1kyiyvvRY2dU8y
         qX2IN9ibmBqIi2y69PQ3AZYoB024HP/CjhD5Xv2i7CSbWy1X8elDW/S45swYNwQkdOJU
         Ldaw==
Received: by 10.50.34.200 with SMTP id b8mr7030073igj.50.1336337245212;
        Sun, 06 May 2012 13:47:25 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id hq3sm10375972igc.0.2012.05.06.13.47.24
        (version=SSLv3 cipher=OTHER);
        Sun, 06 May 2012 13:47:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120506103006.GI2164@goldbirke>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197210>

SZEDER G=C3=A1bor wrote:

> It's a configuration thing, so it will be used in .bashrc; I think
> it's quite unlikely that it will be used interactively.

Yeah, makes sense.  So naming the public functions _GIT_complete
and _GIT_ps1 sounds reasonable.

Sorry, usually this kind of discussion would be easy but there is an
element of the human interaction I haven't learned to handle well yet.
Thanks for your help.

Jonathan
