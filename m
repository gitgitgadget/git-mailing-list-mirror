From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Ensimag students projects, version 2013
Date: Mon, 15 Apr 2013 21:36:12 +1000
Message-ID: <CACsJy8COdjm2WvY_QB=QSJqGk9PvrDpExN4Xs3UgoKoB7QVtJg@mail.gmail.com>
References: <vpqobdg515m.fsf@grenoble-inp.fr> <87r4iccgdw.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 15 13:36:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URhiN-0006Bd-MU
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 13:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628Ab3DOLgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 07:36:47 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:38259 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab3DOLgp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 07:36:45 -0400
Received: by mail-ob0-f175.google.com with SMTP id va7so3972652obc.20
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 04:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=5CuCmAnHwTmQWx+PcQjf6CbNiOR/DlvTiDCQxPrFOek=;
        b=w04ZW2DK74fJ1w1foBibY2liBqJaZu/9K40V4GoQMYrBf4cex5NWg8gOKEvnyE57tk
         zHyFyv386b7aoqWgm6voQMt6cxeTZb8EFBdV3j6tByriUUBBLREdxSuLvX5Cohx2tNVg
         TU2e7K4Z07tQNf9wKERH+iwfIV11aPBT7pRg6+JZnWSveIHPiT9hWZXI3X8Oa8oNc/k+
         T+w07DkR5/IZNfnWMxRHUsyNksHPUsq4qJB1GqDVnjvyCECdkhgV2saLMD9rQNdS8mjr
         iAOaeSmLCC5TEWZj+EJJtLf7TBfYc1RsJL3DBoZ9JFKxcrTZ/lpmFM7lxMqAtd7CUaFr
         9GTA==
X-Received: by 10.60.103.165 with SMTP id fx5mr7662513oeb.4.1366025803053;
 Mon, 15 Apr 2013 04:36:43 -0700 (PDT)
Received: by 10.76.122.163 with HTTP; Mon, 15 Apr 2013 04:36:12 -0700 (PDT)
In-Reply-To: <87r4iccgdw.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221223>

On Mon, Apr 15, 2013 at 7:06 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>>   https://git.wiki.kernel.org/index.php/SmallProjectsIdeas
>
> My $0.02:
>
> * Allow "git add -p" to use "git diff --color-words" to show hunks
>
>   Check if you can use the existing --word-diff=porcelain output somehow
>   to get it done in pure perl.  Alternatively, try to hack a word-diff
>   mode where it spews out both the line-diff (for later application) and
>   the word-diff (for display) in some clever format, so that the perl
>   code can easily match them up.  If neither one is possible my feeling
>   is that it's one of the hardest tasks on the list.  (Not to
>   discourcage anyone from trying, but still.)

Yes, please.. Also in some case, I'd like to pass the pattern to
--color-words (usually just --color-words=.). Something for the
student to think about when designing the interface.

> * Allow git send-email --cc 'foo@example.com, bar@example.com' instead
>   of git send-email --cc foo@example.com --cc bar@example.com
>
>   That would be really nice.  Bonus points if it handles continuation
>   lines etc. correctly, so that it's even easier to paste.

* Color the header lines in git send-email. Bonus point if it could
highlight possible typos like foo@example.co.
--
Duy
