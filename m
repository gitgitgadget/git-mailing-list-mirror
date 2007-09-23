From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 4/5] git-merge: add support for --commit
Date: Sun, 23 Sep 2007 12:35:54 +0200
Message-ID: <8c5c35580709230335w2b4dcfe8xa05d50312cc2f6c3@mail.gmail.com>
References: <1190421186-21784-1-git-send-email-hjemli@gmail.com>
	 <1190421186-21784-2-git-send-email-hjemli@gmail.com>
	 <1190421186-21784-3-git-send-email-hjemli@gmail.com>
	 <1190421186-21784-4-git-send-email-hjemli@gmail.com>
	 <1190421186-21784-5-git-send-email-hjemli@gmail.com>
	 <7vir62dx0u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 12:36:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZOok-0002YL-TH
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 12:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555AbXIWKf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 06:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754459AbXIWKf5
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 06:35:57 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:5003 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161AbXIWKf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 06:35:56 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1634478wah
        for <git@vger.kernel.org>; Sun, 23 Sep 2007 03:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=cWLCHwk55pvfsfgdV/34cuyTMJUVYWSRWPp4dMQaEfo=;
        b=hTQefwzW55ZFrepTU/oeCZGuuGAafPX4MmzwHFOHHikgWkb0dlSqEL3vWMoie2sCGt2PV3jEuTLDAVvLTjwy04HZul8A6/KTodvq6ptekIWul563pmXLwm8el7sVMW0ag+w/+QshjlydrHor0zXwD1DBqsyoF6YItW4iX/k5oeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IxBSnQOnB0SZGdlna2QVSsdvBeUidiRSC3HiCduzgRBW0jZhQv++cajaNxsY+8/3sZvDMaMcrX56Qc07cbPB0cQe9ZQjXP3bAkjNEEFOOZuftL9oQ8Ugn3Kn+23rxMIzkPUh+4XMkMqMQMV3TdEtUCB8scyR+9wzkygEWTK8qUQ=
Received: by 10.114.159.1 with SMTP id h1mr1594725wae.1190543754806;
        Sun, 23 Sep 2007 03:35:54 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Sun, 23 Sep 2007 03:35:54 -0700 (PDT)
In-Reply-To: <7vir62dx0u.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58961>

On 9/23/07, Junio C Hamano <gitster@pobox.com> wrote:
> Lars Hjemli <hjemli@gmail.com> writes:
>
> > This option can be used to override --no-commit and --squash. The change
> > also introduces slightly different behavior for --no-commit: when specified,
> > it explicitly overrides --squash.
>
> Makes me wonder if --no-squash also make sense to override a --squash.
> Is this really needed?  IOW, does it ever make sense to have --no-commit
> in the configuration?
>

Actually, I did add --no-squash but the semantics (and implementation)
was identical to --commit so I decided it wasn't worth it (but maybe
it is - just to avoid user confusion?).

-- 
larsh
