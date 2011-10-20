From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Tracking cherry picks
Date: Thu, 20 Oct 2011 21:04:04 +0530
Message-ID: <CALkWK0k-0vtD6OUtqKzzG9_aqGm2jsDY1k=xCR43TssvnHyLPg@mail.gmail.com>
References: <4EA02E6C.2040608@cfl.rr.com> <37162B20-4758-433E-B11E-CE4B7FF27FBA@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Phillip Susi <psusi@cfl.rr.com>, git@vger.kernel.org
To: Kirill Likhodedov <klikh.list@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 20 17:34:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGuda-0008UC-8Y
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 17:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756183Ab1JTPe0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Oct 2011 11:34:26 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38616 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507Ab1JTPeZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2011 11:34:25 -0400
Received: by wyg36 with SMTP id 36so3006711wyg.19
        for <git@vger.kernel.org>; Thu, 20 Oct 2011 08:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=O62yl0GVoFQ8ZXiTrmISUW3tPPk/kwqahnXHp3t5ucg=;
        b=fKo1OYJJOa3K1KcHQOZD4wV4LDAbDSEUnw4ppgyU8CAAIitqKmyDx3OiOXsHtlM/Id
         WooRo/6rZHhkbGNc8OvRP3GxceONcYxJUPRzUDWDBI7Yq1zAv9wzGOcvr31NefZnzcdO
         KHlKVoHbpiD86p8v4TRr/cOP+MaUfujNJj6vE=
Received: by 10.216.131.36 with SMTP id l36mr8401921wei.105.1319124864154;
 Thu, 20 Oct 2011 08:34:24 -0700 (PDT)
Received: by 10.216.51.75 with HTTP; Thu, 20 Oct 2011 08:34:04 -0700 (PDT)
In-Reply-To: <37162B20-4758-433E-B11E-CE4B7FF27FBA@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184024>

Hi,

Kirill Likhodedov writes:
> 20.10.2011, =D0=B2 18:21, Phillip Susi:
>> =C2=A0Why doesn't git-cherrypick record the original SHA1 it was pic=
ked from in the commit?
>
> It does if you specify "-x" option to cherry-pick
> See the man for git-cherry-pick:
> [...]

Right.  As an interesting historical note, git has been omitting the
original object name by default when cherry-picking/ reverting since
abd6970a (cherry-pick: make -r the default, 2006-10-05).

-- Ram
