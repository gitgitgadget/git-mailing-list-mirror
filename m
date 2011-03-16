From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 3/3] Use the new {real,absolute}_path function names
Date: Wed, 16 Mar 2011 17:24:49 +0100
Message-ID: <AANLkTikvb0-XJKwNmaJGeJiZQzYC=_k9_MChyOgvkE1o@mail.gmail.com>
References: <1300291579-25852-1-git-send-email-cmn@elego.de> <1300291579-25852-4-git-send-email-cmn@elego.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Mar 16 17:35:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzthK-0004Rh-03
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 17:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495Ab1CPQfl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 12:35:41 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34913 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab1CPQfk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2011 12:35:40 -0400
Received: by fxm17 with SMTP id 17so1842936fxm.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 09:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=eDoNambxIYjUg67DsbG9Shwkg3KedZWA3et9jwSd4GM=;
        b=ogek4Vb8QxNpTpZu4ujVJqHPEvO8MEu/YyzOckWeYmo0QMC8R8IrZDI+0RYKwpy1DP
         VqVZy4zfBfbV9bDGXELsfTTJMlZz29lTty3W8uhv9Le4v1bb5pUo6Ltzo4UTsJrJB8/x
         dmqlCBLE1stJovtitxzKmYpRkVCu3aQlnEMng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=W3p76hlmqC3J94xPa2S8+0eNRA3gk+2/Dmr/Ixz05KpPPGfVxcaKDkkWkhVlaquHj6
         dYoIfUawmFq6Ca0nBKsU8eOyShiP4GqUOQSkKhurCNA4v8L+LP5/6Ru187yt4KoF+3GO
         3P+pAQmr1by9kb0dMaJAaN+Ti+XslQaEn9Z+M=
Received: by 10.223.77.16 with SMTP id e16mr193574fak.87.1300292737701; Wed,
 16 Mar 2011 09:25:37 -0700 (PDT)
Received: by 10.223.117.78 with HTTP; Wed, 16 Mar 2011 09:24:49 -0700 (PDT)
In-Reply-To: <1300291579-25852-4-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169171>

On Wed, Mar 16, 2011 at 5:06 PM, Carlos Mart=EDn Nieto <cmn@elego.de> w=
rote:
> Use the new names for path functions in the code. Replace uses of
> make_absolute_path with real_path, make_nonrelative_path with
> absolute_path and make_relative_path with relative_path.

Shouldn't these changes be squashed into the previous two commits so
it'll be possible to bisect across it without getting a broken build?
