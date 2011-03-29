From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] reset: update help text
Date: Tue, 29 Mar 2011 20:29:43 +0700
Message-ID: <AANLkTin5CguMu360+hV_QJYHnyEQYeVp05HSBp05UGvr@mail.gmail.com>
References: <1301404805-12095-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 15:30:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Z03-0005Lc-1x
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 15:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166Ab1C2NaP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 09:30:15 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45612 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab1C2NaO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 09:30:14 -0400
Received: by wya21 with SMTP id 21so141390wya.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 06:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=/tHEpKTgeh+6QNa+HBRI7+fi15qOsUg7kswF264Xjok=;
        b=E5Mtcds979YcraeOYKIz2m4FmB5qw5QmYumFaR52OckTHnI/JRqPggbBNzJzl67wIQ
         Ts7SxII1jSLG8ve5DEZvUZouPCGks8grNxeH1rhKelI1Dhh641pmP5YcI2lncNzdiK9y
         7beMSR7QrxaFJUzRlnstF/3KmzOLtR2Tz6jHY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=CatFbpJAXebmsljC8BMJHLyf+rKESby2aVSpxmnGfb4se9JrW9DdsFLeenizktEg6W
         d/nFSdpqD/1Wh5IcGstMa7vD9BwDhTmweYA+0EnJfIAlIJSxD9sGdhx5WESZMqH+63Ot
         2T58XnnGKf+GW2MktprGZCJvwcs8L/bciRWiQ=
Received: by 10.217.2.73 with SMTP id o51mr4269638wes.66.1301405413211; Tue,
 29 Mar 2011 06:30:13 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Tue, 29 Mar 2011 06:29:43 -0700 (PDT)
In-Reply-To: <1301404805-12095-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170267>

2011/3/29 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> Also make it clear how --hard and --merge are different.

By the way I don't like the option names --hard, --mixed and --soft.
They do not remind me what they actually do. Every time I need to do
non-default operation, I have to open man page.

I've been thinking of --ref, --index and --worktree as a more friendly
version, which can be combined and converted to --soft, --mixed and
--hard internally. Invalid combinations will be rejected. That
thinking went well until I found out there were --merge and --keep,
and was stuck.
--=20
Duy
