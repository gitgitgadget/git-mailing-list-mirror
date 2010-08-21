From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [feature request] gitweb: tags in history
Date: Sat, 21 Aug 2010 18:31:54 +0200
Message-ID: <AANLkTi=JHzQm4hm-nuTyZq2CL_2z785KtMvVcmaqtgyF@mail.gmail.com>
References: <20100821092616.5e57135b@hyperion.delvare>
	<m3wrrknzph.fsf@localhost.localdomain>
	<20100821111555.11879d02@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Jean Delvare <khali@linux-fr.org>
X-From: git-owner@vger.kernel.org Sat Aug 21 18:32:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmqzB-0000lt-Cv
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 18:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451Ab0HUQb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 12:31:57 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41238 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173Ab0HUQbz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 12:31:55 -0400
Received: by fxm13 with SMTP id 13so2311659fxm.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 09:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=PsaDw4K960bUXZZWFyi0fSAG4C5Z9L42vC/xZaTepJ8=;
        b=b009DBSTutxGdZuz8p1QBAyZ3+2T8PP2BvH/15QGSZSq3MUs5SA8+iD8HvXZzwahgr
         xbpbDthqP9+mnZJkjb66qe1vlpjByj2LmMIangMbUoMJ3H5jRXNsZutiTAe2MormoAJk
         RF/RV3kW9tsj/LINOsHOAaSQdEcKp+4KJb0+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=fYLhUDUeUDUszC6lg80Yk7btOmWvbqjrcWUjv8Fe3eczKdp5oB4obVyk802KLVXhBV
         +Z17g412QB58DlpGzK/+iSlUxwUa1AwH4RFrLWhlQy2/qZFVtPQW3Gy5dNEoBzPQiFpY
         UmqsM3xR+1VFxFoyZaD3YQNkhkZ8Q6cWb7LLU=
Received: by 10.239.161.203 with SMTP id i11mr115593hbd.116.1282408314422;
 Sat, 21 Aug 2010 09:31:54 -0700 (PDT)
Received: by 10.239.180.20 with HTTP; Sat, 21 Aug 2010 09:31:54 -0700 (PDT)
In-Reply-To: <20100821111555.11879d02@hyperion.delvare>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154144>

On Sat, Aug 21, 2010 at 11:15, Jean Delvare <khali@linux-fr.org> wrote:
> On Sat, 21 Aug 2010 01:22:05 -0700 (PDT), Jakub Narebski wrote:
>> Jean Delvare <khali@linux-fr.org> writes:
>>
>> > I have a feature request for gitweb. In the history view, I would like
>> > to be (optionally) able to see the tags, interlaced with the actual
>> > commits. The idea is to get an immediate view of all commits that
>> > happened between specific tags.
>> >
....
>
> But shortlog is a repository-wide view, while I need the same for
> history which is a file-specific view.

<shameless plug>
With cgit, you can answer such questions by combining path limiting
and range queries, e.g.
http://hjemli.net/git/cgit/log/scan-tree.c?qt=range&q=v0.8.2..v0.8.3
shows all commits affecting scan-tree.c between v0.8.2 and v0.8.3.
Maybe gitweb could implement something similar?
</shameless plug>

-- 
larsh
