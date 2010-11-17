From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Difference between 'git rebase' and 'git rebase -m'
Date: Wed, 17 Nov 2010 21:38:38 +0700
Message-ID: <AANLkTikY0BE-PMP5TpAjL2TOYBQ-sTAAka2Gt6f8qd3P@mail.gmail.com>
References: <4CE2C0ED.1030309@workspacewhiz.com> <20101116182749.GC14552@burratino>
 <AANLkTik7RML10gyQ19OV0KAH8Mn3=VZe92kU1qxER7wO@mail.gmail.com> <4CE3DA66.80808@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Stephen Bash <bash@genarts.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Nov 17 15:39:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIjAC-0004wJ-68
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 15:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934495Ab0KQOjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 09:39:04 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61441 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933812Ab0KQOjB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 09:39:01 -0500
Received: by ewy8 with SMTP id 8so1197426ewy.19
        for <git@vger.kernel.org>; Wed, 17 Nov 2010 06:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=TyjUiNDsSzBlSuzpqOkAsKpWmazFBUWNbUfYpG2nFYE=;
        b=IEqZVy/NV+rB0aY51gLyCSekBpVIlHr0DYY7bXtIjfzYTxPuyZFT921RHxL/J+mhb/
         nGD4rpXt6zMhLUPvxTRMk07FDed56jTIewnnvxMBsLBKVeik4ok9m7lZZbRnis8jY8OP
         PZsWxekgM1ioV6AXkv5/CLmqHN6OrFbNkZwlM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=SSan91caZ7Z48OWenxeRERqXLvZJj3DZ8SP14J6IU8sGwqruF+pyKrGHdbrNlf/k2+
         cOmyfFRDeKWLM6SfqevwjDCMQ6gde+KbX+xFq/62totD4cL5HoMkMp24bV3/9/NCrVzo
         Ke74QwHLgNs/S0K0tSXompgMKf1cIA8Vb5Otc=
Received: by 10.216.163.148 with SMTP id a20mr1690767wel.41.1290004738647;
 Wed, 17 Nov 2010 06:38:58 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Wed, 17 Nov 2010 06:38:38 -0800 (PST)
In-Reply-To: <4CE3DA66.80808@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161615>

On Wed, Nov 17, 2010 at 8:36 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Nguyen Thai Ngoc Duy venit, vidit, dixit 17.11.2010 12:43:
>> On Wed, Nov 17, 2010 at 1:27 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>> Joshua Jensen wrote:
>>>
>>>> I'm curious as to why 'git rebase -m' isn't the default and what the
>>>> real difference is between 'git rebase' and 'git rebase -m'.
>>>
>>> git rebase is faster. :)
>>
>> Perhaps a config option to let people to default to -m. Or perhaps
>> they can just make an alias.
>>
>> By the way, can we make rebase even faster? Rebasing ~20 patches or
>> more seems slow to me. I don't know much how patching works though.
>
> git sequencer...

Sequencer is definitely an improvement. But does it improve
performance? I don't know rebase internals but I think that it needs
to update worktree/index for every commit, which might slow things
down a bit.
-- 
Duy
