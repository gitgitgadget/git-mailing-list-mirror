From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Git repository mesh?
Date: Wed, 25 Nov 2009 15:00:28 +0700
Message-ID: <fcaeb9bf0911250000u395c0153q43c8c7a60ca9b876@mail.gmail.com>
References: <fcaeb9bf0911242007t1294bddej87b48691ea283e21@mail.gmail.com> 
	<vpqaaybf37f.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Nov 25 09:01:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDCoz-0007jM-Ij
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 09:01:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755672AbZKYIBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 03:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752492AbZKYIBm
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 03:01:42 -0500
Received: from mail-px0-f180.google.com ([209.85.216.180]:50175 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbZKYIBl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 03:01:41 -0500
Received: by pxi10 with SMTP id 10so5570419pxi.33
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 00:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=gn0S46V017ORuBsbpRZbATn8/cEE9XkG+iyQCeg8mfU=;
        b=W54uOE5nJDA9qpwv/03m6kwpSvS0m/qVUHuHXL/FbgFGxxCiL7oskw6Uv9Gw2fuMGU
         JTCUz8DkFSvRwbLa6GjggV6y0I96hAySEPcmCYbmMKeU3AANHepds0ClKC82eTbvNVxk
         FmzED0e72dA0LT+2IV4mipUdRKIm8i/YzjtHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=uwmsqSGMYhx74Q5uunvF9229oaIC+Qx2ZwvgaN9A3WnTq7yHU7XXREJRHua0O8l7Dk
         HwYYlP5I7xN3sZvKSZEaTClJCCvlOEIcpqdTcWSX/nUZ4wX5p8DyE5lv38WHFWz4BSdN
         nQPiYuGqOJsdJ00XmWe61AzAr3hO9lIrZiYpY=
Received: by 10.114.187.3 with SMTP id k3mr5750675waf.82.1259136108239; Wed, 
	25 Nov 2009 00:01:48 -0800 (PST)
In-Reply-To: <vpqaaybf37f.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133616>

On Wed, Nov 25, 2009 at 2:55 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> Never used Mercurial but the idea of "git in" and "git out" to see how
>> many commits ahead/behind would be nice.
>
> In Git, you'd run "git fetch" to get everything locally, and then
>
> git log ..origin/master => what origin/master has that you don't
> git log origin/master.. => what you have that origin/master doesn't
>
> (and you can define aliases for that)

But I have many origins (any repository could be origin). "git status"
also have this kind of information, but only for "origin".
-- 
Duy
