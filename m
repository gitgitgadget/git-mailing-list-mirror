From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Clone from shallow bundle bug
Date: Wed, 1 Apr 2015 20:36:21 +0700
Message-ID: <CACsJy8BR=JjJ_WJ+wGLk_AhpjRh+avJnRb2KmRiVx_+2cintLA@mail.gmail.com>
References: <551B0D37.5070407@ubuntu.com> <CACsJy8C0wMFiPw1thSWN-dPVW+9N=JXDsy_HFCj=Oyu2rf40eg@mail.gmail.com>
 <551BEA4A.9050708@ubuntu.com> <CACsJy8C4G01LOhg13=rhkCTMGTq-NTHgG-k-kaoT9jALnd7CZw@mail.gmail.com>
 <551BF2E6.6050000@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 15:36:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdIpF-0002Cc-1W
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 15:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408AbbDANgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2015 09:36:52 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:35767 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084AbbDANgw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2015 09:36:52 -0400
Received: by ierf6 with SMTP id f6so42699287ier.2
        for <git@vger.kernel.org>; Wed, 01 Apr 2015 06:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4DRwbxMmi2Hcs8atf4hEimyQL1sxOhm4xEFdmyUUve4=;
        b=FqXIGxTSqAJ9YoG2hoH8HUXQxLir/xeiWA1dUpXZyu0jYBxHLCCV+6xzztVEQd7IKq
         tmXIjQvuZUM5Dvkk7mpFdCWl8klenbFEvb/X/yPOcbcMU47CG9QY21+kLcIGElPTWsDs
         rDWOlaaVIB5j3KY4j5ANqKGjCd8unqIc5z5OGAIPORkJjQKLToVtgbUTdECvkn+ozJ6s
         ej/2I6N/AWo9zdMg+gdFVrutV8QZAfGY7hknMYx3sSrXt8LbqTqsKi/n2Gm7dhS78mGy
         IeKPmrppaP+lHy59uICjJ1eY2T6sLej+IrJYprOCyPD8yDJMhn2Wt1QhQZmxl/pMEKes
         rx/w==
X-Received: by 10.43.84.134 with SMTP id ak6mr15438288icc.45.1427895411194;
 Wed, 01 Apr 2015 06:36:51 -0700 (PDT)
Received: by 10.107.47.170 with HTTP; Wed, 1 Apr 2015 06:36:21 -0700 (PDT)
In-Reply-To: <551BF2E6.6050000@ubuntu.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266608>

On Wed, Apr 1, 2015 at 8:30 PM, Phillip Susi <psusi@ubuntu.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 4/1/2015 9:09 AM, Duy Nguyen wrote:
>>> Strange; it works fine for me using git 1.9.4.msysgit.1, and then
>>> I just get the complaints from gitk.  I created the bundle with
>>> no prereq argument, i.e. "git bundle create shallow.bundle".  Did
>>> you use a prereq argument?
>>
>> No, just your command plus a branch name. I tried v1.9.4.msysgit.1
>> (but on linux, not windows), clone rejected too.
>
> Even stranger... when I use a branch name, the clone fails, but not
> when I use a detached HEAD.

Thank you. I can reproduce it now. We need to plug this hole.
-- 
Duy
