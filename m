From: "Pau Garcia i Quiles" <pgquiles@elpauer.org>
Subject: Re: [ANNOUNCE] GIT 1.6.1
Date: Thu, 25 Dec 2008 19:53:58 +0100
Message-ID: <3af572ac0812251053q3b3c27e1i109a780fa657dd1f@mail.gmail.com>
References: <7v7i5odams.fsf@gitster.siamese.dyndns.org>
	 <20081225100033.GA8451@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 25 19:56:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFvN9-0005Zu-Kg
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 19:55:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbYLYSyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Dec 2008 13:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbYLYSyB
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Dec 2008 13:54:01 -0500
Received: from mail-gx0-f13.google.com ([209.85.217.13]:51669 "EHLO
	mail-gx0-f13.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448AbYLYSyA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Dec 2008 13:54:00 -0500
Received: by gxk6 with SMTP id 6so2902752gxk.13
        for <git@vger.kernel.org>; Thu, 25 Dec 2008 10:53:59 -0800 (PST)
Received: by 10.64.249.6 with SMTP id w6mr7831002qbh.16.1230231238797;
        Thu, 25 Dec 2008 10:53:58 -0800 (PST)
Received: by 10.65.38.1 with HTTP; Thu, 25 Dec 2008 10:53:58 -0800 (PST)
In-Reply-To: <20081225100033.GA8451@b2j>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103908>

On Thu, Dec 25, 2008 at 11:00 AM, bill lam <cbill.lam@gmail.com> wrote:
> On ubuntu64 8.10, the NO_UINTMAX_T seems cause some trouble, I have to
> comment out the block (in the Makefile),
>
> fdef NO_UINTMAX_T
>  BASIC_CFLAGS += -Duintmax_t=uint32_t
> ndif
>
> to make a successful compilation. Does it happen to me only?

Works for me both in Hardy and Intrepid. If you have trouble building
from source, there are binary package for Hardy and Intrepid in my
PPA:
http://launchpad.net/~pgquiles/+archive

-- 
Pau Garcia i Quiles
http://www.elpauer.org
(Due to my workload, I may need 10 days to answer)
