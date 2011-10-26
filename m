From: Lynn Lin <lynn.xin.lin@gmail.com>
Subject: Re: git merge successfully however this is still issue from logical perspective
Date: Wed, 26 Oct 2011 20:29:25 +0800
Message-ID: <CAPgpnMR6_pRxMSLcdS=M4Cfj=dqk6KTXr3VGhk3LrnPHyv2waA@mail.gmail.com>
References: <CAPgpnMSSOss=YxsMUZJ3E5TynDfHJG1i6PKitLBo_Tm7f=_+fQ@mail.gmail.com>
	<201110261427.03585.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Oct 26 14:29:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJ2br-0008OL-Rk
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 14:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932880Ab1JZM31 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Oct 2011 08:29:27 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48889 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932831Ab1JZM30 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Oct 2011 08:29:26 -0400
Received: by vws1 with SMTP id 1so1359478vws.19
        for <git@vger.kernel.org>; Wed, 26 Oct 2011 05:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=oczLwIiQdt5GoyFZAbySytdnfIKRdTpTImVz57lm6jM=;
        b=WfvT17s+bxWOJY71sL2+QpMjbaRpjd9Oaf0ymmJ89vOo3H8zM4X2TVIB3Yn/opafSt
         pDo0ngxTiaujkJ2wVrX4bcQx9I85K3FPMdFMY1l+XM9ElDO/3FhFHgQCsAtR+cOtxzZW
         b1aebNydX2EUKTeGQJuq+DQK6Aj9Ysze4VQLg=
Received: by 10.52.64.169 with SMTP id p9mr32074556vds.99.1319632165640; Wed,
 26 Oct 2011 05:29:25 -0700 (PDT)
Received: by 10.52.167.201 with HTTP; Wed, 26 Oct 2011 05:29:25 -0700 (PDT)
In-Reply-To: <201110261427.03585.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184258>

On Wed, Oct 26, 2011 at 8:27 PM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> Lynn Lin wrote:
>> Hi all,
>> =A0 =A0Do this case can happen? When I do merge from one branch to m=
aster
>> branch,merge successfully however from code logical perspective it
>> fails and It cause code compile (our project is using C++ language)
>
> Sure. =A0The easiest example is when one side of a merge renames foo(=
)
> to bar(), while the other side introduces another call to foo() in an
> unrelated part of the code.
Does this mean we shouldn't trust merge result  ?

>
> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
>
