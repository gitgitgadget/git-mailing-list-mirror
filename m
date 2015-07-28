From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 03/11] ref-filter: add option to filter only branches
Date: Tue, 28 Jul 2015 22:12:45 +0530
Message-ID: <CAOLa=ZTkSDqgTYH1fmcGssSPbkbr8RN3zGMrbZPx9pWQCfs+9A@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> <1438066594-5620-3-git-send-email-Karthik.188@gmail.com>
 <vpqio94wgf9.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jul 28 18:43:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK7yK-0007Lx-7H
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 18:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbbG1QnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 12:43:16 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:34715 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbbG1QnP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 12:43:15 -0400
Received: by obre1 with SMTP id e1so88750277obr.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 09:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kwGe6kECTO+gtgX0OoF/fjuFg7CfFKPPbKTUmhKQF20=;
        b=tj6W+Nh8bKXtjodknvbKLILhp8sTjjP9AdCyk5EgbvoghanNYXU3LW6VqWt53AFHAi
         WHiGw2ssp22E1mxpSC5/5OssRCFPNxV/eD2yzbaUNmOTW2nBIwJc2boAQSU6W9yHDnG2
         84jYMIsMRCsSIhXcmK9/ghJ58cmKDFvBymM66/Ve9FcNoxCT7UJOnydFdeOv8BwGANpe
         iaP1+bazREOPmAZabSWhFrslFVGlCKMds1S8R7ZAP/W02SeExYnW8gbJfFvf1VUr2sr5
         dPvtSCOADTnqsDlFruLT+4OlFUDaG/QsNjK7LwXcBu+qtZj41SpMULs3Ue49bEqDhWIs
         G6jA==
X-Received: by 10.182.153.161 with SMTP id vh1mr34622613obb.34.1438101794742;
 Tue, 28 Jul 2015 09:43:14 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Tue, 28 Jul 2015 09:42:45 -0700 (PDT)
In-Reply-To: <vpqio94wgf9.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274788>

On Tue, Jul 28, 2015 at 7:08 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +static int filter_branch_kind(struct ref_filter *filter, const char *refname)
>> +{
>> +     int kind, i;
>> +
>> +     static struct {
>> +             int kind;
>> +             const char *prefix;
>> +     } ref_kind[] = {
>> +             { REF_LOCAL_BRANCH, "refs/heads/" },
>> +             { REF_REMOTE_BRANCH, "refs/remotes/" },
>> +     };
>
> Nit: I would swap the order of fields, to make it a bit clearer that
> this is a kind of dictionary key -> value (I think it's more common to
> write it in this order than value <- key).
>

This was borrowed from branch.c, but ok will change it!
Thanks


-- 
Regards,
Karthik Nayak
