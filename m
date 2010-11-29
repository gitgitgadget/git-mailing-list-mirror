From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] rebase: pass --signoff option to git am
Date: Mon, 29 Nov 2010 14:57:53 -0800
Message-ID: <ADC46761-DFF5-486D-B604-05BA8C8631EB@sb.org>
References: <1290856542-6070-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 23:58:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNCfk-0001dV-2y
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 23:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755312Ab0K2W55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 17:57:57 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:34240 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755175Ab0K2W54 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 17:57:56 -0500
Received: by pva4 with SMTP id 4so783854pva.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 14:57:56 -0800 (PST)
Received: by 10.142.164.13 with SMTP id m13mr6229960wfe.140.1291071475874;
        Mon, 29 Nov 2010 14:57:55 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id v19sm8091726wfh.0.2010.11.29.14.57.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 14:57:54 -0800 (PST)
In-Reply-To: <1290856542-6070-1-git-send-email-giuseppe.bilotta@gmail.com>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162445>

On Nov 27, 2010, at 3:15 AM, Giuseppe Bilotta wrote:

> This allows people (like me) that forget to sign off their commits to do
> a single rebase pass e.g. while preparing the patchset for submission.

You're probably already aware, but git format-patch supports the -s/--signoff
flags to sign off commits as they're prepared. There's even a config var
you can set to make this the default (format.signoff = true).

-Kevin Ballard
