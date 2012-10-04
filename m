From: Andrew Wong <andrew.kw.w.lists@gmail.com>
Subject: Re: Bug report
Date: Thu, 04 Oct 2012 11:21:54 -0400
Message-ID: <506DA992.7090904@gmail.com>
References: <506D122E.2050404@emsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Whitney <jjw@emsoftware.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:28:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtaW-0001w8-R7
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422768Ab2JDPWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 11:22:05 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:55739 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422747Ab2JDPWA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 11:22:00 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so231813iag.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 08:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=NT+KFDI1Ik9E/XIj2hvtPjMVDXBMdr96letgTsmOCdU=;
        b=QpySMWnpstM0e0XEcIjg6smUr1fxnqaxzzT9+lMb8E7J1E4q2uf5mbdmgh7kuk8Afj
         xJ0P+AeueJn+L8jAlI/rfGsdaLIzUoennCOjSlZpxapLrGqFUGFbfsiwbGwXdW2qaOGK
         RBkx/3rMb0Ycl4LpeYfHsZSU9nX6J/h1WH1hc5LDJRIMTV7v1P9EEWf473m3GP0YPeDx
         WCqdm3dy7pAh4QtRqOk1x/bJYF84EiArN8R35ZRl15PNz/zzz/4XERzCufIVtndPYyuU
         zpI4rHjq8MHhORnR8DAgw6/tYvWN7sA0d/yFY8IY1lyd6BGekuGctQywAh1rjljBfuNr
         Qrrw==
Received: by 10.50.163.39 with SMTP id yf7mr5580899igb.30.1349364119017;
        Thu, 04 Oct 2012 08:21:59 -0700 (PDT)
Received: from [192.168.1.112] ([66.207.196.114])
        by mx.google.com with ESMTPS id ex1sm13658381igc.4.2012.10.04.08.21.54
        (version=SSLv3 cipher=OTHER);
        Thu, 04 Oct 2012 08:21:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <506D122E.2050404@emsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207003>

On 10/04/2012 12:35 AM, John Whitney wrote:
> I just ran into a problem that I'm pretty sure is a bug in git. Just 
> read and run this (fairly trivial) shell script to replicate.
I tried your steps on a Mac, but I wasn't able to produce the issue. 
Perhaps I don't have the right CRLF configs to trigger the issue. I've 
tried it on v1.7.9.6, which came with Xcode, and v1.7.7. What git 
version are you using? And, if any, what are your configs for 
"core.eol", "core.safecrlf", and "core.autocrlf" ?

What Phil said also makes sense though.
