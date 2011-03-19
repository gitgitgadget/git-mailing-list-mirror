From: =?ISO-8859-2?Q?Micha=B3_=A3owicki?= <mlowicki@gmail.com>
Subject: gsoc - Better git log --follow support
Date: Sat, 19 Mar 2011 20:24:20 +0100
Message-ID: <AANLkTi=n7e70UqYU+6wpG4cu95fsg39tVM6=7fpfdZFz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 19 20:24:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q11lN-0007PB-KP
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 20:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757241Ab1CSTYW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 15:24:22 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58167 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757142Ab1CSTYV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2011 15:24:21 -0400
Received: by iyb26 with SMTP id 26so5119549iyb.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 12:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=0vwA/G54S5tCS0ai/kGrOTjNKhTcujtpsc0/gyDB19U=;
        b=sLXCze0ccDw4qFM/CtuAdsI7tWxy1O/YWzgacbw4weFp8l3DJKj87WDVBxPp4d1Ta3
         fvEwX9DYPms//fYrfVELViHQWIbvOtT+wdoIWn6AoMBrGbJwYVMSbKgk5mgPHAaoHO7Y
         wGL7ilzGLLG6ZGJ6UfyG7NjXBf0qO070UiTW4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Pg7Je+cD46AqRvuNlc0SzvQbO9BFMyfSFvxC2BHeJIIiU23yRHU4AroN/7lOCPDIXT
         ukS4i7s/k5w+nkPfNPzZWUgTDFKnb0R7JGg88wxUhxgMqVFMDuzFJg3FLoxjAET+ugH5
         Uc2BmLghM9T9ypvI9j+RI1ayuNRtPgJEixots=
Received: by 10.42.135.2 with SMTP id n2mr3867606ict.251.1300562660806; Sat,
 19 Mar 2011 12:24:20 -0700 (PDT)
Received: by 10.42.227.136 with HTTP; Sat, 19 Mar 2011 12:24:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169456>

Hi!

I'm looking at idea about better git log --follow support from
https://git.wiki.kernel.org/index.php/SoC2011Ideas .There is something
like this - "[.. ] it does not interact well with git's usual history
simplification [...]". Can someone elaborate this? I've found History
Simplification in git rev-list man but don't know yet about issues
with --follow.

--=20
BR,
Micha=B3 =A3owicki
