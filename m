From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Log messages beginning # and git rebase -i
Date: Wed, 29 Jul 2015 10:02:22 -0700
Message-ID: <xmqqegjqaodd.fsf@gitster.dls.corp.google.com>
References: <loom.20150727T133256-715@post.gmane.org>
	<CAPig+cRT6=YCHz+phfE+84y27ey-6ScjPxP2cHiVqumJmR6mOw@mail.gmail.com>
	<loom.20150728T115023-269@post.gmane.org>
	<vpqsi88qp6q.fsf@anie.imag.fr>
	<xmqqr3nsfdmw.fsf@gitster.dls.corp.google.com>
	<vpq3808p40o.fsf@anie.imag.fr>
	<CACsJy8ABsHBA1TubB+6fypT0LGQF_O+CmHPqL+C7nMVjjWy38w@mail.gmail.com>
	<vpq8u9zjgzl.fsf@anie.imag.fr>
	<xmqqvbd39cxj.fsf@gitster.dls.corp.google.com>
	<vpqmvyfeysc.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>, Ed Avis <eda@waniasset.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 29 19:02:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKUkP-00082r-O9
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 19:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbbG2RCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 13:02:25 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:32821 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062AbbG2RCY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 13:02:24 -0400
Received: by pdbnt7 with SMTP id nt7so9001710pdb.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 10:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Cs1g0hTlfbYBN/+5jFwb6LkA+reCXMrWhQVSqqEhhnc=;
        b=ARPKBsRDeBhGbX+Lt9+WlNHZjIg71JovCFfgInp8bNvJUEO3fkqz7y3SCjfNAfLEnp
         2NtfREmS0QnqPifC3YsDDfdEFNkz0clwOy4BzbIJJUn01fReCJhS1CI3g0cV8Z2r0atA
         O5vTmLJwO95EhFGKwIbsfE8f50opMOy/xEyhHMreoIgvv1VlNdDwOWkJr+7H31oKXyRS
         uGvTZR/Oz0thQTxQlCzVyqxE4U2GvDesSKfdeQs70xLXi+nXMkinzMp5id8N2LoBBptR
         +i+RhxGc+j445bt0kJT2Z/FtvryVUMHc1XVgNSbfAZWyO389tb1N9Iq04bs4wbit9J8D
         tYSQ==
X-Received: by 10.70.129.44 with SMTP id nt12mr96586288pdb.116.1438189344205;
        Wed, 29 Jul 2015 10:02:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c0b:2701:e242:17dc])
        by smtp.gmail.com with ESMTPSA id i5sm42024798pat.42.2015.07.29.10.02.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 29 Jul 2015 10:02:23 -0700 (PDT)
In-Reply-To: <vpqmvyfeysc.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	29 Jul 2015 18:03:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274922>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Then, as you say, it is up to the user to remove things that Git has
> added. Why would we ask the user to do this when we have a way to have
> the tool do it?

The timeline of development, perhaps?  I thought cleanup=scissors was
a fairly recent invention that hasn't been used widely yet.
