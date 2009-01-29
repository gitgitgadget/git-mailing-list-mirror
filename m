From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: do you recommend "git" (over svn) for a 1-person team???
Date: Thu, 29 Jan 2009 15:28:09 +1300
Message-ID: <46a038f90901281828t16ace3bdocc897eb5235d7c30@mail.gmail.com>
References: <d30068860901281718x363348caya2dc94e798cc8091@mail.gmail.com>
	 <d30068860901281725t14d19c1vc0557182bca3eb8d@mail.gmail.com>
	 <885649360901281815q42199468v8658d864386efe2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Greg Hauptmann <greg.hauptmann.ruby@gmail.com>, git@vger.kernel.org
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 03:29:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSMev-00026n-Gf
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 03:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbZA2C2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 21:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968AbZA2C2M
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 21:28:12 -0500
Received: from rn-out-0910.google.com ([64.233.170.186]:42166 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbZA2C2L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 21:28:11 -0500
Received: by rn-out-0910.google.com with SMTP id k40so2779764rnd.17
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 18:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VAjzFktQAGn/7C8LJJ6KXykOT3kvQWZe2rIM8veXCS4=;
        b=T/6ThGGoNx5xBMqREeJoULUs39xtsj9TawdCwOIqMs0i0QAZSfvK5C0Vg6338JVLh3
         nXscDO0CBrGnwvO14Gm8TBFdmHdA7WeMPAE4M44eB1jBk/7pAor4tnSU00pCaj6/cQJ1
         g+gtwMqELkaRK2ho8xn6l7Y7+okmJa/UBIb7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=P6P2Ic1Rpi1/E2VJDDul/HAjR4P8X6KqsxNenQ5Cosqu2BeZMUIT3lQw7rl85mkBDO
         v2NCCrcamoK2rhMGxOWXNS3hafH3XgDgoUHev2N3R047ugsw+wI9xa1RYg4HpCzeehut
         hxyN+Vts/hDsg4I7AvLVx+Nw94xmB8t8af3+Y=
Received: by 10.100.14.2 with SMTP id 2mr1191571ann.13.1233196089117; Wed, 28 
	Jan 2009 18:28:09 -0800 (PST)
In-Reply-To: <885649360901281815q42199468v8658d864386efe2d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107617>

On Thu, Jan 29, 2009 at 3:15 PM, James Pickens <jepicken@gmail.com> wrote:
> Greg Hauptmann <greg.hauptmann.ruby@gmail.com> wrote:
>> Do you recommend "git" (over svn) for a 1-person team???
>
> Yes, emphatically.  I do it myself all the time.

+1!

 - offline work on your laptop
 - "git stash"
 - keep various branches (experimental, feature, stable...), with
untold flexibility for cherrypicking, merges, etc
 - bisect!
 - visualise things with gitk
 - search with gitk for specific bits of code, changes (pickaxe), etc

once you start... it's a bit addictive...


m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
