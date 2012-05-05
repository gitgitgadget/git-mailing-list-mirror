From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] completion: add new _GIT_complete helper
Date: Sat, 5 May 2012 12:44:11 -0500
Message-ID: <20120505174410.GA17937@burratino>
References: <1336231400-6878-1-git-send-email-felipe.contreras@gmail.com>
 <20120505155423.GA14684@burratino>
 <CAMP44s1dhAjKt3mxVmg2+0qp-QTyjYb1knhxf+m177Cg2ZBC1Q@mail.gmail.com>
 <20120505164736.GC14684@burratino>
 <CAMP44s2NRMxuvQXk4RyqFYR=oQw_vrJhmbdwtXsrg=eHhGBS2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 19:45:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQj2V-0000Eq-W1
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 19:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757548Ab2EERon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 May 2012 13:44:43 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64954 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757509Ab2EERoU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2012 13:44:20 -0400
Received: by obbtb18 with SMTP id tb18so5710010obb.19
        for <git@vger.kernel.org>; Sat, 05 May 2012 10:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=hFO/Fy3hAx6LwSrVQyhy4glmQrd8+WHB9dNWbEUfr0Q=;
        b=kvdstVxEt+9R3XmPXThVBDCDv3WGnub6XMymZmNF7rzIHrMe5/Tz+J+a5NA8VkAKjf
         cwmHg5PrXOTg4jqC521ZYAtdVq0fBWM5zJxKKnhsl5UwVF+q3bGScolcwPRB9e8Eb+3v
         kJoorLZm/QDKWpcjYu5xpVkvmGNc7mPYqiftWjGbu5DFalJvNrEngCcLZtZexD99WLdm
         brFTMS5NEBAk0RFkdRtdkgiGsyBkckQRJ9QYYsiMUcB9tfQ2T4EtRwbOy/dWQV2FQfzs
         TC/QfnwYL1aZYRVPxrhDLUfPB/+Oxescl7J6trss2wH5SD6phwMgIxViSqj4ge3JLV3x
         wPeg==
Received: by 10.50.186.233 with SMTP id fn9mr5397964igc.46.1336239860143;
        Sat, 05 May 2012 10:44:20 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id re5sm2045116igb.0.2012.05.05.10.44.18
        (version=SSLv3 cipher=OTHER);
        Sat, 05 May 2012 10:44:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s2NRMxuvQXk4RyqFYR=oQw_vrJhmbdwtXsrg=eHhGBS2w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197130>

Felipe Contreras wrote:

> This is what I propose:
>
> 1) We name the new function __git_complete; this would be a temporary
> name, the function would not be meant to be public
> 2) We discuss later what would be the namespace for public functions,
> and rename, or add wrappers for them (e.g. _GIT_ps1, _GIT_complete)
> 3) We standardize the odd functions: __gitdir -> __git_dir

Sounds excellent to me.

Thanks,
Jonathan
