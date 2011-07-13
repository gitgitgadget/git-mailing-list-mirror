From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 10/17] sequencer: Announce sequencer state location
Date: Wed, 13 Jul 2011 14:10:54 +0200
Message-ID: <CAGdFq_ijTh-m7+zRFAyqvhN5k_BrC1TPdc3y47h=tBUiz6QF2A@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-11-git-send-email-artagnon@gmail.com> <20110712185638.GA14909@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 14:11:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgyI0-0008Cw-Df
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 14:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413Ab1GMMLf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jul 2011 08:11:35 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54896 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab1GMMLe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2011 08:11:34 -0400
Received: by pzk9 with SMTP id 9so4743155pzk.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 05:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=t9Spa9gGtk2Ydm9Zx6wtfihBltZBxF2n+Z3+K8Dk6H0=;
        b=Y7jXtCPxhu7fx2bTdDCJ9ZcEn/N6Qsl1XWF4EzRsdzEaawsfMpX8GIRD7qnnqgHSrl
         8GRTmZIJ3o/EF3RGV9UralajqGiO8sF93wpkR96DZf/ZhZhn141Xz95VYzagvh31KyYU
         +JuxyZegDryiqHLTdG6kWJouqokoN1IKpfjhE=
Received: by 10.68.27.232 with SMTP id w8mr1238256pbg.49.1310559094092; Wed,
 13 Jul 2011 05:11:34 -0700 (PDT)
Received: by 10.68.49.39 with HTTP; Wed, 13 Jul 2011 05:10:54 -0700 (PDT)
In-Reply-To: <20110712185638.GA14909@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177024>

Heya,

On Tue, Jul 12, 2011 at 20:56, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> As far as I can tell, it is to introduce a remove_sequencer_state()
> function whose eventual purpose would be to remove the .git/sequencer
> directory used by "git cherry-pick" to record its progress. =C2=A0Par=
aphrased,
> the function does this:

I think we can learn from hg here and just use a datetime stamp. So
instead of moving to sequencer-old move to sequencer-20110713-141022
or such. That way there's as many undo as you need.

--=20
Cheers,

Sverre Rabbelier
