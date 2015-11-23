From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v6 0/6] Add Travis CI support
Date: Mon, 23 Nov 2015 21:19:16 +0000
Message-ID: <565382D4.5010200@diamand.org>
References: <1447923491-15330-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: sunshine@sunshineco.com, gitster@pobox.com, peff@peff.net
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 23 22:19:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0yW6-0002WW-8J
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 22:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755103AbbKWVTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2015 16:19:15 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37065 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646AbbKWVTO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2015 16:19:14 -0500
Received: by wmww144 with SMTP id w144so327374wmw.0
        for <git@vger.kernel.org>; Mon, 23 Nov 2015 13:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=QVJUXBnQo0yzY8qzZ9lQk/HSJynHn6rhTyRbGTHX0sY=;
        b=S+SxbZA89iRD+PAoJpHC5PwHb7HLUQI6p2GRNSVZvCIU38mu+E4ryRa4K20tjxtWC2
         R4Yqae9kbd64xVQRTT1B4r45yegiC+Q7POZlPT59XMreLqsekcLOXgQk1f69iOmCak7B
         fHEh7VYNhUrxTyQPabXOULSOJRt4Fm9D2Nad4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=QVJUXBnQo0yzY8qzZ9lQk/HSJynHn6rhTyRbGTHX0sY=;
        b=XZiphLy6jyz5InbliB36T6DUyuPlNhPVza8/QOWPrRw6M3T5P7QIPI4UsOEU6VOPCW
         Y92mQf5wY404Lf/M2AVxBWyn9IAINFrYrYQSjCzTC+asAYC7ZutXo8JxDjEg9ACE6DE+
         Xkb8Hja4kHy+MoHFuVrYhT1imxNjlYmaWBliDQGJbnK42nI/Rh3/1N8jVEtlBTz7vh3L
         IJH7z8PE3YxFTikpTqUCgJZ5Nn/F5gDHYpepY6u+y+CWSXzUZV3Ah2GCH98klivhTLCv
         EDtSqYYxXl2mPiEFt62kQCs8yLCUlLgS1J3Po7G+9peS4zBJ7PLKF1+W4okVXDPHwICa
         XJtw==
X-Gm-Message-State: ALoCoQliZkmGnwzl2jY3PSamoX2LR+8cw9/8yKwO6TKwcqVc/aIT4zZmZ997WtTm3Wdiq2X3FQUI
X-Received: by 10.28.101.65 with SMTP id z62mr21888039wmb.84.1448313553296;
        Mon, 23 Nov 2015 13:19:13 -0800 (PST)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id kj3sm15152033wjb.19.2015.11.23.13.19.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Nov 2015 13:19:12 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <1447923491-15330-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281598>

On 19/11/15 08:58, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> diff to v5:
> * check if PID file still exists on P4D cleanup (thanks Luke)
> * fix space/tab formatting error
> * add sleep to timeout loops (thanks Luke)
> * replace 'date +%s' with platform independent Python function (thanks Eric and Luke)

The first three of these (which fix the git-p4 tests) all look good to 
me. With these changes, running the t98* tests in parallel now works, 
which it did not used to do. The changes are not pretty but I think 
that's inevitable.

Ack from me.

Luke
