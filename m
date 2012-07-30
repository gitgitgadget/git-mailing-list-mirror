From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Enhancements to git-protocoll
Date: Mon, 30 Jul 2012 13:42:36 +0530
Message-ID: <CAMK1S_jGXh408K1pr8K5_U8fBMEWnqS7EJAfgoNz=7vYrEf2tQ@mail.gmail.com>
References: <20120728214116.GA3591@paksenarrion.iveqy.com>
	<7vehnvvyta.fsf@alter.siamese.dyndns.org>
	<20120729142458.GB16223@paksenarrion.iveqy.com>
	<CAMK1S_iTv3BOV3LEoj83feuO2iQnPqTrOq0wyFC-GrvvJQqWTA@mail.gmail.com>
	<7vvch6uw89.fsf@alter.siamese.dyndns.org>
	<7vr4ruuu2e.fsf@alter.siamese.dyndns.org>
	<CAMK1S_geKq5DkNAy2wxGt5EmoOesxaSKKuQjVaQVcbRVdR+9gA@mail.gmail.com>
	<CAJo=hJsgMz-=pdG=HB3KtTE7g6Gvu9mr56dg2+V3WUST+rpAQg@mail.gmail.com>
	<7vehnut1kt.fsf@alter.siamese.dyndns.org>
	<CAJo=hJvjFP0m96YPNBCwvnkRGWhMZQdbL7C3Shsa6HQ62a9FuA@mail.gmail.com>
	<7vy5m1sqz3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 10:12:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svl5o-0001ee-O8
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 10:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087Ab2G3IMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 04:12:40 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:33944 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754077Ab2G3IMi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2012 04:12:38 -0400
Received: by lahd3 with SMTP id d3so3249530lah.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 01:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7ao5BJqxcNgCEgmJmgzeSTBKc1CLiFj/APnvwir5MlM=;
        b=twighbsEq2LnFVzapnhcTU7aKK/22DGF6gWzbcAzl/OJ1YCuSiY5Jr2Exi2Hdm9Ud3
         LIt/If3fHCcpwGXvi8pe4RjXHlh975W+L+/tdhdKlTUpV/nBLeyTFGjv3hP6PhxcGhGz
         wi9IP++HErGRiH042TH7ZP10Ari/DcUhugJktWNh9qTJj0WdOF1VKB5u/YHkvuVLD1X9
         oBAHo8Qbd+o6tt3Zoj/iIpSq3hAY7iIXJNH//FwrcsZKp55GX9hiOSHUWi6vbMXnQahv
         jW9udfhaV7RDPB2E3PvTXwZqY0qcpDWy9kBZP9P9dki0fg/XMqQkORu22+5eT9iOf2dI
         E9Zw==
Received: by 10.152.148.195 with SMTP id tu3mr10720705lab.16.1343635956914;
 Mon, 30 Jul 2012 01:12:36 -0700 (PDT)
Received: by 10.112.60.194 with HTTP; Mon, 30 Jul 2012 01:12:36 -0700 (PDT)
In-Reply-To: <7vy5m1sqz3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202526>

On Mon, Jul 30, 2012 at 11:58 AM, Junio C Hamano <gitster@pobox.com> wrote:

> Heh.  While I do not particularly consider auto-creation-upon-push a
> useful thing to begin with (after all, once you created a
> repository, you would want ways to manage it, setting up ACL for it

[side point] these things are managed with templates of ACL rules that
map access to "roles", and the owner (the guy who created it) defines
users for each role.
