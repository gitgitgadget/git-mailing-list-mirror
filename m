From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: GSoC 2012 application process
Date: Fri, 2 Mar 2012 21:52:12 +0700
Message-ID: <CACsJy8CVNS3Ar=TKYbyy7mTxF7G2rny_CSZrU9m+jmY=N0=DNg@mail.gmail.com>
References: <20120302091114.GA3984@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 02 15:52:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3Tqj-0001nC-DM
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 15:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757838Ab2CBOwo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Mar 2012 09:52:44 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47028 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755225Ab2CBOwn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Mar 2012 09:52:43 -0500
Received: by wgbdr13 with SMTP id dr13so1653297wgb.1
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 06:52:42 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.104.65 as permitted sender) client-ip=10.180.104.65;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.104.65 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.104.65])
        by 10.180.104.65 with SMTP id gc1mr938227wib.13.1330699962431 (num_hops = 1);
        Fri, 02 Mar 2012 06:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=JXoTtlQ0jrxvZkYnrPvUIZ1pdah4bKyqyy9OpujisxY=;
        b=tTGHerMu3Cn2qFexkb4qG/QfT/IpF5sLWhkFl+ouuYgqMLy/SNHEEkoRIfR29ttCr8
         opxRcxVR49fJntA1EVnos9ryaMLZW27BKu5N2xSoKVQSZNtagm3TBc+AA8vKBdDOzu6B
         L8h6Do+Xs8SQkVdYgDKbY3qiv9E0oI/ib0rrA7dMBU2Gx5A4UHrLxWjOmFzEr8Ow5cQO
         OqdW9cbMuyycmxJVU0dGAODyPvK6kmOGXUE5CsCvgkE8PRK4d2OZh5Q68C0j4D2Eo61e
         N+hCrb0sILjFAlnmBJkQsprUSAek6iQ+vJkfix/cvtx7LjBe5cmyHjYnnTr/y1v4QiWs
         htGw==
Received: by 10.180.104.65 with SMTP id gc1mr741564wib.13.1330699962270; Fri,
 02 Mar 2012 06:52:42 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Fri, 2 Mar 2012 06:52:12 -0800 (PST)
In-Reply-To: <20120302091114.GA3984@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192047>

On Fri, Mar 2, 2012 at 4:11 PM, Jeff King <peff@peff.net> wrote:
> At this point, we need:
>
> =C2=A02. Project ideas to be added to the ideas page.

The master index to speed up pack access by avoid going through all
pack indices one by one when there are a lot of packs. If building the
master index is cheap, it could take "repack -ad"'s position in "gc
--auto" and delay repacking longer. I think this should be easy to do,
just not sure big enough for gsoc.
--=20
Duy
