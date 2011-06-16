From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: [PATCH] Fix typo: existant->existent
Date: Thu, 16 Jun 2011 19:28:11 +0600
Message-ID: <BANLkTikMrtHSpMTSO2_mL_RDGBUL2cO0ow@mail.gmail.com>
References: <1308223595-6319-1-git-send-email-divanorama@gmail.com>
	<20110616131938.GA7751@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <carlos@cmartin.tk>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 16 15:28:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXCcM-00010h-L8
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 15:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755423Ab1FPN2O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jun 2011 09:28:14 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:34850 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152Ab1FPN2N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jun 2011 09:28:13 -0400
Received: by pwj7 with SMTP id 7so293269pwj.19
        for <git@vger.kernel.org>; Thu, 16 Jun 2011 06:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=6Zg4VJ4spf87B1ANmfn6VCN1kJY8XnWIY3+Yg67A63g=;
        b=wEvrFUKtlzZTjN88F8Ks2Y1ikWIiecqoYh8OKPncoUQ4nF8H+5LpmGwDBByGJA224w
         ewfELa6EPPpo5TmVhFYBkaAvVbVQXDEacqiHJ4pHgvHpDi9aZm6+Q4cNEky1TzioIPuw
         WaD5HC3NjCLpHjaNHAGEq+bYMV1zOHHRlLjME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=XAuZJUanbrRAQtT6R8z1hjRaOL7JwPdD6MZe8kZ20hcS2eMLbXqNxFkqe64ae0y8yZ
         BfNUvhsEv/wW8dTZ38jQpHzS31vxgQ2/mMVnMemtJDwIQpwy9/bBddmcR8AKRiIa0hfa
         syGfXbA6k7iwPN5rQun05jMwbPCXBNcDmPB+M=
Received: by 10.68.64.69 with SMTP id m5mr362546pbs.383.1308230892127; Thu, 16
 Jun 2011 06:28:12 -0700 (PDT)
Received: by 10.68.42.33 with HTTP; Thu, 16 Jun 2011 06:28:10 -0700 (PDT)
In-Reply-To: <20110616131938.GA7751@centaur.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175897>

On Thu, Jun 16, 2011 at 7:19 PM, Carlos Mart=EDn Nieto <carlos@cmartin.=
tk> wrote:
> On Thu, Jun 16, 2011 at 05:26:35PM +0600, Dmitry Ivankov wrote:
>> refs.c had a error message "Trying to write ref with nonexistent obj=
ect".
>
> From the patch, ITYM to say "with nonexistant object" here
Oops, that's true, thanks for spotting.

>
> Cheers,
> =A0 cmn
> --
> Carlos Mart=EDn Nieto | http://cmartin.tk
>
> "=BFC=F3mo voy a decir bobadas si soy mudo?" -- CACHAI
>
