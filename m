From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [RFC] format-patch: Ensure that author and commit time are not 
	lost
Date: Sun, 15 Nov 2009 23:16:09 +0100
Message-ID: <6672d0160911151416u7e8858f4k1591f1c1482cabb8@mail.gmail.com>
References: <4B000141.5070503@gmail.com>
	 <7vzl6nfqkx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 23:16:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9nON-00060F-O2
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 23:16:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019AbZKOWQH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Nov 2009 17:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbZKOWQG
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 17:16:06 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:36099 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775AbZKOWQF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Nov 2009 17:16:05 -0500
Received: by bwz27 with SMTP id 27so5107766bwz.21
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 14:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=htB0X2LqZiGlc4oSIP5A7/FeamSJt4rIpbjQ33pEnQM=;
        b=P9jU3M6hYcYAQru7nhy3keEpv7JRkgz7vkfg88XYsnR91h5lXrO+ZNadjmptN8676/
         fikrenjC/ihB/0wHmzQn1qqfvd34jEHlh5SowCW0iLKzBt8qY3tQ6UkJlbazCUnPEvJK
         BdQozpCWbZzc1FMlhmTB99V8aZGKex3vNSh9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uZ0xMziHnMp8Zt35m4EXGzsuXJwDjt6yTKo6gjesTKeFSliTE8znwoyZv+7z3Nzjb8
         r2vylTRU5o0qb8BuOVoyXE+wGXEUcswAcCQAufGiuTKvYhM8Sa29KNJtIS+tG+J8Cboy
         7AyMycJYQLi5MYEat8c2jQGRmc8sOEtVSEhqc=
Received: by 10.204.8.155 with SMTP id h27mr3269613bkh.55.1258323369818; Sun, 
	15 Nov 2009 14:16:09 -0800 (PST)
In-Reply-To: <7vzl6nfqkx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132969>

2009/11/15 Junio C Hamano <gitster@pobox.com>:

> I think you are addressing a very valid issue, but I suspect that you=
 are
> doing so at a wrong place in the "patch mail-out" workflow.
[...]
> This new function is not about "Is the _sender_ the same as the autho=
r?",
> but is about "Is the person who is running format-patch the same as t=
he
> author?".  There is a big difference.

Yes, I kind of suspected that my solution would not
be general enough to suit all users and workflows.

Thanks for the feedback.

/Bj=C3=B6rn

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
