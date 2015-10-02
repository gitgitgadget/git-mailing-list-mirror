From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question - List current hashs of branches
Date: Fri, 2 Oct 2015 11:58:54 -0700
Message-ID: <CAPc5daX3Vch61Rb0=Htfx2uJcuCxyznnWFQ54uqhpATFG3KL8g@mail.gmail.com>
References: <0F7E16B8B216214784C1BD8596C189CA09176151@DEMUMBX012.nsn-intra.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Golarits, Zsigmond (Nokia - HU/Budapest)" 
	<zsigmond.golarits@nokia.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 20:59:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi5YB-0002sa-MA
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 20:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbbJBS7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 14:59:17 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:34857 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbbJBS7P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 14:59:15 -0400
Received: by igbkq10 with SMTP id kq10so23891129igb.0
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 11:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=U5HqK7H2W2ag1JVfIJrbFDfGrKvE86EqcYCFlMTXXGE=;
        b=LNErp+U5fwdxoVg9Yuxh38nX0HJCdVHpz5rmvmn1oi9AyIl5RxUBYVRwy85V08b9uH
         SD1byUYUre7LIUnn7FCOX9m2E1eHOKyZW3Yvh3wEom1GCM9ECNzwopHcoXRKqqYnsKy+
         o0rgtX7NDCr51A+IMPbwYLe8sXQvI0YjUBzzpdLCGTvNP6p566ctG9luJBUerY9JOhzu
         54icgyi7694T2YjA+qqERGlWf1jui72iL7BnxFwEFievH4cco9cMrIBdyNO19OWQ4w4p
         QnshRq74AdaBM6CjbBjLc4w4urWCxgzad3QDqPMBIOCgbO2JFWOTfJzBIdRpjDv/QZ1Y
         vNGQ==
X-Received: by 10.50.134.161 with SMTP id pl1mr584151igb.60.1443812354260;
 Fri, 02 Oct 2015 11:59:14 -0700 (PDT)
Received: by 10.36.79.84 with HTTP; Fri, 2 Oct 2015 11:58:54 -0700 (PDT)
In-Reply-To: <0F7E16B8B216214784C1BD8596C189CA09176151@DEMUMBX012.nsn-intra.net>
X-Google-Sender-Auth: UEGA4svHFNv8lt1AsaFVmyomxyM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278940>

for-each-ref & ls-remote?

On Fri, Oct 2, 2015 at 11:54 AM, Golarits, Zsigmond (Nokia -
HU/Budapest) <zsigmond.golarits@nokia.com> wrote:
> Hello,
>
> How can I get the current commit-hashes of the remote and local branches without check them out?
>
> Br,
> Zsigmond Golarits
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
