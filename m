From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Wed, 17 Feb 2016 17:45:40 +0700
Message-ID: <CACsJy8BGTQOGfOMcx6pnf6hfry4LojxXsWp-TaNyem-6j4USLw@mail.gmail.com>
References: <vpqoabox66p.fsf@anie.imag.fr> <CAP8UFD0UxB6Z1UU=4Bkz0Yt2KE+AkrttQeTx2oY9v9O78f9qow@mail.gmail.com>
 <vpqd1s2e74l.fsf@anie.imag.fr> <20160212130446.GB10858@sigill.intra.peff.net>
 <vpqd1s04zzs.fsf@anie.imag.fr> <CAGZ79kbUG73eo5YvedbVB0bmZduMeCWNpbCRK4Adr9XDebsbQQ@mail.gmail.com>
 <vpqio1nsk0q.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 17 11:46:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVzci-0002iF-Ln
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 11:46:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933935AbcBQKqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 05:46:12 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:33966 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933441AbcBQKqL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 05:46:11 -0500
Received: by mail-lb0-f178.google.com with SMTP id of3so7014218lbc.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 02:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=U9cecTFKR+BDLn+5Hng9gjKV45pz/yxrwZuin2c7OOk=;
        b=XMBnrTo5zk4+RBhjMrFJgg0SmYVxtMJk9gzasiDzsRdRmtmmhouXdFALRXDvRT9XhO
         Ij9+pO9QbIDbWCW5LY1YKQNbZkgAMdDXBFhEXImkn88g/BeSX+rh7DFCwcSa+kuxgVGt
         EAzxtDX2bbmkGeiUr77JPxXCRfsotd3c9OjTJFJS2Nl/BjdNZjIr6GuoDoCYbxAjsZ1z
         WOiuzPa4hnZnbTAI6RLb+YgbDWy+ZDltmE1BQmTFEeCHugCLL4YNx8uklUBgi5nFyo5b
         oD40cs30gagm3Hp/IP8Yp4vYL6L0Bsifc28RK/MWe7qDhkjYQUExhpBxTiXZ9FHs2FoM
         FyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=U9cecTFKR+BDLn+5Hng9gjKV45pz/yxrwZuin2c7OOk=;
        b=ZBBIBmxACYd77GcN+CBYxyxUosTLW6QVDUY09KBxjbCxkVc8IJJMmrYss5jrCVGFUP
         abxPksEbP5gDVUBh4VuZughdkqtRah+VfAhJTMeWoxMxSsN1s7T7egQ1hKqfp8V4H2ci
         OeSD3GSArlhYEqX00x0gxSIIEcghU9eJbynjZS1s8qg1+FpN1IVfmLfO+WxHmWGViVDA
         e55snlXgAtkEIlg4860vMEVbKdPPMQWHqfn0CAuCimrb/2LhLZBRdY6nsbSJ+8t9oKNq
         Hxr+zgALV6IeS1a9LJtH5pPgctlhnAaHVi8S6YVPmczcN489MlxAMq1q5bIor38CGibH
         37BQ==
X-Gm-Message-State: AG10YOR7eNYGbV8lYN6HYELuPcCF3hjBjKgUaDSowKmVc3eY+WgjS9uTEEUNWr1ZRYVw9i621c5qmI+PwNUpWw==
X-Received: by 10.112.141.97 with SMTP id rn1mr433167lbb.80.1455705969867;
 Wed, 17 Feb 2016 02:46:09 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Wed, 17 Feb 2016 02:45:40 -0800 (PST)
In-Reply-To: <vpqio1nsk0q.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286495>

On Wed, Feb 17, 2016 at 5:34 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> I'd be interested to co-mentor a sh->C conversion.
>>
>> I think the git-rebase*.sh is a good start.
>>
>> $ wc -l git-rebase*.sh
>>   101 git-rebase--am.sh
>>  1296 git-rebase--interactive.sh
>>   167 git-rebase--merge.sh
>>   636 git-rebase.sh
>>  2200 total
>>
>> So start with rebase--am and rebase--merge to have the same amount
>> of lines as git-pull.sh. I did not look at the code, just judging by
>> the lines of
>> code.
>
> There's a funny exercice there: the git-rebase--$type.sh scripts are not
> called as external helpers, but like this:
>
> run_specific_rebase () {
>         if [ "$interactive_rebase" = implied ]; then
>                 GIT_EDITOR=:
>                 export GIT_EDITOR
>                 autosquash=
>         fi
>         . git-rebase--$type
>         # ...
>
> So, turning these scripts into builtins would first require turning this
> ". git-rebase--$type" into an actual command call. But nothing
> unfeasible.

Yeah we can turn those git-rebase--*.sh into separate actual programs,
then we can convert git-rebase.sh to C and other subprograms at a
later time. I started something back in 2013 [1] but never managed to
finish it. Also see the abandoned rewrite effort [2] from git for
windows

[1] https://github.com/pclouds/git/commits/rebase-rewrite
[2] https://github.com/git-for-windows/git/pull/461
-- 
Duy
