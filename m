From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: Re: Wrong code on master
Date: Sat, 24 Dec 2011 09:42:20 -0600
Message-ID: <CAPRoxBXVeK25H2SfE4WxhN0h0EyHViQYt=+W_3SdhDqi4jqRHg@mail.gmail.com>
References: <36BFCDA4-8249-4965-877F-FFC9EA65C7EE@memoryties.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Duncan <jonathan@memoryties.com>
X-From: git-owner@vger.kernel.org Sat Dec 24 16:42:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ReTjw-0003if-Up
	for gcvg-git-2@lo.gmane.org; Sat, 24 Dec 2011 16:42:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755208Ab1LXPmX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Dec 2011 10:42:23 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:51897 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754535Ab1LXPmW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Dec 2011 10:42:22 -0500
Received: by wgbds13 with SMTP id ds13so14731162wgb.1
        for <git@vger.kernel.org>; Sat, 24 Dec 2011 07:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=166oHOQjvELkZBs4z8n7OkolujtaiTCbhccAziiPJG4=;
        b=mYmtPiTCZF75lCDwXHB15m3Erk3daNJ155oA1hFFz1aCScXnby9bIDyv7W8OrCY8ic
         2MQhtGk71r3XTWBX3B4MoRfUOSvbOxT25xObQWrMAR51RWym+nWpRm9DErqJ+dJlScMr
         VJxdvFLDOtWTnku/lFXPrL6BcPjdI1XNMNlD8=
Received: by 10.216.139.155 with SMTP id c27mr10312705wej.37.1324741340982;
 Sat, 24 Dec 2011 07:42:20 -0800 (PST)
Received: by 10.180.107.193 with HTTP; Sat, 24 Dec 2011 07:42:20 -0800 (PST)
In-Reply-To: <36BFCDA4-8249-4965-877F-FFC9EA65C7EE@memoryties.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187661>

On Fri, Dec 23, 2011 at 11:09 PM, Jonathan Duncan
<jonathan@memoryties.com> wrote:
> I have a developer that committed code that should have been on a bra=
nch. =A0I have created a branch now and locally my master branch is goo=
d to go. =A0However, when I try to push it conflicts, of course, becaus=
e the repo still wants me to pull the changes and merge them to my mast=
er.
>
> The new code from the other developer will eventually be used, but we=
 were not ready for it to be on "master" yet. =A0I need to push my own =
code out before that other code gets used.
>
> Will I really have to pull and merge the code to master and then reve=
rt? =A0I have been googling all day, trying to figure out the best way =
to do this and in the process I fear I have made a mess of my repo. =A0=
I have been using git long enough to be dangerous to myself.
>
> Any thoughts? =A0Got a good article I can read?

I have found this helpful:

http://thread.gmane.org/gmane.comp.version-control.git/77196/focus=3D77=
273

>
> Thanks,
> Jonathan--
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html



--=20
Nathan Panike
