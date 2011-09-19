From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: upgrading GIT from version 1.7.0.4 to 1.7.6.1.
Date: Mon, 19 Sep 2011 14:43:24 +0200
Message-ID: <CAGdFq_hqEtnQvRbzr25yGDjwA6UCGhtofj+io7bX+xAkKqYYmQ@mail.gmail.com>
References: <1316435430491-6808156.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Mika=C3=ABl?= <mikael.donini@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 19 14:44:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5dCm-0004O4-4M
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 14:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755829Ab1ISMoG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Sep 2011 08:44:06 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:55116 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755728Ab1ISMoF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2011 08:44:05 -0400
Received: by yie30 with SMTP id 30so4014347yie.19
        for <git@vger.kernel.org>; Mon, 19 Sep 2011 05:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ervGSKD5sBZwp5WNJOmq94sIYUQMz8gggQ01q7Fjzck=;
        b=QSXtsXg+pA3txTNpkdo6XMna7CoRCMBOLDQEX3iGb0y+6Bi+J5zKRvuLpy7yCax/gZ
         uPs6ji72YXKyvmlc79/xSPb56ODWCmascfD34mQaneJiyIBoc8ZSiRyu1EFOXD693+r6
         qrjbzrSmGGKrbbSapd5hnTe8ty18FXKiRXBNE=
Received: by 10.68.14.163 with SMTP id q3mr4092459pbc.98.1316436244099; Mon,
 19 Sep 2011 05:44:04 -0700 (PDT)
Received: by 10.68.59.39 with HTTP; Mon, 19 Sep 2011 05:43:24 -0700 (PDT)
In-Reply-To: <1316435430491-6808156.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181676>

Heya,

On Mon, Sep 19, 2011 at 14:30, Mika=C3=ABl <mikael.donini@gmail.com> wr=
ote:
> 1- Is it possible to have two GIT installations pointing on the same
> repositories?

Yes, knowing how deeply Junio cares about backwards compatability,
there will have been no backwards-incompatible changes to the
repository format (none at all actually, IIRC) since 1.7.0 was
released.

> 2- Do you have any suggestions, trips, hints and best practices in or=
der to
> upgrade GIT in such a context?

You should read the following documents that are in git.git:

Documentation/RelNotes/1.7.1.txt
Documentation/RelNotes/1.7.2.txt
Documentation/RelNotes/1.7.3.txt
Documentation/RelNotes/1.7.4.txt
Documentation/RelNotes/1.7.5.txt
Documentation/RelNotes/1.7.6.txt

And make sure that none of the changes mentioned there will affect you
negatively.

--=20
Cheers,

Sverre Rabbelier
