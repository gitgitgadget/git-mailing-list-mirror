From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] git-completion: fix zsh support
Date: Wed, 27 Apr 2011 04:42:34 +0300
Message-ID: <BANLkTi=9PPJWX-y2YuFt3k0op2TaJ54=pw@mail.gmail.com>
References: <1303867612-15975-1-git-send-email-felipe.contreras@gmail.com>
	<20110427013534.GA14286@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stefan Haller <lists@haller-berlin.de>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Mark Lodato <lodatom@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 03:42:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEtm9-00075i-1i
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 03:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599Ab1D0Bmg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2011 21:42:36 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42957 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212Ab1D0Bmg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2011 21:42:36 -0400
Received: by fxm17 with SMTP id 17so829226fxm.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 18:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Rs+E3prntXAQT9zF2Lr5NR+/mVfs2o/4lQo3D43TC3U=;
        b=ECskbpnzLvTQVQnma6xHnhjmqqrtr17xo+UyKGjNlDcLPyncyySjO/RMWLMErV0mBJ
         Erea8kttVLs+SaRcD4ZfG0Pk75ZglkdfYMf7+D7hE7HLJrXIzJ51LB5AXaSo/6Q/JsN4
         eI+XL2k8YrJx+1iSIRw4L2GBRFT6+TH/8+Bfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=d7e4f3hwfpMyp13VPg/fFBYH4X0cRSR6w6geAMmnVLQ/bBx7P8OQ7dT1fSSczUfRhe
         V+Ux2S4JNu/aCyKaP5xgMIn20p3OnxJbo0cjhphL48TUlyMJTKJ61FZMg1eaHSdHW6me
         EAs/70Q290vcmwez7DWndZbmb2KVMF0zSlthM=
Received: by 10.223.87.215 with SMTP id x23mr1623003fal.32.1303868554871; Tue,
 26 Apr 2011 18:42:34 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Tue, 26 Apr 2011 18:42:34 -0700 (PDT)
In-Reply-To: <20110427013534.GA14286@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172144>

On Wed, Apr 27, 2011 at 4:35 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Felipe Contreras wrote:
>
>> It turns out 'words' is a special variable used by zsh completion, a=
nd
>> it has some strange behavior as we can see.
>>
>> Better avoid it.
>
> Hoorah! =C2=A0I imagine this fixes a regression introduced by
> v1.7.4-rc0~11^2~2 (bash: get --pretty=3Dm<tab> completion to work wit=
h
> bash v4, 2010-12-02).
>
> =C2=A0Acked-by: Jonathan Nieder <jrnieder@gmail.com>

Yeap... The completion wasn't working at all after that :(

--=20
=46elipe Contreras
