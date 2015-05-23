From: Thorsten von Eicken <tve@rightscale.com>
Subject: Re: git status doesn't ignore GIT_DIR directory?
Date: Fri, 22 May 2015 21:41:02 -0700
Organization: RightScale, Inc.
Message-ID: <556004DE.7080504@rightscale.com>
References: <555FD1EA.2060706@rightscale.com> <CAPc5daW2yTHHegPDrEWS5KiSYWZECV+AxMnewzz9ayASB1QNUw@mail.gmail.com> <20150523022256.GA17789@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 23 06:41:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yw1F8-000784-1f
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 06:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbbEWEk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2015 00:40:57 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33726 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbbEWEk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2015 00:40:56 -0400
Received: by padbw4 with SMTP id bw4so34187323pad.0
        for <git@vger.kernel.org>; Fri, 22 May 2015 21:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=eY5BXHG7xoxv+6J6KL/XImhY3Z/HtaOaERas8YpNsQk=;
        b=CgXB9b+7dkxdSdtEEikkshcygnfmOmUY6hyFMO/VfRKdTUgowffhrhWj4niWKtKQC7
         nbf3DhMlTOc2Kzv5JHRBBO431gpvNhbiqdrRwHcDKXzrfo3T009XR9AApaSJQe/eAreE
         WUWbMjfW/yGdWXtTI24FYo1hA9tFfjWiUinOgCiVUyRCgahv/JdRZIM5yymDNxn+GC5y
         DY4l52cQ0hTIn0PA71Inss616KT1ML4zO011sp+LF/NCB7Je/CaDN5H+kaoDp0qZZjpD
         04vAyrReUA/nA1bgT3wjRnNpjTBLiF/JmHCuaC/0e0T6dTUV9bIBizITWGe3jbbuEzDD
         2n1Q==
X-Gm-Message-State: ALoCoQlXlwENOHdoJANCJeVb2H1uzHb4zpxgW6+nMTPz5eTHaY48CKGtmuj4lg/YzGklud8Jlzqq
X-Received: by 10.66.156.198 with SMTP id wg6mr21483215pab.126.1432356055836;
        Fri, 22 May 2015 21:40:55 -0700 (PDT)
Received: from [192.168.0.2] (sb0-cf9a65cf.dsl.impulse.net. [207.154.101.207])
        by mx.google.com with ESMTPSA id af5sm3553552pbc.90.2015.05.22.21.40.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 May 2015 21:40:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <20150523022256.GA17789@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269794>

On 5/22/2015 7:22 PM, Duy Nguyen wrote:
> On Fri, May 22, 2015 at 07:03:48PM -0700, Junio C Hamano wrote:
>> As far as I know, GIT_DIR was prepared as a mechanism to point at
>> another .git directory that does not live inside the working tree, not
>> as a mechanism to rename it to arbitrary name. E.g.
>>
>>  $ git init
>>  $ mv .git .svn
>>  $ GIT_DIR=$(pwd)/.svn ; export GIT_DIR
>>
>> is not expected to work.
>
> ++
> +Note that if GIT_DIR is set explicitly to a directory inside working
> +tree, the directory name must be ".git".
This is not at all what I was hoping to hear, but thanks for the response.
Thorsten
