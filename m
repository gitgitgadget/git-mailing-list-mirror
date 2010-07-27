From: Tong Sun <suntong@cpan.org>
Subject: Re: Recommended work flow with git to send in patches
Date: Tue, 27 Jul 2010 11:47:34 -0400
Message-ID: <AANLkTinEQKuxHD6MbXq43E=AWymebvoWXM5v2Tm6vejw@mail.gmail.com>
References: <AANLkTiksAOpFG3vGVGcbeZ0NcpQ5FbDjnZ7yDxUsAY_r@mail.gmail.com>
	<20100727153901.GA5351@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 17:47:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdmNZ-0007aD-Ty
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 17:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476Ab0G0Prg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 11:47:36 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:41060 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab0G0Prf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 11:47:35 -0400
Received: by pzk26 with SMTP id 26so1422031pzk.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 08:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=cKU17ry9Gabgb5/CJr+Mq/8vCS7txLJFyHFNt5xuZRE=;
        b=xq/Ta2TvQrZEeelk1lG/z4sfAHryvipqLn/aEjGcIHpJFGL1GyxcxixBd62Ns9QTI3
         rpWDRJpP6rXHnt36D8uOYhj99frV9JhAOqhghs7x2FjKs73tPKsCl2eGeenx6Tcv1rXl
         9tnRaRh+D0CnmGtaKd6jxiY3NtNCYIly5kOQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=W19IzbuiXk4PDsP3pov6IIuDkfXJW7O7I5BCcweVPx6nmNqpYc0chXzOjV358do8x1
         I2HZAeQgWxYJkERuNLq3t2Ys3Yxjy4xZaOnrCUKVQdc+bAGHU7/6ZCJPzfp4Vff6tjLn
         3t+viWE4PD2BrLhvlXUBlt4+HehKAd4sPnoWQ=
Received: by 10.114.132.13 with SMTP id f13mr692886wad.35.1280245654868; Tue, 
	27 Jul 2010 08:47:34 -0700 (PDT)
Received: by 10.114.130.11 with HTTP; Tue, 27 Jul 2010 08:47:34 -0700 (PDT)
In-Reply-To: <20100727153901.GA5351@kytes>
X-Google-Sender-Auth: IpnfPWItq7JH0GiwGhOxWN2ndvg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151952>

On Tue, Jul 27, 2010 at 11:39 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:

>> Compressing my "life long story" into a single question -- what's the
>> recommended work flow to work with git and send in patches, when
>> upstream might be slow in respond, and require squashing relevant
>> patches into one?
>
> Personally, I use `git symbolic-ref` to create a new branch without
> history, stage and create commits to send off to the list from there;
> it's also worth noting that I keep the branch to fixup my commits and
> re-roll after reviews.

Thanks a lot for the comment.

Could you elaborate it a bit with actual commands, starting from 'git
pull git://remote/project master' please?

I'm new to git and the above comment barely helps me to put all jigsaw
puzzle together.

thanks
