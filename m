From: =?iso-8859-1?Q?Sidney_San_Mart=EDn?= <s@sidneysm.com>
Subject: Re: Question about commit message wrapping
Date: Fri, 9 Dec 2011 12:50:33 -0500
Message-ID: <E085218D-9287-4F82-B34C-8379742F818A@sidneysm.com>
References: <35A5A513-91FD-4EF9-B890-AB3D1550D63F@sidneysm.com> <m3zkf1hnh9.fsf@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Jakub Narebski <jnareb@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 09 18:50:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ4an-0006js-15
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 18:50:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301Ab1LIRud convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 12:50:33 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47865 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797Ab1LIRub convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 12:50:31 -0500
Received: by qcqz2 with SMTP id z2so2361923qcq.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 09:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sidneysm.com; s=google;
        h=content-type:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=4+B9ZLn0fB0yEJ48BVyrBii4KKRZeNzPlPISF9/ZByE=;
        b=GV11IAIyV+kP8DElHGiemfGM2JmVQ4sa04QjjqPbdh1Kuk7Xp9tmkVXa/vkS7+b4kL
         QCWzntqrsdzS/SjzfwXrU0Qk8wzRTZY2C478wVav8LHExTTq0mVZiOj6zc5x8uItZ5rk
         awFvyR9xjdoWuFmzoUhen1F9Dzz3k5m6xfBL8=
Received: by 10.229.68.152 with SMTP id v24mr2146251qci.31.1323453030915;
        Fri, 09 Dec 2011 09:50:30 -0800 (PST)
Received: from [172.20.1.57] (rrcs-184-75-21-194.nyc.biz.rr.com. [184.75.21.194])
        by mx.google.com with ESMTPS id i10sm17807615qac.17.2011.12.09.09.50.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 09:50:30 -0800 (PST)
In-Reply-To: <m3zkf1hnh9.fsf@localhost.localdomain>
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186656>


On Dec 9, 2011, at 8:41 AM, Jakub Narebski wrote:

> Sidney San Mart=C3=ADn <s@sidneysm.com> writes:
>=20
>> *Nothing else* in my everyday life works this way anymore. Line
>> wrapping gets done on the display end in my email client, my web
>> browser, my ebook reader entirely automatically, and it adapts to
>> the size of the window.
>=20
> The problem with automatic wrapping on the display is that there coul=
d
> be parts of commit message that *shouldn't* be wrapped, like code
> sample, or URL... and in plain text you don't have a way to separate
> flowed from non-flowed part.
>=20

I usually lead code, URLs, and other preformatted lines like this with =
a few spaces. Markdown uses the same convention, and it looks like comm=
its in this repo do too.

The patch in my last email prints lines which begin with whitespace ver=
batim. How does that work?

> Also with long non-breakable identifiers you sometimes need to wrap b=
y
> hand (or use linebreaking algorithm from TeX) or go bit over the limi=
t
> to make it look nice.
>=20

Could you elaborate on this? The patch uses strbuf_add_wrapped_text, wh=
ich was already in Git. If an identifier is longer than the wrap width,=
 it leaves it alone.

> BTW. proper editor used to create commit message can wrap it for you
> ;-).

Only if everybody else in the world does it too! And only if I never ca=
re about seeing my commits at any width besides 80 columns.

> --=20
> Jakub Nar=C4=99bski
>=20
