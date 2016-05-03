From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/3] preparatory patches for the submodule groups
Date: Tue, 3 May 2016 14:12:47 -0700
Message-ID: <CAGZ79kbm5y+LeyA_dwQWKFNaa42280cOvwQYZTP=-aRnySsB1A@mail.gmail.com>
References: <1462227844-10624-1-git-send-email-sbeller@google.com>
	<xmqqwpnalwf8.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kakayOhPkCK4hbRkj-h2Bt+PqD69EgHk-chbu4xCA8_pA@mail.gmail.com>
	<xmqqoa8mlutg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 23:12:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axhcj-0005Mj-5k
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 23:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756561AbcECVMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 17:12:49 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:34599 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756536AbcECVMs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 17:12:48 -0400
Received: by mail-io0-f178.google.com with SMTP id 190so35820210iow.1
        for <git@vger.kernel.org>; Tue, 03 May 2016 14:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=1y3YW+5n7Aem43UKxmYb3yEF0QANPDT2Na6zTA1+MGc=;
        b=HLmegpOq48dNCH7dXKEkGCKvz0Sf6oKBQqtVcDk6FuJdBLPSc38nT0iBdqYwNsxkB7
         03THm9Lrm625wW0YI/gcPhhRnXNhVT7bFTHjgPTAGYclcPEp+QS52JE85n1lnldVZYrl
         vAEmxOT9TzgKJNfKrsbgvSV0EFx7E3FKRY8PEmlhc6k4My+gWSS81AurBo4SGQ6KoOux
         ZIlyio41rWZlYawtOr5BNZ+C9CZP15I1OdtdoAxNh2Nbt80KGZakw1WDV9aFG2zSkHNN
         mEzZO4uGnErelPBTAgLDVzKDlDjTr58Pd6Q2fLlzjEZsaaH9iAXKGB513Q2bLrhvKFCg
         cGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=1y3YW+5n7Aem43UKxmYb3yEF0QANPDT2Na6zTA1+MGc=;
        b=mL4g2696se0K/Z503ck1GGyBQ5J50as+KikOy7qWE70hx94OksEiODpEcwAwPoPAvz
         qA5nxIH/OMsaGph830EMd11XsYZmGDndK99J9hGcTXVX4vWaaIL2kxKnRXC71rVW/dd6
         Mtc5Q14sUdyDx8c71fcLU5PSRQIz4geNKFnGE4JLktwmJKeMD7eTcT6xt/yOvzf5Io2O
         aDXzZnWW+AhNgiBt2dbkObnMcUGnL8z/n9P/nm0KpObih3qs6D6x8GtdXC4wX6KYUGVb
         uMfR9+0eTf3uabmbn7cLwEZUAC1cbdgjfDBPKbl47xdu7gove7ZedQUnNy56/U8IXPfs
         V3WQ==
X-Gm-Message-State: AOPr4FX0yYJxIji2YrFmBue6rJFgjR392lLxHOMNu891Eyk0qHkzCO+M0YjpBZn5ISkSD+btWsjKeGo4+qQNTIno
X-Received: by 10.107.53.204 with SMTP id k73mr5907972ioo.174.1462309967407;
 Tue, 03 May 2016 14:12:47 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 3 May 2016 14:12:47 -0700 (PDT)
In-Reply-To: <xmqqoa8mlutg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293455>

On Tue, May 3, 2016 at 2:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> I have your patch here and have a "-a and pathspec are incompatible" fix
>> build on top.
>> * I do wonder if we want to have the shortform '-a' though.
>
> I do not particularly care.  I was merely matching the other two
> options there.
>
>> * I think we want to head for consistency, eventually.
>>    e.g. commands with no arguments such as tag, branch
>>    give a list of their respective domain.
>
> Isn't that a historical mistake we are regretting, though?  Only
> after many other operation modes were invented and "create X" proves
> not to be the only primary modes we had to invent "tag -l" and
> "branch -l".  Aren't we better off not having "no option means list"
> kind of default?

listing is not destructive, and I really like to not type a single dash
for some commands.

>
>>    Subcommands do not give lists by default, e.g.
>>    `git stash clear`, `git remote prune`
>>    which are the moral equivalent to
>>    `git submodule deinit` just work as they were told, no --switch needed.
>
> I wouldn't say "git rm" should remove everything by extending that
> logic, but I can certainly buy if somebody argues "git submodule
> deinit" is not destructive enough to warrant extra safety.

`git rm` is a command, not a subcommand though.
