From: eschvoca <eschvoca@gmail.com>
Subject: Re: git rebase -i <first_commit_in_repository>
Date: Mon, 26 Oct 2009 14:08:01 -0400
Message-ID: <2b05065b0910261108g4a8448c8x295606a8d33612f5@mail.gmail.com>
References: <2b05065b0910261014t4eb93952oc804bcd01b339a84@mail.gmail.com>
	 <40aa078e0910261025l1ad7bf8ex27fd62072a317f9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Oct 26 19:08:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2TzG-0000VA-Hs
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 19:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbZJZSH7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Oct 2009 14:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbZJZSH7
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 14:07:59 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:45044 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794AbZJZSH6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Oct 2009 14:07:58 -0400
X-Greylist: delayed 3194 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Oct 2009 14:07:58 EDT
Received: by bwz19 with SMTP id 19so2366359bwz.28
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 11:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RBE+BKvMHOwyFllEHoUToZpNVN/4See6g74zWyLSkOU=;
        b=aOltXMKlxq1Hu3Iq3FIZKk9jzHJ9OUBLTJoF/QshN7PojzwdZx81MkZhGrPzanBwca
         IOAzaFIlR1KTDoa8PDDxDLVuiAI7VeN53Lf6WrLPf6I0F2DXsdyJQFgifRxBy8Mhr+BI
         gNlCezkuTWbfkrdloh9ePCfG8DUzOiRMAdpqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kob2WJ2zgqkTME42AhB0MS/ZEx/fOZyFib/EcTqO9MwURWhXGvdaHHPl0CxgNEljjc
         HtzosLuP3fWt0WNTmwhPq35DZyF8sFntM2h9LEKCX0A0xHiB4XG2eRsK554uzgW+pLzl
         bE59lYpXUbNporUW3snJw3silMLqngRQPhSqA=
Received: by 10.103.48.28 with SMTP id a28mr6060138muk.128.1256580482233; Mon, 
	26 Oct 2009 11:08:02 -0700 (PDT)
In-Reply-To: <40aa078e0910261025l1ad7bf8ex27fd62072a317f9d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131258>

On Mon, Oct 26, 2009 at 1:25 PM, Erik Faye-Lund
<kusmabite@googlemail.com> wrote:
> On Mon, Oct 26, 2009 at 6:14 PM, eschvoca <eschvoca@gmail.com> wrote:
>> Hi,
>>
>> Is there a way to rewrite history, including the first commit. =A0It
>> seems that the first commit can not be modified with a rebase.
>
> This question is answered in the FAQ:
> http://git.or.cz/gitwiki/GitFaq#HowdoIedittherootcommit.3F
>

Thanks Eric.  Hopefully someone will enhance rebase to handle the root =
commit.
