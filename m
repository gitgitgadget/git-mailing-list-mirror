From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: Re: [PATCH] format-patch: avoid generation of empty patches
Date: Sat, 10 Jan 2009 10:01:00 -0600
Message-ID: <d77df1110901100801s463bb43bt701a95df14f167d8@mail.gmail.com>
References: <1231536787-20685-1-git-send-email-nathan.panike@gmail.com>
	 <7vmye0yohu.fsf@gitster.siamese.dyndns.org>
	 <20090110113642.GA25723@myhost> <20090110113903.GB25723@myhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Alexander Potashev" <aspotashev@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 17:02:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLgIB-0004ZA-In
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 17:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbZAJQBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 11:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752367AbZAJQBE
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 11:01:04 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:56846 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbZAJQBD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 11:01:03 -0500
Received: by yx-out-2324.google.com with SMTP id 8so3175105yxm.1
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 08:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=zcWqzoWbMPoAKPtZZfTqFTJeFqtGPhgouajfIYmR5Ak=;
        b=E2pNSbLmmgiuxbtc7ukOmtVwFVX+qw8PRTVFZ2JwaWYO2/RAFjFeIza7fjEyEuTZeu
         ZpzE0Zr/9vJkJlJl4QvGkzc60s1Rjdmxn9EjSAxKF40Oi6jbKdNzHy3Vt95upR4FWFEi
         zAurIaXid79N6wSvA5laLvKSxSVjVma4/2jA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=PPI1PbpZHP6O+6ExtFjpVA83dmaUNPT9kLxVlk61Zqpw37VdDjB1MdPjlZg3k3gYCt
         hjJ/lgXfJ+dQpmQKKS9bLcCXZxWYVOQawVt1+01dB/NMSwt6mNBrYg99Z2PCi0WuigEy
         O0xeFQZKxcStQf+U3HplKirXySjrS9Vb0y+v4=
Received: by 10.90.99.5 with SMTP id w5mr12736819agb.16.1231603261054;
        Sat, 10 Jan 2009 08:01:01 -0800 (PST)
Received: by 10.90.114.9 with HTTP; Sat, 10 Jan 2009 08:01:00 -0800 (PST)
In-Reply-To: <20090110113903.GB25723@myhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105123>

Hi:

On Sat, Jan 10, 2009 at 5:39 AM, Alexander Potashev
<aspotashev@gmail.com> wrote:
...
>
> +               if (!commit->parents && !rev.show_root_diff)
> +                       break;

Do you really want to stop getting commits?  It seems like the break
statement here should be a continue.

Nathan Panike
