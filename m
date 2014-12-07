From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] git-svn: propset support v2
Date: Sun, 7 Dec 2014 04:25:26 -0500
Message-ID: <CAPig+cQaP8KUFjFUqvxPZV1KiJePe_KisU4HSfZ1qVATOMriGw@mail.gmail.com>
References: <20141206222918.GA91825@elvis.mu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Eric Wong <normalperson@yhbt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Michael G. Schwern" <schwern@pobox.com>,
	David Fraser <davidf@sjsoft.com>
To: Alfred Perlstein <alfred@freebsd.org>
X-From: git-owner@vger.kernel.org Sun Dec 07 10:25:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxY5t-00007D-GQ
	for gcvg-git-2@plane.gmane.org; Sun, 07 Dec 2014 10:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbaLGJZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2014 04:25:29 -0500
Received: from mail-yh0-f49.google.com ([209.85.213.49]:43821 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659AbaLGJZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2014 04:25:27 -0500
Received: by mail-yh0-f49.google.com with SMTP id f10so1545617yha.36
        for <git@vger.kernel.org>; Sun, 07 Dec 2014 01:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ebOnOLqtJCfSfT68RrurrOxJ+HA813zlCID1wXfY8Ho=;
        b=LDRbRbzbjNeDLcCoXArQSXkXSpZIe0W2umqZsmn2G2JOCdDVoGZ8swuL1lqhsSeX4c
         q/4O5vflfIscICARQIfO2vWKsmdbkA2K7ajle5GhNoMeABrorSOPHlhgK9XRPfiXsCsN
         +OV5s22GiknXh0OA8Tt516eREVC++EAQeTzvbHY/K6s1p/5bM8lFc4A1npu4S3egDzi0
         EhCGpFMBFyxkwxTRlp76X1QFrRFmeqHEv3VHHQrLQranQYMZtdzTfACUE8uVcZN69MMl
         h2yPBM9BsnwmxL14J4fsx8kRz7LNBEQZFPIPqVEaTiDUU4Cf2GaJuM4IKR7V9YnyKIkU
         rfTw==
X-Received: by 10.170.133.5 with SMTP id z5mr29776517ykb.2.1417944326851; Sun,
 07 Dec 2014 01:25:26 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Sun, 7 Dec 2014 01:25:26 -0800 (PST)
In-Reply-To: <20141206222918.GA91825@elvis.mu.org>
X-Google-Sender-Auth: Ttn94f4Yjp4aCRvckM5WLwdXyC0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260979>

On Sat, Dec 6, 2014 at 5:29 PM, Alfred Perlstein <alfred@freebsd.org> wrote:
> I have incorporated Eric Wong's feedback into the git-svn propset support patch.
>
> There is a nit that I want to point out.  The code does not support adding props
> unless there are also content changes to the files as well.  You can see this in
> the testcase.

This is an important nugget of information which would be worthwhile
to mention in the commit message of the patch rather than here as mere
commentary.

> That is still sufficient for many people's workflows (FreeBSD at
> least).  So I am wondering if this is OK.
>
> I would gladly take any pointers to making it work with unchanged
> files either for a later diff or to wrap this up.
