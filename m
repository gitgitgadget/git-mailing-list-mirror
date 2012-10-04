From: Andrew Wong <andrew.kw.w.lists@gmail.com>
Subject: Re: Bug report
Date: Thu, 04 Oct 2012 13:01:52 -0400
Message-ID: <506DC100.5060307@gmail.com>
References: <506D122E.2050404@emsoftware.com> <506DA992.7090904@gmail.com> <506DB655.8020504@emsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Whitney <jjw@emsoftware.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:49:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtdz-00033L-Sk
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933455Ab2JDRBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 13:01:55 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:62340 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932873Ab2JDRBy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 13:01:54 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so280155iag.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 10:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=+Ozua9sNCpjY21tHh2+30Ynif6IXjnqrDoUnjxvqsJc=;
        b=v7w7CwHOcCP+jSicosR2526FISIGX5DmTFkHCy8TZeTaCtUfS7do73IdM3/WXtt0HX
         CcCyXAU9xYKvm3KBcjEuQMLwoH5ZDnBNEq9XK+6S/KvAzoLPlLg1pmRuG469l4pdgoCA
         L/YtGqD3NGyJ7joayw5PC88SL9k0mtM2SQQhjbXMMOFM/PhKjufFwxGphJpqs8y/xr3O
         2o8rCCzQTA3d64blWtwQJW5wF4Js+JK8SCdNdMOeY/wTMq38cPMD8TvOSWOhJj0jJDV1
         WnHIMXpxAQrGnDGL+9BPcgSB+EdQSv8rG3vy7nVMM9txx5HOPe1HuKBMUUGlLsKcCP/y
         1fwQ==
Received: by 10.50.7.232 with SMTP id m8mr5918353iga.48.1349370114177;
        Thu, 04 Oct 2012 10:01:54 -0700 (PDT)
Received: from [192.168.1.112] ([66.207.196.114])
        by mx.google.com with ESMTPS id in10sm6177750igc.14.2012.10.04.10.01.53
        (version=SSLv3 cipher=OTHER);
        Thu, 04 Oct 2012 10:01:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <506DB655.8020504@emsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207028>

On 10/04/2012 12:16 PM, John Whitney wrote:
> This problem occurs on Mac, Windows, and Linux, and
> with multiple versions of git. Note that in my script a CR
> is appended to test.txt. On the Mac, you can generate this
> in Terminal by pressing Ctrl-V Ctrl-M. Or, alternatively,
> just download and run the script like this: "sh git_failure.sh"
Ah, yes. I can reproduce the problem. I was pasting the lines from your 
script. And I saw a new line in the shell when I pasted, so I thought 
the ^M was kept properly. But somewhere during the pasting, the ^M must 
have got translated to a \n automatically. Silly me.
