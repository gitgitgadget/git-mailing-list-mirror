From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [RFC/PATCH 2/1] bash: eliminate dependency on bash_completion
 lib
Date: Fri, 03 Dec 2010 00:02:09 -0800
Message-ID: <4CF8A401.9010407@gmail.com>
References: <1291236582-28603-1-git-send-email-peter@avirtualhome.com>	<20101202091624.GB1771@burratino>	<20101202091613.6ac8f816@MonteCarlo.grandprix.int>	<20101202210207.GA4994@burratino> <20101202234053.GB3577@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Peter van der Does <peter@avirtualhome.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Dec 03 09:02:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POQb2-0008Iy-Kv
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 09:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758454Ab0LCICS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Dec 2010 03:02:18 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58077 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757747Ab0LCICS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 03:02:18 -0500
Received: by qwb7 with SMTP id 7so9315489qwb.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 00:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=rHB7xjDUlByVYLGH588WZmSQuyLVx+UcLAc6LeAn65c=;
        b=VMZw7dQa+KovrC4e/V/YALckIZhBFitVRaMInhm+zI4iT6jIYe/2GSf2TeV1BByM8L
         vzJ5TBguBoRzlA+J8+YZIRuRpvvxst28pFR8EtVMGbqfJomPX0hpFINcgZqTlfUU6GIY
         XQl1yPh8css01kpteoKJZZjcc4n9sMO8Db9xI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=YyGYXN+HXCkE6tFk3zh2720WLKpLKgU2++sGMqcIvzvi7Ze/9dnvqkoxJvx/ekolll
         oCy1TlmtYhgGKpnWQixL2elEKJI6P91TwHHEWNDdEorxAJbH6v0wrDbdVeeV5m3+rNlK
         xViPkOFdMm68oJwYrbU3g2BASqo7bZq5Bxt18=
Received: by 10.224.28.196 with SMTP id n4mr1043380qac.71.1291363337362;
        Fri, 03 Dec 2010 00:02:17 -0800 (PST)
Received: from [192.168.1.104] ([75.85.182.25])
        by mx.google.com with ESMTPS id t17sm1040716qcp.38.2010.12.03.00.02.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 00:02:16 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101108 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <20101202234053.GB3577@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162767>

On 12/02/10 15:40, SZEDER G=E1bor wrote:
>
> I would really, _really_ like to have the above text in the commit
> message (either in yours or in Peter's), because it took me weeks to
> figure this out ;)  Not that it was that difficult, but when I
> discovered this issue more than a month ago, "unfortunately" I
> remembered a similar issue (db8a9ff, bash completion: Resolve git sho=
w
> ref:path<tab> losing ref: portion, 2008-07-15), and it got me
> sidetracked really really  badly.
>=20

I reported this issue over a year ago!

http://article.gmane.org/gmane.comp.version-control.git/133067

I'll be glad to see it fixed (but I haven't had time to look over these
patches and try them out yet).
