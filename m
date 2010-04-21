From: Aghiles <aghilesk@gmail.com>
Subject: Re: git pull behavior changed?
Date: Wed, 21 Apr 2010 17:34:19 -0400
Message-ID: <w2w3abd05a91004211434obc828fcbse5cd809c8419667a@mail.gmail.com>
References: <u2z3abd05a91004211413rcd2440fdq7946ef4764b24362@mail.gmail.com> 
	<v2hfabb9a1e1004211422ybbf47ef0gd5dfd1791eb03c16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 21 23:34:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4hZF-0001SE-Qx
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 23:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756697Ab0DUVem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 17:34:42 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62176 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756694Ab0DUVel (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 17:34:41 -0400
Received: by wyb39 with SMTP id 39so4370695wyb.19
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 14:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=w29C1MMA5YR61HRHRTATnQZj/d/PMsH0mE790jgOBus=;
        b=xBby7MHNoNVN13xJO/c9wii276b52R2gcF2YG4Y8824ConY7L54AkcyLcNy+oH5DPl
         kkUX5aBWBANOtI2H0f6ykNM9FVtvEidFqyCn0XbJrlCUB9AF9eIuLMj8+zOGtjxfEA6b
         rFwg1Ahq3WbzuTtnhXeCM+r/g+AlRTeR6uhGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=bTHVlx6fpYqKcfTrjxomO4+UVPBsEZ5GoYKxKT+kMUDDBe6ApIdJ66KrVfyXYgdicX
         yoCIdk8Lh/GYRNRkASA+8U1agYncZ/Ip44FjqHIVelbeUnTBxTmexS2xSPgifpixgeAW
         rGleKh5ZGpoZTM8Qq22itnDi6A0YyIw5ZW7rU=
Received: by 10.216.157.212 with HTTP; Wed, 21 Apr 2010 14:34:19 -0700 (PDT)
In-Reply-To: <v2hfabb9a1e1004211422ybbf47ef0gd5dfd1791eb03c16@mail.gmail.com>
Received: by 10.216.176.212 with SMTP id b62mr3322799wem.179.1271885679176; 
	Wed, 21 Apr 2010 14:34:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145462>

>
> When you do this you're telling git "I want a new branch from where I
> am right now". If you want to be able to pull in a similar way to how
> master works, use the '--track' option.
>

This means that when pulling I will be pulling from the remote ? That
is what I want to achieve. I just want all my branches to pull from the
same remote (as my master branch does).

Thank you for your help.

  -- aghiles
