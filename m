From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: bug in gitk: history moves right when scrolling up and down with
 mouse wheel
Date: Fri, 07 Jan 2011 12:44:18 -0600
Message-ID: <4D275F02.1030100@gmail.com>
References: <20110107105523.GA6701@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Fri Jan 07 19:45:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbHJB-0007sp-GG
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 19:45:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755077Ab1AGSo7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jan 2011 13:44:59 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52318 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755052Ab1AGSo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 13:44:58 -0500
Received: by gyb11 with SMTP id 11so6668859gyb.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 10:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=DfYI6054kAr96bJiOWP5a9f4/02Q2iGBfiSbC2KcNIM=;
        b=lDHC6AbbZmX+mgDbwiqKo8XVkVjoRwxKlagHcF9GsBecBgk4VAjLaZPHXfZb0b7+2v
         euJBiyYlTVx9drND65Ty8AA06LVzwB+MXRlDkie8AWfRIAuYXxaqeMydujyXGTMaMQl2
         zEtI0RmUP6Zhk3so4nKXTYnVuVh2Tmm0RHYXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=hoJm1sFeWcwTtaQ78btXUOUsL5oGpv/7Azh0EUQ4dzR6on+CnUo+XQr90IE4qNm/Sj
         4w2YG4SlaetoswHciTFyboKUaPmnJaMwkpI+5ITXFVMGHd3n4E+jjNyrDR60hk92Cwwc
         QZ5fm/DWZRuBOaAASR8jr9rnAMm+SVULqUq/I=
Received: by 10.236.102.179 with SMTP id d39mr20356135yhg.72.1294425897998;
        Fri, 07 Jan 2011 10:44:57 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id f4sm696753yhc.14.2011.01.07.10.44.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Jan 2011 10:44:56 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20110107105523.GA6701@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164736>

On 1/7/2011 4:55 AM, Uwe Kleine-K=F6nig wrote:
> Hello,
>
> I don't know yet how to reliably trigger that, but it feels scary.
>
> If that help, it happens with the view
>
> 	{karo {} ^linus/master {git for-each-ref --format=3D'%(refname)' ref=
s/remotes/customers/karo refs/heads/karo}}
>
> If I knew how to record a video of my screen, I'd do this.  Maybe
> someone knows?  Maybe this report is already enough?
>
> Happens with Debian's git 1:1.7.2.3-2.2.
>

Actually, I've wanted the ability to scroll left and right in the=20
history pane for quite a while.  Resorting to shrinking the fontsize an=
d=20
the other columns only goes so far when trying to see a list of=20
equivalent refs.  If the ability to scroll left and right can be kept=20
that would be cool.

v/r,
Neal
