From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: check-ref-format question
Date: Wed, 13 May 2009 16:40:28 +0200
Message-ID: <fabb9a1e0905130740i56a05eaft3b3b28010d8d385b@mail.gmail.com>
References: <93c3eada0905121709k73a47bddu60def6b5fbc1b15e@mail.gmail.com> 
	<4A0AD5A2.2090103@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: geoffrey.russell@gmail.com, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed May 13 16:41:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Fdl-00078K-Lu
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 16:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753411AbZEMOkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 10:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753392AbZEMOkt
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 10:40:49 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:53162 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbZEMOks (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 10:40:48 -0400
Received: by fxm2 with SMTP id 2so693508fxm.37
        for <git@vger.kernel.org>; Wed, 13 May 2009 07:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=KYFzPxpfxqmyAfLvkRVLLsv6aJscycrnuZ3PkqUv+c4=;
        b=umHK+bj46LP5+MfPSGkQIHqa6JKKrVnBbe5/SNNa36PtOSKtfJHsZFeABY0RPfwuOV
         zfPMRUq0KpMLbQINrWRiGfETAGJEdwFp2WRZOVIwrDUc/0UngX0amy+RxJfrXBu26LY/
         mWOoS4Op9oJcHbASlbjpeI63juzbo8PxQseZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=UHi4xeDJPXL1pJbVU4VTduVxduJUdBE2AUg1yYMF6nLgSS3fLM5L/l1vxM1UcIOxCc
         wrSlVI8LD7ORXd/5Za8QXhetcxxfVPqRAYP2vGrXE/wCrVYgl6RQJgA/1qv3ahv2A+bD
         MFscCNedaLj3P3wpqeP27tvPGzh9MP5uUWZCw=
Received: by 10.103.176.20 with SMTP id d20mr762400mup.27.1242225648120; Wed, 
	13 May 2009 07:40:48 -0700 (PDT)
In-Reply-To: <4A0AD5A2.2090103@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119054>

Heya,

On Wed, May 13, 2009 at 16:13, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> The code has always behaved like C since its inception but I don't know
> the rationale behind the 2 level requirement. Daniel, Junio?

Methinks that since it is a plumbing command it is up to the porcelain
to translate "master" into "refs/heads/master" or
"refs/remotes/origin/master" (or whatever is appropriate) before
dispatching to check-ref-format?

-- 
Cheers,

Sverre Rabbelier
