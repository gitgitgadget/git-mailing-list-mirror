From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] revert: prettify fatal messages
Date: Wed, 16 Nov 2011 11:53:19 +0530
Message-ID: <CALkWK0m+us0rCx61+SwSsKuO7qK5mbCs0MpoAzB4ja=wBA+Xjw@mail.gmail.com>
References: <1321349492-5653-1-git-send-email-artagnon@gmail.com> <7vvcqkswpu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 07:23:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQYuQ-0002TY-Fy
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 07:23:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783Ab1KPGXm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Nov 2011 01:23:42 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57628 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486Ab1KPGXl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2011 01:23:41 -0500
Received: by wyh11 with SMTP id 11so86241wyh.19
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 22:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=tMjkxeVZcnqDHo9Ui05dixTEEoVDLAyAaAqFdU+XJxI=;
        b=xmQVpIDD3hmGsGPuzzw1UB7GE5t5LFclCd63BbwjOQErvl+at0kC0N333Lk7db0Lnj
         MXs989yj0NnUiV4NW0QAQocMzNX/+LA9wu/SQ32FsjOCcH9WTM/jK8ePSxvVyTU6MfcN
         4qBY4+69M3j4tbxXNXCUKoEU2Y3HmTP3J4EPA=
Received: by 10.216.188.145 with SMTP id a17mr4926783wen.24.1321424620203;
 Tue, 15 Nov 2011 22:23:40 -0800 (PST)
Received: by 10.216.19.209 with HTTP; Tue, 15 Nov 2011 22:23:19 -0800 (PST)
In-Reply-To: <7vvcqkswpu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185510>

Hi,

Matthieu Moy wrote:
> (I just misread the subject line at first, and understood that this w=
as> a revert of an earlier commit, while this is actually a commit touc=
hing> the "revert" part of Git)
Reminds me of an earlier note Jonathan made about the git-revert
commit message format.  To avoid confusion, reverts should always look
like the following:

  Revert [commit message]

  This reverts commit [unabbreviated sha1 hex].

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>> =C2=A0Candidate for 'maint'?
>
> Too minor to matter when 'master' is already at -rc2.

Ah, I haven't been paying much attention to these release cycles.  I
suppose we can put this patch in `master` after the release?  I wince
everytime I see these ugly fatal messages: it happens shockingly often
while testing :)

Thanks.

-- Ram
