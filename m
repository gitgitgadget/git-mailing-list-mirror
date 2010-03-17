From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git branch --current?
Date: Wed, 17 Mar 2010 10:48:43 -0400
Message-ID: <76718491003170748h349c5ed0u7649864cc824f549@mail.gmail.com>
References: <fcaeb9bf1003170743kc347d53jefe41039e3b9a69a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 15:48:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NruYF-0007lN-Df
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 15:48:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754934Ab0CQOsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 10:48:46 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53109 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754291Ab0CQOsp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 10:48:45 -0400
Received: by pwi1 with SMTP id 1so788444pwi.19
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 07:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=itbQykUgtOBxVZbdfoqLkoiP+0jHwc+Zejnl2otTXc4=;
        b=LAh1WCX2xuR1wPR06Sk4ORpcOdIbiVCjja8Ts+d1+LZgCMPrl/d10yhnkdjQmKT9Oj
         appTkL9yPpekrfY7tzakpJgHz33hjLi4OaYdeBmJ3nOzbSqKwDkHHKMZ1iBjneCn9nqc
         w1M9gbqwdkfuDuvyAv1j/pzHxYCSt7OlFM7xM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=AjHeMTXwWv0QE5mtoYmHS+cdavlJ6u3sIaZKLs88Cxy8wA8FR4bREdu2oO+mALEiAX
         3cDWXYZ8T3/nSlwP/1Rt+mu2555mrXgtFz1jHi7PqpVlC2jvdY1FkA5p82FITaACwnY9
         QfDC1WcJCqCJR2P7vzVmgihjv7JGicG804wD8=
Received: by 10.114.28.7 with SMTP id b7mr448700wab.229.1268837323487; Wed, 17 
	Mar 2010 07:48:43 -0700 (PDT)
In-Reply-To: <fcaeb9bf1003170743kc347d53jefe41039e3b9a69a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142396>

On Wed, Mar 17, 2010 at 10:43 AM, Nguyen Thai Ngoc Duy
<pclouds@gmail.com> wrote:
> I use "git branch" when I need to know the current branch. But I have
> many branches, looking for the star is "time consuming". I'd rather
> have something like pwd, just print the current branch name and that's
> all. A bit more information about current branch wouldn't hurt, as
> long as the branch name is printed at a fixed location.
>
> What command do you use to know what branch you are on?

Doesn't everyone who's anyone put it in their prompt with the bash
completion script? :-)

Well, if not, how about a simple alias:

pwb = rev-parse --abbrev-ref HEAD

?

j.
