From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 1/4] Introduce CHERRY_PICK_HEAD
Date: Thu, 17 Feb 2011 16:48:55 -0600
Message-ID: <20110217224855.GC10007@elie>
References: <1297916325-89688-1-git-send-email-jaysoffian@gmail.com>
 <1297916325-89688-2-git-send-email-jaysoffian@gmail.com>
 <7v39nm9vgv.fsf@alter.siamese.dyndns.org>
 <AANLkTinWCZqb=C5qbiGpwq4=PQCUswfyxekTDD6scNbm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 23:54:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqCjq-0005NL-Br
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 23:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989Ab1BQWyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 17:54:13 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64729 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175Ab1BQWyL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 17:54:11 -0500
Received: by fxm20 with SMTP id 20so3155819fxm.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 14:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=N1lpDCOtyFimYckUywAACcHbSxbX/S6ouFtMddCFp7w=;
        b=PN36Tyuz6SoguVQ2HZw2ef+BMdWi3judofqwqlhjEU98yQ3ctnYgDOhHOorVsNGkCY
         9VZhS83pEc2cF8yiDsHSnKS6tH8+QRtXM5E+aULBXP5mgW/EuXulWkmIGxUSKZBxuN5w
         n9pCSjfLHHyPVpGyH91kRZ4ADp09SkQ1pygiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EgBHEU8dV2ra9pMmH6hmXalRGJS0W5upaA9Z+7/yuk+IDM3IZGxh5aHqyTGHpclmPD
         7DDMNi8c+sUwVL68fSx8Kkv+mS/CQ+wd5Ji3tcBiRiOffzgw/PK2EyNPBOeGqsz8HY/p
         +g8s2o45cOg5McIgM5JjPV0nibBnpZAYwRxq8=
Received: by 10.223.71.195 with SMTP id i3mr3121722faj.149.1297982944021;
        Thu, 17 Feb 2011 14:49:04 -0800 (PST)
Received: from elie ([69.209.51.217])
        by mx.google.com with ESMTPS id y1sm762850fak.39.2011.02.17.14.49.02
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 14:49:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinWCZqb=C5qbiGpwq4=PQCUswfyxekTDD6scNbm@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167132>

Jay Soffian wrote:
> On Thu, Feb 17, 2011 at 4:56 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> This series in 'pu' seems to break t3404#16.
>
> Sorry for the breakage, I was running the test suite piecemeal and
> must've not run that test (which was dumb of me).

I made the same mistake, too.  Sorry for the trouble.

> I'll figure out
> what's going on and re-roll with Jonathan's t3507 improvements as
> well.

FWIW (probably you noticed, but just in case) I imagine the t3507
improvements should go as a separate patch, since their main effect
is to clean up existing tests.
