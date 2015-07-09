From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 08/10] tag.c: use 'ref-filter' APIs
Date: Thu, 9 Jul 2015 18:25:57 +0530
Message-ID: <CAOLa=ZSp-X0Mo5BGWghdk56sM2AEAmnXZt7Y3VkfXWvf8rh96w@mail.gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
 <1436437671-25600-1-git-send-email-karthik.188@gmail.com> <559E5333.7080901@gmail.com>
 <vpqa8v58pka.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 09 14:56:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDBNV-0004ek-Mw
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 14:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422AbbGIM43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 08:56:29 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35740 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbbGIM41 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 08:56:27 -0400
Received: by obbop1 with SMTP id op1so171018147obb.2
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 05:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=scDutirtDpgpCLw/XTFQFhFZCsxPska5TD5P18snQ3E=;
        b=o3trGIewUUPC4Lg9ZQw4l2irp5c36OYzToxyYzZMZHUqNwMknAuBU5hAcXJRtNoEK5
         5xzXNPUf7i9zyCgp3CEWVnKQMKxw5T9iNWvOahVmEcsJ2Ip/xZeoMqg6btNDFmXwBMOI
         CaFZ7NZM8Be1XjkGMGaaqbWbqbei+o8pOR5h+fnF6WW63M3rPBsk2xOtKryss3+UkWhk
         bayv+Jw7P4yUJicRz3s1Qua0I1ftToBeZ3j+U6yGdwdjyN/UX19i2x8zpsicKBdOSgvL
         kKAYPV4BPjmIuH6l+lJ9McOB1lpqfGQOWpK/7TKbcMUuZXeaAaM9EYPkf3aAUFk3iRXO
         wq+Q==
X-Received: by 10.202.180.133 with SMTP id d127mr13910948oif.104.1436446587113;
 Thu, 09 Jul 2015 05:56:27 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Thu, 9 Jul 2015 05:55:57 -0700 (PDT)
In-Reply-To: <vpqa8v58pka.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273746>

On Thu, Jul 9, 2015 at 6:18 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>  Documentation/git-tag.txt |  16 ++-
>>  builtin/tag.c             | 343
>> ++++++----------------------------------------
>>  t/t7004-tag.sh            |   8 +-
>
> This patch was sent with Thunderbird unlike the others in the series. It
> has some line wrapping which make it unapplicable.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/

Yes, 'git send-email' started failing, hence 08/10, 09/10 and 10/10
were sent by thunderbird.
I'm trying to figure out why.
If anyone can help, this is what it's saying.
"[Net::SMTP::SSL] Connection closed at
/usr/lib/git-core/git-send-email line 1320.
fatal: 'send-email' appears to be a git command, but we were not
able to execute it. Maybe git-send-email is broken?"

-- 
Regards,
Karthik Nayak
