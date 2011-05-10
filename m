From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 (for maint)] git-completion: fix regression in zsh
 support
Date: Tue, 10 May 2011 17:18:58 -0500
Message-ID: <20110510221858.GE1994@elie>
References: <1305030039-16044-1-git-send-email-felipe.contreras@gmail.com>
 <7vr586jwzm.fsf@alter.siamese.dyndns.org>
 <BANLkTinRB-hUwOdZsWRFZWxUAebkFeaGVQ@mail.gmail.com>
 <7vd3jqjtqx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 00:19:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJvGo-0001WG-8t
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 00:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398Ab1EJWTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 18:19:05 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48926 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab1EJWTD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 18:19:03 -0400
Received: by ywj3 with SMTP id 3so2318890ywj.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 15:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=9UUuNK16wqG/J5ZZFU41gKkUSYznCC3R29VPZj/Przk=;
        b=gm4JNYO5Gqiq6akdb+53r5R3ztBuRCGRm2/MpfHxU/GE9YC2x2l+jRbMpsZn3GUlMq
         AD+Vww9BNX6kBHDligcr6AnUkJcZb7gwmyS52E4G4vjvMnu6t6CxHHqwX0FAtlsV7knD
         B9f2Rvu209Qip95wIDXSYMuvBE5+eCg6hKVnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sgXH3vPbwPM8PaWP596f2y8q5mjpFIQ4e+Qvy7wkUpRY+HrZXiSiP9yBZa49YjFz31
         uVe560B+fDGqZ2T0bUJ4X2alGiL4kLr/HB1FSzlyoOCIdecaoQtPSFOtgJtWJpA3Xl5l
         wDlVUINFJORCFm904aK512AxNE7dBwiHKIveQ=
Received: by 10.236.183.5 with SMTP id p5mr9812928yhm.16.1305065942674;
        Tue, 10 May 2011 15:19:02 -0700 (PDT)
Received: from elie (adsl-69-209-56-134.dsl.chcgil.ameritech.net [69.209.56.134])
        by mx.google.com with ESMTPS id d46sm3363300yhn.74.2011.05.10.15.19.00
        (version=SSLv3 cipher=OTHER);
        Tue, 10 May 2011 15:19:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vd3jqjtqx.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173372>

Junio C Hamano wrote:

> Mentioning 1.7.5 only helps the users if
> git-completion.bash in 1.7.4 did not have an issue even on the current zsh
> and 1.7.5 had an issue. I thought you may know which without me having to
> dig that information out.

The zsh support was introduced in 1.7.4-rc0[1] and the breakage was introduced
in 1.7.4-rc0[2], for what it's worth.

[1] v1.7.4-rc0~169^2 (completion: make compatible with zsh, 2010-09-06)
[2] v1.7.4-rc0~11^2~2 (bash: get --pretty=m<tab> completion to work
with bash v4, 2010-12-02)
