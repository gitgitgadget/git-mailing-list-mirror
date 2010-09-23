From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv3 2/4] t7500: add tests of commit --fixup
Date: Thu, 23 Sep 2010 16:32:40 +0000
Message-ID: <AANLkTikQArcz5ENo6veWEgEhmasCscNJ6J4wiyw+gSTj@mail.gmail.com>
References: <1285258997-12497-1-git-send-email-patnotz@gmail.com>
	<1285258997-12497-3-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pat Notz <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 18:33:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyojF-0007FN-Hz
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 18:33:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755752Ab0IWQcn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Sep 2010 12:32:43 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39678 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494Ab0IWQcl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Sep 2010 12:32:41 -0400
Received: by iwn5 with SMTP id 5so1584772iwn.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 09:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SOhsnyRVNJ+vLcWsDjGDKC8s/QdWcX5gUORGu+Qr+5U=;
        b=TjUAAuEdywTQcZoRIowGIMGT3zYMEnZNxCuTSoJMvhySde2ob3dr5FD0jYC9cj4udS
         b3ZqPAS6H4EHnmp6esiS4yPISSoCKkAcXkl/2uc9hf+HWCgTjQMVhujTVwBSaWDbNZTD
         xgy1tFVwE1VbVla9wvGRENy35ddau347bjIlY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QCV54zBOzs0Joy7TvoJ8NykCYJbxCD++IrWegLKrOZn4kv7jWpeG7dG3y4B7Xp3Dnu
         g2wCoOR9At1WU5mqyxQ7k4Z5uRoUO9aZl2LADWjurTzcvmVXvfQuYMWbsdyxZxsiSizb
         PQkFitmNKgzkq8siIYp4L6ykuFOIXzJgH3Apw=
Received: by 10.231.148.85 with SMTP id o21mr2324943ibv.26.1285259560413; Thu,
 23 Sep 2010 09:32:40 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Thu, 23 Sep 2010 09:32:40 -0700 (PDT)
In-Reply-To: <1285258997-12497-3-git-send-email-patnotz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156877>

On Thu, Sep 23, 2010 at 16:23, Pat Notz <patnotz@gmail.com> wrote:

> +commit_for_rebase_autosquash_setup() {
> + =C2=A0 =C2=A0 =C2=A0 echo "first content for testing commit message=
s for rebase --autosquash" >>foo &&
> + =C2=A0 =C2=A0 =C2=A0 git add foo &&
> + =C2=A0 =C2=A0 =C2=A0 cat >log <<EOF

Missing &&
