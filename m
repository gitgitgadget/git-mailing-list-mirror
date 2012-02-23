From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.7.9.2
Date: Thu, 23 Feb 2012 17:06:47 +0530
Message-ID: <CAMK1S_iKPDWYBVDgHNRvwhbJ+Cy9NdJP+2pa8JOst1vKDs3gCA@mail.gmail.com>
References: <7vbooq6zq2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 12:36:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Wyk-0006NF-Al
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 12:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681Ab2BWLgt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Feb 2012 06:36:49 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:46811 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752536Ab2BWLgs convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 06:36:48 -0500
Received: by obcva7 with SMTP id va7so1277799obc.19
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 03:36:47 -0800 (PST)
Received-SPF: pass (google.com: domain of sitaramc@gmail.com designates 10.60.26.133 as permitted sender) client-ip=10.60.26.133;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of sitaramc@gmail.com designates 10.60.26.133 as permitted sender) smtp.mail=sitaramc@gmail.com; dkim=pass header.i=sitaramc@gmail.com
Received: from mr.google.com ([10.60.26.133])
        by 10.60.26.133 with SMTP id l5mr322093oeg.22.1329997007778 (num_hops = 1);
        Thu, 23 Feb 2012 03:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=AsmDp3vIf1gP4Sz/lOZBls1loUrdhyq64BaC9tMWKrQ=;
        b=H2BHFRGOHb7RdasmA4jQfbhKFIFQ8OqreU8kbXuzy0H7vQsOtdoFtI1rMNbhHWxcxR
         rfIeyl3tt7Gz0KT/PZUux2Zd99K9xTtXhAiV7VuldcTDn4QmMRtFBTY17yYVb0OpFaaj
         0CHG3nvaf6Y2X5MEkPzKJZWmlfcUaMBP7tT7E=
Received: by 10.60.26.133 with SMTP id l5mr284114oeg.22.1329997007743; Thu, 23
 Feb 2012 03:36:47 -0800 (PST)
Received: by 10.182.175.106 with HTTP; Thu, 23 Feb 2012 03:36:47 -0800 (PST)
In-Reply-To: <7vbooq6zq2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191354>

On Thu, Feb 23, 2012 at 8:08 AM, Junio C Hamano <gitster@pobox.com> wro=
te:

> =C2=A0* "git rev-list --verify" sometimes skipped verification depend=
ing on
> =C2=A0 the phase of the moon, which dates back to 1.7.8.x series.

phase of the moon?  should have been named --were-ify I guess :-)
