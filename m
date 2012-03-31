From: Martin Fick <mfick@codeaurora.org>
Subject: Re: [PATCH 3/3] revision: insert unsorted, then sort in prepare_revision_walk()
Date: Sat, 31 Mar 2012 16:36:04 -0600
Message-ID: <2e914933-a57d-4d16-a1ba-37f6f4365606@email.android.com>
References: <201203291818.49933.mfick@codeaurora.org> <7v7gy2q1kq.fsf@alter.siamese.dyndns.org> <60bff12d-544c-4fbd-b48a-0fdf44efaded@email.android.com> <20120330093207.GA12298@sigill.intra.peff.net> <20120330094052.GB12298@sigill.intra.peff.net> <4F7780F5.3060306@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 01 00:39:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SE6x4-0003Fl-Lq
	for gcvg-git-2@plane.gmane.org; Sun, 01 Apr 2012 00:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753833Ab2CaWjN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Mar 2012 18:39:13 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:32162 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819Ab2CaWjL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 18:39:11 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6666"; a="177733128"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 31 Mar 2012 15:39:11 -0700
Received: from [192.168.1.160] (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id E703410004AB;
	Sat, 31 Mar 2012 15:39:10 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <4F7780F5.3060306@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194469>



"Ren=C3=A9 Scharfe" <rene.scharfe@lsrfire.ath.cx> wrote:

>Speed up prepare_revision_walk() by adding commits without sorting
>to the commit_list and at the end sort the list in one go.  Thanks
>to mergesort() working behind the scenes, this is a lot faster for
>large numbers of commits than the current insert sort.

Thanks for these Ren=C3=A9, I will see if I can try them out on Monday!

-Martin

Employee of Qualcomm Innovation Center,Inc. which is a member of Code A=
urora Forum
