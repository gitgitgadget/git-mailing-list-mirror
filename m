From: "Denis Bueno" <dbueno@gmail.com>
Subject: Re: git-instaweb portability issue (maybe?)
Date: Fri, 13 Jun 2008 10:39:11 -0400
Message-ID: <6dbd4d000806130739r633cb34cx9edbe48724d6a325@mail.gmail.com>
References: <6dbd4d000806130626pfdb06f2qbfea6f1909710b7b@mail.gmail.com>
	 <6dbd4d000806130638k4461a41eo8ce6fe803505fa88@mail.gmail.com>
	 <20080613142118.GA20027@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Luciano Rocha" <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 16:40:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7ARm-0004bj-AK
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 16:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845AbYFMOjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 10:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752677AbYFMOjO
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 10:39:14 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:35496 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbYFMOjN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 10:39:13 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2779449fgg.17
        for <git@vger.kernel.org>; Fri, 13 Jun 2008 07:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=5YBKgJb7FCss+IhZShzIF1GSLQsm/f2dhWcmfmBC6nI=;
        b=OPUj10Dg9pvcUMF8MUzPP/qVwPc6DunLN0soiYgvH5nqvvUtFAqhH3M78APKiJGXT6
         HMbOdh+u4CnHj/kiHRUeUgSCiz9pMs5/z6BFCWExONBWGrQRa8a9cMrYHxFtwHJxlAC2
         PhrSgAJY2X2j+gPyKRaQfSqUVFCMHBhUmh3K8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=KI9oMgJKc5ucNA9CtXspAg1oQiVezqL+VRFtPTAo/uZujfj2tdgizE2WMoWylnpH9w
         DgoGiR1mIEnBCxhT+vt34rS3r6LcIWGwEYAMW92ELZIY3EDrzmzjfxDFkBcnW+WqNCPS
         Q0MaRadEU1/XK/AO0ovJ8KiNVvzmtj8enCYZ0=
Received: by 10.86.59.18 with SMTP id h18mr4107754fga.30.1213367951791;
        Fri, 13 Jun 2008 07:39:11 -0700 (PDT)
Received: by 10.86.59.7 with HTTP; Fri, 13 Jun 2008 07:39:11 -0700 (PDT)
In-Reply-To: <20080613142118.GA20027@bit.office.eurotux.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84882>

On Fri, Jun 13, 2008 at 10:21, Luciano Rocha <luciano@eurotux.com> wrote:
> Try changing the following line instead:
>        "$PERL" -p -e "$script" "$1.tmp"  > "$1"
> to
>        $PERL -p -e "$script" "$1.tmp"  > "$1"
>
> about line 6121 of the git-instaweb script.

This is line 6033 for me; however, this change makes it work!  (I
verified my changing this line; trying it; then changing it back to
the double-quotes version, and verifying it breaks.)

Why?

-- 
 Denis
