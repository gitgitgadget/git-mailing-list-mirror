From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git fast-import : Warning duplicated ref:
 refs/remotes/origin/master
Date: Sun, 29 May 2011 18:24:05 -0500
Message-ID: <20110529232405.GA8369@elie>
References: <BANLkTinTuEppMGO16z2sMkjV8FveCbrwEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Mike Hommey <mh@glandium.org>
To: =?utf-8?B?SsOpcsOpbWll?= NIKAES <jeremie.nikaes@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 01:24:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQpLH-0005Ev-PD
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 01:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840Ab1E2XYN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 May 2011 19:24:13 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41173 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753530Ab1E2XYN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2011 19:24:13 -0400
Received: by yxs7 with SMTP id 7so1261710yxs.19
        for <git@vger.kernel.org>; Sun, 29 May 2011 16:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=q5QhELYS8Y+GRQzpMZurga04IzXOdZ0R5y8+TAVwXVQ=;
        b=KNHOD9z2xgWpvSTV8m+ZJhSN6ZGdxAKof5foQKcqZgmSXZIO7fjlf74AfNc3HdwlVX
         ingiKWjs6IYEDq4zcVbNtDSm5cK3tsMX0b2o1fMn0P5ubPlBc9nV7dwghlQpoaFlluXp
         OIcqt6ica2ou2IQoeTuer0FeEqCBDOyt5dbm4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=s41xF8g7+wbssihMu27RYVlJpYylcpscvp4/+m767q6sWxX4uMaoEoBrSIIsULII5K
         QRCpOJ31RFRcjkss9u9sXhzvdcvCisQP4K0Zd91vHBcM+IK9pntd8wKoQSZfPLZGWv63
         979zyXERZLDqBa5yWxAqlxAzLtzqY0AkkuZ1o=
Received: by 10.236.85.243 with SMTP id u79mr5012287yhe.119.1306711452089;
        Sun, 29 May 2011 16:24:12 -0700 (PDT)
Received: from elie (adsl-69-209-65-98.dsl.chcgil.sbcglobal.net [69.209.65.98])
        by mx.google.com with ESMTPS id a45sm626903yhm.49.2011.05.29.16.24.10
        (version=SSLv3 cipher=OTHER);
        Sun, 29 May 2011 16:24:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTinTuEppMGO16z2sMkjV8FveCbrwEQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174710>

Hi J=C3=A9r=C3=A9mie,

J=C3=A9r=C3=A9mie NIKAES wrote:

> At the end of a git clone mediawiki::http://ourwikitest, everything
> looks perfectly fine

I just wanted to say, thank you for working on this[1].

This code answers some questions I had about the remote helper
protocol, among other things.

> a "Warning duplicated
> ref: refs/remotes/origin/master" is thrown.

To end the suspense: I assume this was fixed by 9055039c (Bug fix for
pulls with multiple revisions pulled, 2011-05-29).

Cheers,
Jonathan

[1] git://github.com/Bibzball/Git-Mediawiki.git
