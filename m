From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: How do I delete a remote branch with a period in the name?
Date: Tue, 3 Jul 2012 07:42:07 -0400
Message-ID: <CAKON4OxBo7XiF5c60oyEUMR1xCh16n5BZCz-mmcUc0V9X7D32A@mail.gmail.com>
References: <CAKON4OwnUKQ6MT8HBNDyfhZLZS5xGKA2Ss1krY9OQGG1gaFhDw@mail.gmail.com>
	<7vsjd9wkek.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 13:42:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm1Ul-0006eZ-Qj
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 13:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547Ab2GCLmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 07:42:10 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:34514 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444Ab2GCLmI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 07:42:08 -0400
Received: by vcbf11 with SMTP id f11so4108838vcb.19
        for <git@vger.kernel.org>; Tue, 03 Jul 2012 04:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VO56qlqWSdoGPC1FW28gk4+QmzogKV6HOyN8QPm5X8s=;
        b=curL/oOEb7tuabcQcjPLV7YK+9tFeR0JvndsNmQJQs7Q8fRRj2WTdh0ZsJ3zLWJ00v
         Tng6ttTYu7tIvsgFBxx5G3GsF2n/tdf0Uv/Z2X7W/EUM4S7C06t9jpVgn0FFBVnhuIgg
         kH7i7f4TyeScZZYbBJRNP5MhiHwJXO6i7CNW0f+B/jxbHIbT3TuXGN0gXpg5Fe8m1/aD
         u1wOF44gthy48e+q2KMLG2RdIlukmtB20eNp1lH0cA9XF4EAbvLc52BgWisAQtDvT8ZB
         UD81tD3YipHtVvbRDKw67gMDJPFKhPYgrHD4NJehqeQGkY6IzAf9CcvZ0JRf9gArD7ZP
         hKcg==
Received: by 10.52.176.66 with SMTP id cg2mr6642688vdc.121.1341315727663; Tue,
 03 Jul 2012 04:42:07 -0700 (PDT)
Received: by 10.52.65.143 with HTTP; Tue, 3 Jul 2012 04:42:07 -0700 (PDT)
In-Reply-To: <7vsjd9wkek.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200910>

On Tue, Jul 3, 2012 at 12:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "jonsmirl@gmail.com" <jonsmirl@gmail.com> writes:
>
>> jonsmirl@smirl2:/home/apps/florida/lpc31xx$ git push origin :fl.stg
>> error: unable to push to unqualified destination: fl.stg
>> The destination refspec neither matches an existing ref on the remote nor
>> begins with refs/, and we are unable to guess a prefix based on the source ref.
>
> The message seems to be saying that fl.stg is not specific enough
> perhaps?  What does "git ls-remote origin | grep fl.stg" say?  If it
> says refs/smirl/fl.stg, for example, you can be specific as the
> message suggests, e.g. "git push origin :refs/smirl/fl.stg" or
> something like that?

I have the branch name wrong. It is fl.stgit not fl.stg.
But the error message sent me off in the wrong direction looking for an answer.

-- 
Jon Smirl
jonsmirl@gmail.com
