From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: diffstat witdth with one changed file
Date: Mon, 21 May 2012 22:52:22 +0700
Message-ID: <CACsJy8BrqaLbtVp5uF3q2Jo63DPwtFACYw3_rPy8eyNK7VSWMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 21 17:53:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWUv0-0001T1-B9
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 17:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754657Ab2EUPw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 11:52:57 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:60535 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754222Ab2EUPwz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 11:52:55 -0400
Received: by wibhj8 with SMTP id hj8so2519260wib.1
        for <git@vger.kernel.org>; Mon, 21 May 2012 08:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=3uGkgsshkseJdGOSFZVbROnpTyCuVt9WI6op3m9exow=;
        b=zWBXIJmmgh7egDTS9x0fj1AFHMn/t1WQGBAHb0rLrgzhuIuqdg9o7H0uxX+jKQWUP4
         xxynLyR8XOoVC8ipv47YPp4Zx07RBog+DjPlTIPvpAsv5ZPgTfhqALpKUt9uGerkM7EP
         BlziTkWoI590xl+lbcKABn3YA/ylZjZDRkNxzgJrpNPbyK5GFYLKFHul1+UicDB4weKy
         zG46EWiZGWMiGSSXRHRwW7imWa0b2kP7oOxBTs8aphi0WjZGLPRI7W4T/TeLEoUDydG7
         NuAlpgcCbLBW6sgogoa4nTlz0w7w7ttmXVgxt20KWzqFpJittksZ5oCBc1BP41sox2AF
         VyJw==
Received: by 10.216.216.95 with SMTP id f73mr70481wep.149.1337615572545; Mon,
 21 May 2012 08:52:52 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Mon, 21 May 2012 08:52:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198115>

Hi,

With recent git, "git log --stat 90e6ef5", the first commit's diffstat
uses full terminal width while the next one uses less than 80 chars.
Both changes one file. Is it intentional? I tend to think it's a bug
because with one-file changes, diffstat width is not important as we
have no other files to compare with.
-- 
Duy
