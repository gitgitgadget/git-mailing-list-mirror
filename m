From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH v2] Teach rebase to rebase even if upstream is up to 
	date
Date: Sat, 14 Feb 2009 18:57:28 +0100
Message-ID: <bd6139dc0902140957pa5852d6m61211054b3f5e395@mail.gmail.com>
References: <1234565281-20960-1-git-send-email-srabbelier@gmail.com>
	 <alpine.DEB.1.00.0902140703540.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailinglist <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 18:59:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYOnM-0008NO-Op
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 18:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbZBNR5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 12:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbZBNR5b
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 12:57:31 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:33253 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbZBNR5a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 12:57:30 -0500
Received: by fg-out-1718.google.com with SMTP id 16so64962fgg.17
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 09:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=dAoZN/bJomGd+qEuVoki8Ws5WTP4kqRXHiJQzlQIwBs=;
        b=QffGw4gFEJYET0o1kB+h9ysXjmyahFFPSEAa4HigJFr9TE0BZimBnigJDu4QHlLyWk
         q96TAapve8lJeFW4DA+kVgezr0aMc9m0QUWr7yv6lHR4NV5mSBxP/ZVgnAwE7cTvmeVW
         pD7KnLdtprcGJKyXf3p/oeSZc9bmezO//Xd8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=N4CXWFj9GcBF4hiRgrP4HU+5fgj0urtI8nKT4zfBg7FkHEFOc87eijoS4RKlliX9gp
         8Xz1V5+kYY09WjjjAY1iLwsn7gcvDZ4t8nk3VUzNuryGioGHQTMaoQpDmhiIkxccZvZl
         7tbStyydAUzipaByoXwbmFje817AbVZbL7EXc=
Received: by 10.86.100.19 with SMTP id x19mr448798fgb.18.1234634248926; Sat, 
	14 Feb 2009 09:57:28 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902140703540.10279@pacific.mpi-cbg.de>
X-Google-Sender-Auth: 5b1938348ebd8764
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109888>

On Sat, Feb 14, 2009 at 07:07, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> I know that you can turn it off with --whitespace=nowarn, but that's
> such an outlier that we do not have to care about it, right?

Well, actually, in the v1 thread Junio mentioned that it should not
imply -f for --whitespace=nowarn.

> Or if we really want to:
>
>        --whitespace=nowarn) ;;
>        --whitespace=*) force_rebase=t ;;
>
> Hm?

No strong opinion on my side, what does the gitster have to say about it?

-- 
Cheers,

Sverre Rabbelier
