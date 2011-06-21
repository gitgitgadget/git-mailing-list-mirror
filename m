From: Kasra Khosoussi <kasra.mail@gmail.com>
Subject: Re: corrupted Git repository
Date: Tue, 21 Jun 2011 15:10:01 +0430
Message-ID: <BANLkTimQarJ=m7OSVg-uC_48eh3PxQ3cKw@mail.gmail.com>
References: <BANLkTi=A=DpyfNwEeSd6N6ibCsA5qh_NPQ@mail.gmail.com>
	<4E005404.5010901@drmicha.warpmail.net>
	<BANLkTi=WVTGcGkUXjkuPYcxhMY0a5KPB7g@mail.gmail.com>
	<4E006682.80101@drmicha.warpmail.net>
	<BANLkTi=GdEfXnAGa6V-33wqX2C-2x-9JQQ@mail.gmail.com>
	<20110621103947.GA30147@LK-Perkele-VI.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Jun 21 12:40:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYyNO-000391-M7
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 12:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755310Ab1FUKkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 06:40:03 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37043 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650Ab1FUKkC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 06:40:02 -0400
Received: by pvg12 with SMTP id 12so1367734pvg.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 03:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=9j+KuCT3epLyHHRt0/32HWJ8Nc+4oEaLE2F75QvJ3lw=;
        b=kT+HSywKE6C7ZSmYDdh5EY0by6VYy0fWB4LmpHcBwnbgIuoqfBDqcZZ0edsM6crsTP
         rdIc4YJ+du3iIlzeLhY7Tn+UPIMqE8aeW3yVNZcUD4sMZXABY/L+ZbOJmUxPgc8udZRd
         fUJgfCnMsprKhgbOUf/VsIjCydyXAERrLBFes=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=VLPAJcDuEFVRvrQjh6VzmVr6MXVgUG1zpcOgP+Dv3Qq72yrON2yvoNYv5P4bfdk6XF
         2tov/kBWTQbE6Lp6pAJ58jQCGC9n++R+MQjsuujNPGZ8Qnin+BK3ZZnJkyhgUbx2B06c
         oAbUZD6MbwjRHmHExe3k1771ZR8NzGYaLCK9c=
Received: by 10.68.19.131 with SMTP id f3mr2563115pbe.379.1308652801067; Tue,
 21 Jun 2011 03:40:01 -0700 (PDT)
Received: by 10.68.55.132 with HTTP; Tue, 21 Jun 2011 03:40:01 -0700 (PDT)
In-Reply-To: <20110621103947.GA30147@LK-Perkele-VI.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176136>

Thanks for your help.

On Tue, Jun 21, 2011 at 3:09 PM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> On Tue, Jun 21, 2011 at 02:40:47PM +0430, Kasra Khosoussi wrote:
>> Thanks for your help.
>>
>> I used update-ref and changed refs/heads/master to the sha1 of
>> previous commit. Then I commit the changes. Everything seems fine now
>> except (as you previously mentioned), git fsck -full complains about
>> dangling trees. Is it critical?
>
> Dangling trees are normal. They are not errors.
>
> -Ilari
>
