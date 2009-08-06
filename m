From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Breaking "git status" (was Re: [PATCH 5/5] shortstatus: a new 
	command)
Date: Thu, 6 Aug 2009 12:57:05 -0700
Message-ID: <fabb9a1e0908061257j55bbc53bu14fdb19a41149fe7@mail.gmail.com>
References: <1249463746-21538-1-git-send-email-gitster@pobox.com> 
	<1249463746-21538-2-git-send-email-gitster@pobox.com> <1249463746-21538-3-git-send-email-gitster@pobox.com> 
	<1249463746-21538-4-git-send-email-gitster@pobox.com> <1249463746-21538-5-git-send-email-gitster@pobox.com> 
	<1249463746-21538-6-git-send-email-gitster@pobox.com> <20090806153339.GC1970@coredump.intra.peff.net> 
	<7vljlwnc6j.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 21:57:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ95l-00045E-KQ
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 21:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756629AbZHFT51 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Aug 2009 15:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756630AbZHFT51
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 15:57:27 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:40475 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756627AbZHFT5Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 15:57:25 -0400
Received: by ewy10 with SMTP id 10so1060956ewy.37
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 12:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=QxWowduA0MzzHIG6kIp6FNyL6V9HuUAs1ACJneoeVWY=;
        b=NTXgndQ8Iq1UhvOmvxT4VBIJHBYirTaiY1apB7yBC64jYUVtQO7GnUgJVFtPBz+UZU
         Wj/yNqOQ38b8sp5/PjmfUmR/clZ/wf8eE2LFLrpGmvYx17hH9D9nPllZarj6C1MQun1b
         5GG8qH3416oj3xoFe1MQTXGVdGsu2L9RHCan8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=esg+RbWIib96mq76NPtXVbXeODyebAwuFlo8GrsGnAu5DZ4JN2xtj3jtxriPWM6eWT
         5kVFHA06cRmPKyhGHXZ779rwH/rKjUFQI3pz+yRXcmW2pzuePi4GzIspvvA/VOmVF0A+
         Pj9cBzZCyH98BZpgV1kIPwjlLyUou+8dj6JXo=
Received: by 10.216.28.193 with SMTP id g43mr48052wea.192.1249588645116; Thu, 
	06 Aug 2009 12:57:25 -0700 (PDT)
In-Reply-To: <7vljlwnc6j.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125117>

Heya,

On Thu, Aug 6, 2009 at 09:23, Junio C Hamano<gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
> =A0* Implement "git status" that is not a preview of "git commit". =A0=
Its new
> =A0 semantics would include:

=46WIW, I think this is a a great idea, 'git status' being a preview of
'git commit' has never made sense to me from a UI perspective, and I
never actually use 'git status' for that purpose. While I do use it to
look at what I'm going to commit, I never use any 'git commit'
modifiers in combination with git status.

On that note, I agree with Jeff that a config option does not make a
lot of sense, especially if we introduce 'git commit -d|--dry-run'.

--=20
Cheers,

Sverre Rabbelier
