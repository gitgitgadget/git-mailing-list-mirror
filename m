From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: git-blame segfault
Date: Tue, 3 Dec 2013 10:04:41 +0100
Message-ID: <CALWbr2yqf2Kd34pFOp5EmSxsj0rN7nV4o6NFYz68CZ-zudULQw@mail.gmail.com>
References: <20131202125748.GA275@x4>
	<CALWbr2w8sRRPJdjnpEwiGYe+T4KnvmRtV2n3yTesz8869q_=zA@mail.gmail.com>
	<20131202150541.GB275@x4>
	<20131203084540.GA276@x4>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Markus Trippelsdorf <markus@trippelsdorf.de>
X-From: git-owner@vger.kernel.org Tue Dec 03 10:05:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnlug-0000Kv-D7
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 10:05:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848Ab3LCJEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 04:04:53 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:49711 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479Ab3LCJEm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 04:04:42 -0500
Received: by mail-pa0-f46.google.com with SMTP id kl14so2670897pab.19
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 01:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Eakk0c9Bdgch9lHWCvKOfz1Rw3G53qCju8GZFOGRheA=;
        b=LKIifEspJW7sULWc53pKiNq4ZpIK6bU+t/hmyxIX3OSH536KzT8E8uS+3g+vEJpbxs
         Fm7Uk4g3FOj8SqirnKwsMDQqqwZQ3cAKezrW2bLlPz4LpThY2mjzPW5oOhgSzb0rivWB
         c+RZgrVOp9W1jaawhwtWXj6HHK3a0AwdhdDhFetyuihMG7VAtwqJlS/aKetnHImqJusn
         ej5c/bwspbgjZjBWg6xUTIA5khT5blGVd3kbRzqcNmU81qOYRiv5/mwGUv4cmb/pLIXI
         Js+GLzLGVWKnsFpo+HFDWZh1BuRNWBV679mexJK9ItI2xQvCfveGGX7k7bxExYrM3DTq
         hLow==
X-Received: by 10.68.254.132 with SMTP id ai4mr37046509pbd.51.1386061481457;
 Tue, 03 Dec 2013 01:04:41 -0800 (PST)
Received: by 10.70.124.227 with HTTP; Tue, 3 Dec 2013 01:04:41 -0800 (PST)
In-Reply-To: <20131203084540.GA276@x4>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238677>

On Tue, Dec 3, 2013 at 9:45 AM, Markus Trippelsdorf
<markus@trippelsdorf.de> wrote:
> Should be fixed in gcc soon. For the curious, here is the assembler diff
> (bad vs. good):

Cool, Thanks. Good to know this has nothing to do with Git :-)
