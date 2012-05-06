From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Sun, 6 May 2012 22:15:34 +0200
Message-ID: <CAMP44s3kkEn+_fhdrXyT9znNDE_u39pv1cFvZ+kLFyzOVpsjHg@mail.gmail.com>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
	<201205061221.29592.jnareb@gmail.com>
	<vpqtxztlhjd.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun May 06 22:16:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR7sN-0005q7-4J
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 22:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754274Ab2EFUPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 16:15:36 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:48570 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754221Ab2EFUPf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 16:15:35 -0400
Received: by eekc41 with SMTP id c41so1241850eek.19
        for <git@vger.kernel.org>; Sun, 06 May 2012 13:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LgwLiKl8MPPk8oL+SyHIXp+UFU+683mZjaQ5JPRDA2k=;
        b=zId3Drw0owuFpwQsSiNlaoAel+aqpqDOT8yJRl0pcvn9ORmwuvpjLN0eW6aMNNKXwZ
         DYtkVTothHK3MZUIa/0Ttko21K0mPRpT5tzm88K1ewyu27NRciXLu4KRl5uwS0yj1Pli
         en5HIE0M9lRxFnIBdrkXxlGc+ssRujvvurjBRtqhx3AR2KrvH46CY6qedkJiFRmxwo82
         rLizZohpokAaJfb4DzQOtVAmdi0I7Jkoyrude80t7cb1tbt9kqEhQF+7jVJcZSi9q5ik
         MfV3p+xnEGYm6AqoFV18HEVSliwkoEXN5o9UG1nl3p4bfejHfnQdjN1s0ynkGxklF+/2
         Pn2Q==
Received: by 10.14.47.9 with SMTP id s9mr2268077eeb.50.1336335334283; Sun, 06
 May 2012 13:15:34 -0700 (PDT)
Received: by 10.213.103.18 with HTTP; Sun, 6 May 2012 13:15:34 -0700 (PDT)
In-Reply-To: <vpqtxztlhjd.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197208>

On Sun, May 6, 2012 at 12:39 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>
>> Actually Git porcelain does use 'the index' as a cache (computing),
>> i.e. as a place to store redundant information (stat data, sha-1
>> for trees with DIRC dircache extension) for faster access.
>
> This is an implementation optimization, that is not supposed to be
> visible for the user. Commands refering to the "cache" are not about
> stat data cache (e.g. "git diff --cached" is really about the content,
> not the stat cache).

Exactly; that's an implementation detail that doesn't affect how the
user actually interacts with the staging area.

-- 
Felipe Contreras
