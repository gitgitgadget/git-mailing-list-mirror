From: David Barr <davidbarr@google.com>
Subject: Re: Objects deleted before first commit
Date: Tue, 14 Jun 2011 23:06:58 +1000
Message-ID: <BANLkTik1jTq6otRvHwbo342oH7Dwy+vs_w@mail.gmail.com>
References: <8269100C7056D24A91B672AF7E5E48492D959E@exchange.GottexBrokers.local>
	<BANLkTikSPNVbGFRUVh5eSFsxabVWT7SVVA@mail.gmail.com>
	<8269100C7056D24A91B672AF7E5E48492D95BB@exchange.GottexBrokers.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Edmondo Porcu <Edmondo.Porcu@gottexbrokers.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 15:07:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWTKn-00046L-3R
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 15:07:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743Ab1FNNHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 09:07:04 -0400
Received: from smtp-out.google.com ([216.239.44.51]:3683 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab1FNNHC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 09:07:02 -0400
Received: from kpbe11.cbf.corp.google.com (kpbe11.cbf.corp.google.com [172.25.105.75])
	by smtp-out.google.com with ESMTP id p5ED7087001487
	for <git@vger.kernel.org>; Tue, 14 Jun 2011 06:07:00 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1308056821; bh=JvVCqpYqyi5TIw1FM11r6CMLdfI=;
	h=MIME-Version:In-Reply-To:References:Date:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	b=n5cVLGabesfP9vPbuH81HNZv/ISBV5IM8RhzVtmuRUL36ectbAljN9RiSVPJPHZYI
	 JcsXLk0FY0sGmhMuWaJuQ==
Received: from yic15 (yic15.prod.google.com [10.243.65.143])
	by kpbe11.cbf.corp.google.com with ESMTP id p5ED6xxq001590
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Tue, 14 Jun 2011 06:06:59 -0700
Received: by yic15 with SMTP id 15so3904406yic.40
        for <git@vger.kernel.org>; Tue, 14 Jun 2011 06:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=l6vD099NV+O7i/VpaQKXyhK4VwzdOqSG0/s25p1XuHA=;
        b=UzzzJmzyO1lyNBlFzuYkGc0aQyrxYmk70d6SC/I4vEGtxoIPmZWF5COZ4Sxtf/gaJ/
         cI6cCtG6W0th1fzJI3zg==
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=lIbr9l6OqaquSErXQdJvtv+76/SqLqKkaeIquxXmdz4m7j80Oe3oYQtJOg0/N4rKo+
         QDOJ912K0kQRwzmQeEiw==
Received: by 10.101.157.19 with SMTP id j19mr6621425ano.113.1308056819009;
 Tue, 14 Jun 2011 06:06:59 -0700 (PDT)
Received: by 10.101.29.2 with HTTP; Tue, 14 Jun 2011 06:06:58 -0700 (PDT)
In-Reply-To: <8269100C7056D24A91B672AF7E5E48492D95BB@exchange.GottexBrokers.local>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175768>

On Tue, Jun 14, 2011 at 11:00 PM, Edmondo Porcu
<Edmondo.Porcu@gottexbrokers.com> wrote:
> In fact I have some folders and files there, but I have no idea on how to restore them into "Real Files". I am using windows 7 unluckily, but I have managed to find the files. This is an extract of my git fsck:
>
> dangling blob 43cb00bb9f23b73afc874c4105b136f8c426e4a5
> dangling blob 48ef642adb1549ee1d4040ec9337d3a47c19d422
[...]

Was it 'rm -rf' or 'git rm -rf'?
If just the non-git command, maybe 'git checkout -- <missing paths>'?

--
David Barr.
