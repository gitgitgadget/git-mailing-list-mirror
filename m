From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/4] remote-hg: add missing config for basic tests
Date: Tue, 13 Nov 2012 04:46:36 +0100
Message-ID: <CAMP44s2GzX_+6+eNU5n6kGue_-MWvU9qNXAr3Caw3A7nWhkawA@mail.gmail.com>
References: <1352742068-15346-1-git-send-email-felipe.contreras@gmail.com>
	<1352742068-15346-2-git-send-email-felipe.contreras@gmail.com>
	<20121112203207.GF4623@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 04:46:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY7Se-0003lX-4C
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 04:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781Ab2KMDqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 22:46:38 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:49179 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453Ab2KMDqh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 22:46:37 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so7010096oag.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 19:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VHjlM4ef+gTb7pPisyfOjOBasltToGA7v64xT4fzHc0=;
        b=HuppsHQ+jDB/daFrwdPnuinhYZ38519UMVrzsP/ogcCYP4rImsLi/zC4NKBRWkxvS6
         80EZskhpD4Wnqc45101wY98CvOjY7KEgdFqri7CcNwm7epxHn/7Jqyd4ek7dNbHqLTJX
         r8RaDfIvRMkYhtzXe8qIZY3NtIW44o7ZBP+X/20TGFQ+vDHPZqd3NimT5WVHzScWOqnq
         q1AHR4lcvaLxgE8tb0tQjkdTJGez6e4Ah7rJ9XXAelZAGeGFyDmsbOCrqQngGmpoEyHp
         Fzc1K+X/76rZeOqs6paIjQd3+ZiIhyxcpYXCuR/AR7vku/IEiYMkSzhD3Ve1jIougP7t
         4FtA==
Received: by 10.182.245.20 with SMTP id xk20mr16994260obc.89.1352778397035;
 Mon, 12 Nov 2012 19:46:37 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Mon, 12 Nov 2012 19:46:36 -0800 (PST)
In-Reply-To: <20121112203207.GF4623@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209566>

On Mon, Nov 12, 2012 at 9:32 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Nov 12, 2012 at 06:41:05PM +0100, Felipe Contreras wrote:
>
>> From: Ramkumar Ramachandra <artagnon@gmail.com>
>>
>> 'hg commit' fails otherwise in some versiosn of mercurial because of
>
> s/versiosn/versions/
>
>> +setup () {
>> +     (
>> +     echo "[ui]"
>> +     echo "username = A U Thor <author@example.com>"
>> +     ) >> "$HOME"/.hgrc
>> +}
>
> This makes sense, but I wonder if we should use something different from
> the git author ident set up by the test scripts, just to double check
> that we do not have any bugs in confusing the two during the import.

I don't know, but these tests would not check for any of those issues.
When such tests are added I would prefer the author to use to be
explicitly defined, but lets see.

-- 
Felipe Contreras
