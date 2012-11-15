From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 1/5] t/test-lib-functions.sh: allow to specify the tag
 name to test_commit
Date: Wed, 14 Nov 2012 21:43:23 -0800
Message-ID: <CA+sFfMfq69tawBCrWEmtb-ayxT056Fj-=rO8-ZpGqy5X4yPD6g@mail.gmail.com>
References: <1352943474-15573-1-git-send-email-drafnel@gmail.com>
	<20121115032005.GA20677@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Brandon Casey <bcasey@nvidia.com>
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 06:43:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYsEm-00059a-L7
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 06:43:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280Ab2KOFnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 00:43:24 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:52439 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980Ab2KOFnX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 00:43:23 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so1799637iea.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 21:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+/klWeY5vG50ry1YgRRrSWqe0QDrQjX3Pbl/Ag488Lk=;
        b=PKCLwQGNNIkgVq9qVi7zQQt1fSbZ/i1Jb7J4aGeo1EXP60b/VDtxBlF6TyuqRutKu8
         7iauOsodkGB1ohaWU40AtsU5J8Ui9VKEJ8elyxKU8enIn3JObKmSvmCcGJLI60Zu8JSI
         CSQl91VJpq6f8TjRKs17FkSOSQMU4IUdxkU0fHuF/3RFUja0VeLia7d1bxtAmBB6zr1Z
         pAgpR+k/GxbYGkbsBb469Me+Cc1Xi/8TrA0IXGGVEIpHGvAg9wgx7e1wcY74c9oDT/VB
         DvRrBtNR9NtKpX6wbr15HORifuINNwmjPmmPM6LqE3s79CZW8LswNsGaPllfFThQnY6w
         hEBA==
Received: by 10.43.46.2 with SMTP id um2mr33134icb.18.1352958203446; Wed, 14
 Nov 2012 21:43:23 -0800 (PST)
Received: by 10.64.49.73 with HTTP; Wed, 14 Nov 2012 21:43:23 -0800 (PST)
In-Reply-To: <20121115032005.GA20677@ftbfs.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209796>

Good eye.  Thanks.

On Wed, Nov 14, 2012 at 7:20 PM, Matt Kraai <kraai@ftbfs.org> wrote:
> On Wed, Nov 14, 2012 at 05:37:50PM -0800, Brandon Casey wrote:
>> -# Both <file> and <contents> default to <message>.
>> +# Both <file> <contents> and <tag> default to <message>.
>
> I think this line would be better as
>
>  # <file>, <contents>, and <tag> all default to <message>.
>
> since there's now more than two arguments that default to message.
>
> --
> Matt
