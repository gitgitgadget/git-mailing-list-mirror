From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: How to efficiently blame an entire repo?
Date: Fri, 30 Apr 2010 15:45:12 -0400
Message-ID: <x2s32541b131004301245o46d8e855va0b51ebce279398b@mail.gmail.com>
References: <r2l76718491004291612qbe0834ela89f0606e5f477e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 30 21:46:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7w9u-0005xF-Hu
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 21:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755401Ab0D3Tpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 15:45:51 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47420 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755247Ab0D3Tps (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 15:45:48 -0400
Received: by gyg13 with SMTP id 13so272390gyg.19
        for <git@vger.kernel.org>; Fri, 30 Apr 2010 12:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=I6HlYnUCL9alP63AWTkOnp09srL4PN2K8vUf5eL9uNU=;
        b=i+NU1eSpM0zBrm1/BxRy/s9Qr3H8cyufQKP6EZR26cSl9TKnMqQwAIrRLl5mK47Pu0
         aaG9mH0x0vRgVOCAeKlPWVIys5NUeZjaznL8EPVWYnMmIVNh5EuDTt8vLD3K0JoLy3Uw
         L+4m79y3m6uN8gDx8SGTgYibvFxJuelRYqqYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=QP0IFJCx4t+q+/vw5XrPw0yKd9vIbUzNVxdZnGk5hOzIrocitn0qPbJ0qzhlRuaMFs
         207rfJiDXLLacUS5PAhcpBPG5/FY/pTePoYquGcTFi38tJuMfBC0AjNv4VoAeu7S3wup
         dey3ZnyXxYXAnTj8zDld03Hwcf7QkP9pM5ca4=
Received: by 10.150.209.21 with SMTP id h21mr2650366ybg.118.1272656732899; 
	Fri, 30 Apr 2010 12:45:32 -0700 (PDT)
Received: by 10.151.109.5 with HTTP; Fri, 30 Apr 2010 12:45:12 -0700 (PDT)
In-Reply-To: <r2l76718491004291612qbe0834ela89f0606e5f477e2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146058>

On Thu, Apr 29, 2010 at 7:12 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> Let's say you've got a repo with ~ 40K files and 35K commits.
> Well-packed .git is about 800MB.
>
> You want to find out how many lines of code a particular group of
> individuals has contributed to HEAD.
>[...]
> Am I missing a clever solution?

How often do you need to do this?  If it's just once in your life,
then the brute force solution of just letting 'git blame' grind
through it for a few hours is probably the cleverest :)

Have fun,

Avery
