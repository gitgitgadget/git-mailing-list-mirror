From: Martin Fick <mfick@codeaurora.org>
Subject: Re: [PATCH 0/5] multithread traverse_commit_list (aka rev-list)
Date: Tue, 10 Apr 2012 10:51:55 -0600
Organization: CAF
Message-ID: <201204101051.56288.mfick@codeaurora.org>
References: <1334068771-32725-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>
To: =?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 18:52:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHeIW-0007ed-8v
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 18:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347Ab2DJQv7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Apr 2012 12:51:59 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:54356 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837Ab2DJQv6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Apr 2012 12:51:58 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6675"; a="178069113"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 10 Apr 2012 09:51:57 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 2CDAB10004A9;
	Tue, 10 Apr 2012 09:51:57 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-37-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <1334068771-32725-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195101>

On Tuesday, April 10, 2012 08:39:26 am Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=
=8Dc Duy=20
wrote:
> While this series does not break rev-list (but breaks all
> external commands, I don't care anyway), and it proves
> lock-free pack access works, it does not improve
> rev-list performance. I suspect extensive locking around
> "struct object *" may be the culprit. =20

Or if it is memory contention and your threads share the=20
same cache, it won't help much either,

-Martin

--=20
Employee of Qualcomm Innovation Center, Inc. which is a=20
member of Code Aurora Forum
