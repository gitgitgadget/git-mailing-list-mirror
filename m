From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/2] send-email: add tests for refactored prompting
Date: Tue, 31 Mar 2009 10:36:04 -0400
Message-ID: <76718490903310736r41acc92cg9b09aff902f9850e@mail.gmail.com>
References: <1238290751-57461-1-git-send-email-jaysoffian@gmail.com>
	 <1238290751-57461-2-git-send-email-jaysoffian@gmail.com>
	 <20090331103303.GD3307@atjola.homenet>
	 <76718490903310707s75e24e39l63f0d396f60a0583@mail.gmail.com>
	 <20090331141937.GC14611@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 31 16:38:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lof6l-0002ZB-Oi
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 16:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759203AbZCaOgL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 10:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755430AbZCaOgJ
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 10:36:09 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:50579 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbZCaOgI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 10:36:08 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2457152ywb.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 07:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9Q8WsGFFAHx/5Y6WtyX95EKO/7WRfX0Ls63LLdY5IMY=;
        b=wWOl4/zK/ep06tnSeqxicxWI4BgLI7TjEA4oDuk1XyG73gttQ8h5X7gKqd3IKaNEv5
         QS9U5ONSsZRJj3hSukFK/lBK6p3/ekJ3r8nA6Eg2oHvyJ09Hb98su9xlHSBLUeGgoOtp
         i5hEnUWuIviqHCFZdIiIlRX1S2gsJA1OprBck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=chQVp/OaF9hgOG5J++Fp7AZH2RZxzu4PaN9f2r0EeNEEbtsd0ynn6MZk/MBvDLKN3I
         zpuIYhOtAx3GP3B+PAg8YnKuvBfd44vyv1TbyDYaUxBwj9M/wBB1QLAsfvHo6e2Mko8O
         kKym1ypLI5s9MgX7Xz3mhYKh8+F9PmkSaRg+U=
Received: by 10.151.141.16 with SMTP id t16mr12416356ybn.131.1238510164956; 
	Tue, 31 Mar 2009 07:36:04 -0700 (PDT)
In-Reply-To: <20090331141937.GC14611@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115264>

2009/3/31 Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>:
> Yep, after fixing the linewrapping and restoring the tabs, this works=
=2E

Thanks (sorry about the formatting, gmail...).

> Debian sid, kernel 2.6.29, dash as /bin/sh

dash seems to be a good lowest common denominator. I'll try testing
with it from now on.

j.
