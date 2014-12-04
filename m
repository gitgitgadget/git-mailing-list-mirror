From: Stefan Beller <sbeller@google.com>
Subject: Re: Our cumbersome mailing list workflow
Date: Wed, 3 Dec 2014 18:03:40 -0800
Message-ID: <CAGZ79kbV8hjnE1tyPdmwZTcrd4WfOu6gSOYvAqnF_bykL2j8Sw@mail.gmail.com>
References: <1416423000-4323-1-git-send-email-sbeller@google.com>
	<1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
	<546F4B5B.2060508@alum.mit.edu>
	<xmqq61e81ljq.fsf@gitster.dls.corp.google.com>
	<5473CD28.5020405@alum.mit.edu>
	<221286D608764D5EA342E08097333279@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Dec 04 03:03:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwLlh-0005to-7N
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 03:03:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbaLDCDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 21:03:41 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:50958 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbaLDCDl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Dec 2014 21:03:41 -0500
Received: by mail-ie0-f176.google.com with SMTP id tr6so14946462ieb.21
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 18:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=TIoGQMQx62VMU2d/jirNjqW26HNjuytqaQ2Q57ujRug=;
        b=BtXudetpaRUE1rJIIWqd3jumfIbDK+vtVRnQLt56tgpT3uJfSdnaQNxYDZrWBG6iqA
         GqeR9bUqfWO6lU9zKhHbew0wpaW93hLnV0vCriusitUL70NWcBzdrNLwxVJ7tflsf4Y9
         BSUzgy1ZNrkFuW2oFvwVaEvDGbVImWmSWZVTsCjRpIGwMTF3GyUFLWsPW0DygR1RLmQZ
         zbXEZrStUvrzqsKT7ds+vqTj4yHz3fMXKMEpIz2tyykARxtgJJ/tsKHJAxro/z/Gjv/c
         IvmxMIEHASbKhZWRjq2eltJBsTvs1IJaktcLKws3caygC8Q8ggkdnWlcgHoMQptH2wfH
         kiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TIoGQMQx62VMU2d/jirNjqW26HNjuytqaQ2Q57ujRug=;
        b=MXVOcDr0SrlFmPYMeOi9IAeYapdTjQhImo2oa7vMddz2jpjlPePbsSP/BJtmCgPifS
         ge6beiHEMYeVg5BboCvdtmSa6IYYFXiEwQoUu/XsF7eDIXJg2hzgUgoqEVJvIKrFhs8/
         k2HrilGyGyz9KmZ7I4yG4ZFpN974skxyLliVJ9P52CwHgjHkWxCu+Gd/PEWoiR072YdC
         63td9oAcwmK7EBeOm3gNETd+uGaHhsGfH3WOl1HmjXUXl/3dA4QW5rvqZz5hmkRvvkRr
         hTfreSr0fC+t/Xbp4nvDKgS4GQ76TvCtHrGeJVu3RaKRXjFYM4dkpBxinI8k6HToxdnc
         oZ9Q==
X-Gm-Message-State: ALoCoQkCgCPWGJKqXgcC1r4Xat7lKSNrB3opPUuQTUE8/aymuIXCTwdDBM7h/lf2zFnvhnlzl+Pj
X-Received: by 10.107.7.91 with SMTP id 88mr7791694ioh.70.1417658620343; Wed,
 03 Dec 2014 18:03:40 -0800 (PST)
Received: by 10.107.1.199 with HTTP; Wed, 3 Dec 2014 18:03:40 -0800 (PST)
In-Reply-To: <221286D608764D5EA342E08097333279@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260720>

>  Editing text files isn't that hard, we do it all the time.

It is not indeed. But doing it all over again and again is hard and error prone.
I did re-read the man page on git format-patch and found the --notes
option, which I am going to try
to use in my workflow. That way I only need to update the notes
instead of redoing them all the time.
By redoing it I mean copying the changelog from the last time I sent
the patch and adding new entries.

> My thought was that while the cover letter and series version number are currently stripped out from the start of the series, they could be added back as a supplemental commit at the end of the series (an --allow-empty commit). This could contain all of the patch subject lines and their post '---' notes as appropriate.

This sounds interesting. The only changes I can see here are the
referenced message ids, so it would be worthwhile to have the last
patch sent out first and all other patches 1..n-1 referencing the last
empty commit.
If additionally the numbering is corrected, the reader of the mailing
list would not notice any difference to the status quo, just the
sender would have the convenience to be able to track the cover letter
as an empty commit on top of a series.
