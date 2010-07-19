From: Jared Hance <jaredhance@gmail.com>
Subject: Re: [PATCH] Add --exclude to git-clean.j
Date: Mon, 19 Jul 2010 12:21:16 -0400
Message-ID: <20100719162116.GA4463@localhost.localdomain>
References: <bf4ea4e83162ebf1d915b87413aad54a1162a637.1279554580.git.jaredhance@gmail.com>
 <20100719161414.GA17597@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 19 18:21:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oat5v-0004n5-F2
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 18:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936364Ab0GSQVZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jul 2010 12:21:25 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49381 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936320Ab0GSQVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 12:21:25 -0400
Received: by mail-gy0-f174.google.com with SMTP id 4so2186003gyh.19
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 09:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=L5+fSSK+TZsnS3lZe7UOR5cQ1ebcMl9WhgegM7ZIArI=;
        b=n31rfENZO6FfMTv6j8WRtn207S55mq6TnEGzJj39vFF8BFTjhfwsMyH/2gwjJ8/L8Y
         HI55ihq8Saf5G0NtEKogTzds7YVlsxyKQdRkRytajZ5LFORAd/U5JUxixC2VM8hWqApu
         VvmyMmpxk2kFIwKg60PR6/AB8eu4n9BH1SF54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=by09tGXIpuVDkO+LqaQ4YhiWz1uUbL/TtDwrJrDW+vUdZI+FVfJ56LUXhzAU5LXgUa
         t8zXwMMVCKoqwQTHWgGjV2kgSvJrEBYuslv3jLO1uzGwAVE5haMqJMq83Tmddvw2SEuu
         EdDY9bN1ppMhZBX8tz5xdCsZLy1nol885swoI=
Received: by 10.224.115.79 with SMTP id h15mr4200341qaq.21.1279556484314;
        Mon, 19 Jul 2010 09:21:24 -0700 (PDT)
Received: from localhost.localdomain (cpe-75-186-1-50.cinci.res.rr.com [75.186.1.50])
        by mx.google.com with ESMTPS id q30sm26148511qcq.24.2010.07.19.09.21.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Jul 2010 09:21:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100719161414.GA17597@burratino>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151256>

On Mon, Jul 19, 2010 at 11:14:14AM -0500, Jonathan Nieder wrote:
Johnathon wrote:
> No thoughts on your patch, but have you looked into =E2=80=9Cgit add =
-N=E2=80=9D?

That is interesting. However, it doesn't really help for files that
you don't intend to add to the index later. "git clean -e" is nice for
when you have a file you are using for some temporary purpose.

On another note, I failed getting my title correct, so I sent another
patch with the correct title (I think it affects the description of
the commit).
