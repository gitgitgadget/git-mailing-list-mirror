From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH] merge: honor prepare-commit-msg hook
Date: Wed, 9 Mar 2011 17:50:34 -0500
Message-ID: <AANLkTi=yxrLGEPQVG=knkZgXyeiAX+f_cF+mfJ3BYf+O@mail.gmail.com>
References: <AANLkTimqxNNJ7ezBYC8V_pW5=HB1md1xVrnKFV8sVBue@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeffrey Middleton <jefromi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 23:51:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxSDp-0003cd-AR
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 23:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280Ab1CIWvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 17:51:08 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39485 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814Ab1CIWvF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 17:51:05 -0500
Received: by iyb26 with SMTP id 26so958389iyb.19
        for <git@vger.kernel.org>; Wed, 09 Mar 2011 14:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=V33/48UARlA1qP0ZhiKTHu+L8/3l0vlTuZhcWlLS5Bs=;
        b=UHQjVJ/53OH+xNHXkIsLwrnQWhjxyBRAnNISzzoho05m4Npp57EkqSoFGHFVUz09f3
         D2NzBdAhlszTB0mbj3WJjxtyoiBWwOxbiawxdaRvmwBEKfoWMrJ2UKq3d3ss56PFUkjy
         5Uu+u2F2/pcboRA+m3DMlKG7JSdpTX0r32Vsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=co6AYIUn82zwuugNpy0nCSn270uPfPwLuFLtQ48msit5Z5iqAUOpCY8c0Fv9TtGNpo
         6Ro7A2eg0Rhnkf/MbktoIRYxCiWC+IMHQxmOUJKeE+SMEHA2Ep5pIFWF8Fo4gSnzmFYd
         Uv4ART4BKNZ32M416wTmaWhkgMziUqxJnhD7I=
Received: by 10.43.134.1 with SMTP id ia1mr735650icc.127.1299711064204; Wed,
 09 Mar 2011 14:51:04 -0800 (PST)
Received: by 10.231.34.7 with HTTP; Wed, 9 Mar 2011 14:50:34 -0800 (PST)
In-Reply-To: <AANLkTimqxNNJ7ezBYC8V_pW5=HB1md1xVrnKFV8sVBue@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168773>

On Tue, Mar 8, 2011 at 7:16 PM, Jeffrey Middleton <jefromi@gmail.com> wrote:
> I'd like to add a voice to the support for calling the
> prepare-commit-msg and post-commit hooks during a merge.

See 65969d4 (merge: honor prepare-commit-msg hook, 2011-02-14), now in
master. I didn't do anything about the other hooks though.

j.
