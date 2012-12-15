From: David Michael <fedora.dm0@gmail.com>
Subject: Re: [PATCH 1/4] Support builds when sys/param.h is missing
Date: Fri, 14 Dec 2012 21:46:10 -0500
Message-ID: <CAEvUa7kZE-p0oVV+JpXY4y-=ieB-=THTrO4hxzZsFYhLvgvbFw@mail.gmail.com>
References: <CAEvUa7mHHy1=aOMfg4hNnDzod4zSnNHZN87isgf6Yxh5cRAf0Q@mail.gmail.com>
	<7vpq2curpa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 03:46:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tjhll-00045l-HI
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 03:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367Ab2LOCqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2012 21:46:12 -0500
Received: from mail-vc0-f174.google.com ([209.85.220.174]:62367 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab2LOCqL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2012 21:46:11 -0500
Received: by mail-vc0-f174.google.com with SMTP id d16so5056886vcd.19
        for <git@vger.kernel.org>; Fri, 14 Dec 2012 18:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RQuovwBvh4dFFHECCUgyj41PLxk7r6lEmpNJJoBvbew=;
        b=ozDZf5JewKkpeelFb1ZjqLtuqwRkDEEhIRrecVzLRHCxlY7PMpjUCdppHFEtwXYQFF
         kVyc42BhTDfgHYm4u42QDSn0L9dVJi0R+/vATSiTQiRDv88AYVpuY6+iFRo+d843nmYY
         P0aCKDjj+I+kAfDs4WFY3SPWxdBIYEUQ1I0e9LXUxQi+gKU/h0WkPQctQsFopNOLQEqG
         pwpbB6ym/x78UxulW2WQsFTQohy6R8BfiPRdTkfyM+Rr2cow+ZBJsnhdZ+Cm+LiIrKsw
         H6H2epLIn+8yPOvfbcK/6KPZoT34hIM1GJv99/owOjDk5QD2IU2qix01KcEKB5KVqYtg
         VI3A==
Received: by 10.220.157.9 with SMTP id z9mr12463460vcw.45.1355539570827; Fri,
 14 Dec 2012 18:46:10 -0800 (PST)
Received: by 10.58.85.138 with HTTP; Fri, 14 Dec 2012 18:46:10 -0800 (PST)
In-Reply-To: <7vpq2curpa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211514>

Hi,

On Fri, Dec 14, 2012 at 6:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I have this suspicion that nobody would notice if we simply stopped
> including the header.

While I'm not aware of any subtleties it could be causing on other
platforms, it does seem fine to drop sys/param.h on my test GNU/Linux
systems.

I can resend the series and just remove the include, if preferred.

Thanks.

David
