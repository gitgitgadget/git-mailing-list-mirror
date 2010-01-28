From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2010, #05; Sat, 16)
Date: Thu, 28 Jan 2010 16:16:33 -0500
Message-ID: <32541b131001281316m59128e7ds45353a30ac602b6f@mail.gmail.com>
References: <7vljfxa1o6.fsf@alter.siamese.dyndns.org> <7vd417udpi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 22:17:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NabjY-0004Xe-A5
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 22:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365Ab0A1VQy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2010 16:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754332Ab0A1VQy
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 16:16:54 -0500
Received: from mail-yx0-f193.google.com ([209.85.210.193]:63058 "EHLO
	mail-yx0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013Ab0A1VQx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2010 16:16:53 -0500
Received: by yxe31 with SMTP id 31so1111930yxe.21
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 13:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=G787S1XpvIRh7Zy51+eXpqstUdd8YD9zq6Xr/WyEruQ=;
        b=jR73DCPq1TUXgZorXZi1cACdJjuqUCS4TZqpv7jZiouqUwFLsuKzqP5SaVgSoG1KKy
         5HIV8+0G/FgLv1ywtzXo2FxHSnnn9BkVKYc3JbHN/FvmDOEU3Z7a/9la9PSZ/bZZhDQ0
         p7wTChEQUOTBfQAaXWPr5fidWH7U9OkmMJtIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Z6zgD9/Is3LyM0GD2QUdBAvlpqdzuMTrprJR6UUvwLJUDwgkLzjzCkD+eQbJfg2PDR
         IiCuericMurLn9M8Ho8nqBTuC+QR5WdbcN8PEFjBEIs6mcNKyAVidodKVmVBI0FeQrcK
         ogZSufmgKWPKNsZrWYJFAPR9InL/emMLf5tHE=
Received: by 10.150.235.7 with SMTP id i7mr466552ybh.107.1264713413201; Thu, 
	28 Jan 2010 13:16:53 -0800 (PST)
In-Reply-To: <7vd417udpi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138270>

On Mon, Jan 18, 2010 at 1:30 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> [Stalled]
>>
>> * ap/merge-backend-opts (2008-07-18) 6 commits
>> =A0- Document that merge strategies can now take their own options
>> =A0- Extend merge-subtree tests to test -Xsubtree=3Ddir.
>> =A0- Make "subtree" part more orthogonal to the rest of merge-recurs=
ive.
>> =A0- Teach git-pull to pass -X<option> to git-merge
>> =A0- git merge -X<option>
>> =A0- git-merge-file --ours, --theirs
>>
>> "git pull" patch needs sq-then-eval fix to protect it from $IFS
>> but otherwise seemed good.
>
> Generally I hate to step in to fix up other's series, especially when=
 I
> know that the party responsible for issues is capable enough. =A0As t=
he
> pre-release feature freeze gets closer, however, I sometimes find mys=
elf
> doing so, and (I repeat) I hate it.

Sorry about that.  I asked at the time whether you thought I should
submit a patch or whether you were planning to do it, and didn't get
an answer.  And then when you wrote the above, I was away on vacation.
 I see it's now been merged into master, but in case you care... it
looks ok to me :)

Have fun,

Avery
