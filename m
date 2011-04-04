From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: GSoC 2011 : one more interested student.
Date: Mon, 4 Apr 2011 19:05:09 +0700
Message-ID: <BANLkTinKmGaw7HTrQUoameVXO4JUEtH_sw@mail.gmail.com>
References: <4D9912F8.60002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: tipecaml@gmail.com
X-From: git-owner@vger.kernel.org Mon Apr 04 14:05:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6iXR-0004G2-Qz
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 14:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323Ab1DDMFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 08:05:40 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50172 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754000Ab1DDMFj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 08:05:39 -0400
Received: by pvg12 with SMTP id 12so1320771pvg.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 05:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=YOArSJwtEwXZxeNCnHDu5zCqYkeY4Pa4vP2LxhxHVuE=;
        b=tFWmj3Lwg0djQni4e1hAXgvvGxXMlSlxnhrw4QakNGwX1IiPgjdqdYI2NO3Zn6hMJ2
         ju7AQlW5mcVUzc4V5wXBXV5ijm6LLV8iz1o7Wa6kOParM0e6wvuOqZ2AITb0z5zqNDpN
         x6gp8ksT9ns5jFpo4RKsDC8vp5+reSVoa+JQo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=XNbC5NovHmpv8RifryPxi9f1BLCRqr3W/5qVVR1RIx8+ibxB4VXr54iGz0oYP+Adz6
         jY9UOkPNU/R03dARomTMAKEYvEaQSpXHuovCLpQR1lRr9qjaVj/s8CEPECwJHLVg32ab
         6AD1rJR8I+Ivuv9rAGb/Y9R0n679Q6pjfhM+8=
Received: by 10.142.44.13 with SMTP id r13mr6619529wfr.328.1301918739115; Mon,
 04 Apr 2011 05:05:39 -0700 (PDT)
Received: by 10.68.54.201 with HTTP; Mon, 4 Apr 2011 05:05:09 -0700 (PDT)
In-Reply-To: <4D9912F8.60002@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170806>

On Mon, Apr 4, 2011 at 7:38 AM, Cyril Roelandt <tipecaml@gmail.com> wrote:
> * Build in more external commands
> I am wondering why these commands should be rewritten. You know what they
> say : "if it is not broken, do not fix it" :-p Do these commands currently
> have performance issues ?

On Windows, yes. Shell scripts are just not designed to work on
Windows. Bash and Perl also pull msys and perl packages in Windows
installation, which makes it big and less Windows friendly. Building
in commands also give them a higher chance of being libgit2-ifized
later on.
-- 
Duy
