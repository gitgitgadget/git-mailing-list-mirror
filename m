Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB8602023C
	for <e@80x24.org>; Tue,  5 Jul 2016 10:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754893AbcGEKTv (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 06:19:51 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:33729 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883AbcGEKTs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 06:19:48 -0400
Received: by mail-oi0-f41.google.com with SMTP id u201so222942490oie.0
        for <git@vger.kernel.org>; Tue, 05 Jul 2016 03:19:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Vee9m7KqV7xP8nBJq87uPIZi3p55qHvIAv1YsBFBjAk=;
        b=JgDgyNHQGNH1alaq9ldql3y1NhIdMhX6I1R3pO8Uf7GKNn7tLf2EAJF4xk/0kjE0j1
         3FeQMpjetZ4qZLMH7pMk29K+0lXipZeingcCtPciZYMrbtjWtm/za9fkLaKoicxhhHcD
         omL9rxYb3y/SLLPP8PFKArhmuhlkeUgzN0GJPbgyjZsgtDpVC1CraW2+h7JhYCMhcN8K
         tHOCIyAZTkhH7vnhtFciyIB3E8roNzw7WPRmf49YsN9FAdTiXu1Kib0DCscZGTjGZOA9
         axy9lCxr9tVa0Y+2aN9XNHsil9OK49cHP6jx+InzwEEi3nlT/bA3HieVfDcs9FhwYb1h
         E58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Vee9m7KqV7xP8nBJq87uPIZi3p55qHvIAv1YsBFBjAk=;
        b=j3Hwxvm9M/uDKEjH35tKCC9cBAvzJUFWb5Nc+mNH1Nsv7eQ3WMbxyQ0TLhxGApPfhU
         AqF5JqE67A0eUZYldJF0F5+ZqJ7OWua3fhs78OEF8k0us+IIRRdMjfk/iJENrS7Mq2ow
         5Om8VdKQZmDaCTi0mMx/G5pUk4/wfnRmAux/5la8Fb1F58jfZrBrSOWUtOUirerchI+y
         akn3Ez00utcpDWLFQBkMKiSUyz6PFJ+/TrKXRtpzaS82cJoAlgLIuIppbMuurq0IX79c
         PKFOssjkIN02i3IBMjVbg6SV8lrMo6yI5rVIogab8flQMwYEF05NCwnDOOVxF7UrI50V
         Z/mg==
X-Gm-Message-State: ALyK8tIEbPbhsRrGLLdbUo0vxvpM3VwIGEV4EYAjEwvOu52WFgcTrT0Z9lRIYy1HhAjemLqNtuS+bU+STOX5uA==
X-Received: by 10.202.77.205 with SMTP id a196mr9196397oib.133.1467713987094;
 Tue, 05 Jul 2016 03:19:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.22.241 with HTTP; Tue, 5 Jul 2016 03:19:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1607051200590.8378@virtualbox>
References: <CAKK2_6ezVLd4ZMa4ToKZYq1Ab0Y5w3VJqj_8-BsUCj8Gf8f+ig@mail.gmail.com>
 <alpine.DEB.2.20.1607051200590.8378@virtualbox>
From:	tarun patanwar <patanwar.tarun@gmail.com>
Date:	Tue, 5 Jul 2016 11:19:46 +0100
Message-ID: <CAKK2_6dxO9ckW95PqAFOiAYNwG7uHA0bqcXA2Ev-Xn9z-kyGdA@mail.gmail.com>
Subject: Re: GIT Integration with Siebel
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Johannes,

Thanks for getting back.

Siebel is a Oracle Product for CRM implementation, just like SAP and
SalesForce. So Siebel as a product provides option to integrate any
third party Source Control tool with it.

Integration between Siebel and Source Control tool is facilitated by
the batch file (srcctrl.bat) which contains configuration details
about Source Control tool. While developers checks in/out their code
into Siebel Server, this batch file gets triggered and invokes Source
Control command line to check in a version into repository.

I'll be happy to provide further information is needed.

Thanks,
Tarun Patanwar
+44-7778471437

On Tue, Jul 5, 2016 at 11:02 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Tarun,
>
> On Tue, 5 Jul 2016, tarun patanwar wrote:
>
>> We are trying to integrate GIT with Siebel 8.1 for source code control.
>> We are not able to progress further since there seems to be no
>> documentation available for the same.
>
> Would you kindly explain what Siebel is, and what purpose the batch file
> you want to adapt is supposed to serve?
>
> Ciao,
> Johannes
