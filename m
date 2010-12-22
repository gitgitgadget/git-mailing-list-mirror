From: Alexey Zakhlestin <indeyets@gmail.com>
Subject: Re: "git pull" doesn't respect --work-tree parameter
Date: Wed, 22 Dec 2010 14:40:26 +0300
Message-ID: <AANLkTinGPJRQCOVz5JeqL4xnUG9V=5fkJhz6C5Mi1A3o@mail.gmail.com>
References: <AANLkTi=UtZuPQcTNnwS_fXgzRn4MHAUGS8zyTMqX9E2J@mail.gmail.com>
	<AANLkTik9s0cLc_P=NWvpO=DhytOkLNASEM7sjzoscHo3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 22 12:40:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVN3Y-000487-84
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 12:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985Ab0LVLk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 06:40:27 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49663 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863Ab0LVLk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 06:40:27 -0500
Received: by iwn9 with SMTP id 9so5139290iwn.19
        for <git@vger.kernel.org>; Wed, 22 Dec 2010 03:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=QHTnQ9qmO8QemB5j59/s6dTGFzQ1Z1RJAgLh9XSYsRM=;
        b=CNq2Uny/TGMnp3SiXqkadD1WjJ5x5r1YlCnGrCeydDxqaCzIgdT96tt+rn+XHm4VgZ
         0Cl1xczZ5r/7xUt7aDAyhvm2LnpXObf3JKw48Or7Fz2q2awnncoqTsYmMbGepB07j7EP
         VVTulA6N8MTyURO+JbVxKDSjKVJXJead8A48Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Pm0DG0sYMdvcByb97CSzJQpWiJbFk23Dfd05UXjSDJ4a11sb84ejeD7WXcaDLQRRKV
         CdCHAJn32GoXOvrnGr2yOUx6EqxcEAzg5k/O9FBdEF3meJGeulstU4PiW/JM0F/EoP6I
         +0lghF29KJiSmkQCvhEiAcp+nNU8jJb4sijIY=
Received: by 10.231.199.196 with SMTP id et4mr6621897ibb.71.1293018026187;
 Wed, 22 Dec 2010 03:40:26 -0800 (PST)
Received: by 10.231.11.133 with HTTP; Wed, 22 Dec 2010 03:40:26 -0800 (PST)
In-Reply-To: <AANLkTik9s0cLc_P=NWvpO=DhytOkLNASEM7sjzoscHo3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164079>

On Wed, Dec 22, 2010 at 2:20 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Tue, Dec 21, 2010 at 11:04 PM, Alexey Zakhlestin <indeyets@gmail.com> wrote:
>> I am trying to use the following command:
>>
>> git '--git-dir=/path/to/repository/.git' '--work-tree=/path/to/repository' pull
>>
>> and get this error:
>> "git-pull cannot be used without a working tree"
>
> It works fine for me. What's the result of
>
> git '--git-dir=/path/to/repository/.git'
> '--work-tree=/path/to/repository' --git-dir

No directory given for --git-dir.

> git '--git-dir=/path/to/repository/.git'
> '--work-tree=/path/to/repository' --is-inside-work-tree

Unknown option: --is-inside-work-tree

> git '--git-dir=/path/to/repository/.git'
> '--work-tree=/path/to/repository' --show-toplevel

Unknown option: --show-toplevel


> Also what version of git are you using?

1.7.3.4

-- 
Alexey Zakhlestin, http://twitter.com/jimi_dini
http://www.milkfarmsoft.com/
