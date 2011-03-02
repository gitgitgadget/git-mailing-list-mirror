From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2011, #07; Mon, 28)
Date: Wed, 2 Mar 2011 19:22:02 +0100
Message-ID: <AANLkTim7Jo5KLwf760dQN5PucrsD1wvuksds-4Qi0csd@mail.gmail.com>
References: <7vbp1vfy5f.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 19:28:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Puqmk-0006v5-Pv
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 19:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756087Ab1CBS2Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2011 13:28:25 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49343 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633Ab1CBS2Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Mar 2011 13:28:25 -0500
Received: by bwz15 with SMTP id 15so423351bwz.19
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 10:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=voK+lowJ9JKuFgnjS4PhPMWaM99ZgoXJqU+juE1Cxf0=;
        b=O73viBhb8ObcZ2wCQM43T3mqGERZ28PVwlmDnBqnOswBkIPSo12HEGyjR9H51Ifsa2
         wSixz+TU+oTuh9GwRsEgTpdBKhPnRa2BcwHxJNwV5mQ1f6FnD5HsscfXA/cy/3ati+iT
         B4vPmLjBHXNKnbteHJDcQBoyWJkHrvfppfH9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=QSM4c6rTEjMB5v//CeLN1EPbJc0cIcIOipNGnVxPJ9ED5Ce4OZ20RKjzqGLLgzddet
         nb1gDdPCF3jbp+jxNfdodPh9q5a5RrpXDLE64ZVC6y9863Eacuu0HOfFgr3KbghsQ3ZQ
         cdWX8kMISX/N7m0TkwVz/mn92sqOm/g+5j+zs=
Received: by 10.204.46.134 with SMTP id j6mr359617bkf.112.1299090503791; Wed,
 02 Mar 2011 10:28:23 -0800 (PST)
Received: by 10.223.95.206 with HTTP; Wed, 2 Mar 2011 10:22:02 -0800 (PST)
In-Reply-To: <7vbp1vfy5f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168331>

On Tue, Mar 1, 2011 at 2:05 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> * sp/maint-fd-limit (2011-02-28) 2 commits
> =A0- mingw: add minimum getrlimit() compatibility stub
> =A0- Limit file descriptors used by packs
>
> Erik, please check the made-up commit log message and sign it off.
> Will merge to 'next' after that.

Seems to work:

$ ls .git/objects/pack/*.pack | wc -l
   2049
$ git gc --auto
Auto packing the repository for optimum performance. You may also run
"git gc" manually. See "git help gc" for more information.
Counting objects: 2056, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (2049/2049), done.
Writing objects: 100% (2056/2056), done.
Total 2056 (delta 2048), reused 13 (delta 5)
Removing duplicate objects: 100% (256/256), done.

So feel free to add:
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
