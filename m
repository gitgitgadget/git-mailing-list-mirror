From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Wed, 5 Oct 2011 17:52:23 -0400
Message-ID: <CAG+J_Dz=9jAFBQ5fpY=d6M5Zc-BhNFi6foKJx69v3n3Km-U0rg@mail.gmail.com>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
	<CACsJy8AqYq+YF+rvUp=BBeFUAtUz783iF2jbUp3fO58yLp9ptQ@mail.gmail.com>
	<CAG+J_DygQTD5ibco=-NOiKg0BLgBGFJnvV8zPyhngC2iZv_H8g@mail.gmail.com>
	<7vpqib8jzk.fsf@alter.siamese.dyndns.org>
	<CAG+J_Dz-GXvRbYUXSoyfyHfOO-_BszcOza9x=ysHhmL5YBW-Jw@mail.gmail.com>
	<7vzkhf713u.fsf@alter.siamese.dyndns.org>
	<CAG+J_Dzg2D+vmFRfLX01S2k98YZQBE0FFv76VAyPnXdetyWADQ@mail.gmail.com>
	<20111005200043.GA32732@inner.h.iocl.org>
	<CAG+J_DynQ8U6T9YMsWstKF_Cf6CSCr8b8E4T=p5uyGPh28G=kA@mail.gmail.com>
	<20111005213002.GA12667@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Krey <a.krey@gmx.de>, Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 23:52:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBZOL-0006sk-WB
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 23:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935395Ab1JEVwY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Oct 2011 17:52:24 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42666 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932499Ab1JEVwX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2011 17:52:23 -0400
Received: by gyg10 with SMTP id 10so2008601gyg.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 14:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ea+TfgBwr1NAfgrTCAdlZPtWH/yNC2Dui8lNukI81Ok=;
        b=wGDAVTKe8xyl7/dE1fdisjy4VMp5NjyZIEQqNSGiGAg1PyJ6UEwq8cWlki4Rol3AAE
         PcaqLQC9yLFwekfPlXO5S1xEcejk2YVoDV7VbPcqktQHuv3Hmr3du3G7QMxhDTPP+dVs
         MBOBeueSDDOA1KXdeuHIUZgh5t4uVlFtcZ6+I=
Received: by 10.236.190.200 with SMTP id e48mr16236369yhn.59.1317851543240;
 Wed, 05 Oct 2011 14:52:23 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Wed, 5 Oct 2011 14:52:23 -0700 (PDT)
In-Reply-To: <20111005213002.GA12667@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182890>

On Wed, Oct 5, 2011 at 5:30 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> As for moving =E2=80=9Cgit new-workdir=E2=80=9D out of contrib, I bel=
ieve another
> prerequisite is sharing the HEAD reflog.

I don't understand this. Is it about not gc'ing commits that other
workdirs are detached on, or something more?

I like that each of my workdirs have their own HEAD reflog.

j.
