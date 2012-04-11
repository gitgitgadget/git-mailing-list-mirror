From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: GSoC - Some questions on the idea of
Date: Wed, 11 Apr 2012 11:44:23 -0500
Message-ID: <4F85B4E7.7090603@gmail.com>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com> <CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com> <loom.20120328T131530-717@post.gmane.org> <CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com> <20120330203430.GB20376@sigill.intra.peff.net> <CA+M5ThR6jtxqs0-Kz-8fcRuOFRbLr-GvsJcTmrOQ7_geNspDLg@mail.gmail.com> <4F76E430.6020605@gmail.com> <4F772E48.3030708@gmail.com> <20120402210708.GA28926@sigill.intra.peff.net> <4F84DD60.20903@gmail.com> <20120411060357.GA15805@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Sergio Callegari <sergio.callegari@gmail.com>,
	Bo Chen <chen@chenirvine.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 18:44:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI0en-0000RZ-Bc
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 18:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760651Ab2DKQo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 12:44:26 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:50449 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755781Ab2DKQoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 12:44:25 -0400
Received: by obbtb18 with SMTP id tb18so1432325obb.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 09:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=9s/gKdjA2CThsQb+XeGaUhI/q3zL6GUjO9E32PdRqic=;
        b=OucH0uYwSvF+/RLJOtcEiTY5E/19pQ9/T/t0K0rV9D/He5gb98BeYjqpLGf9COZXrU
         I8ASgVi64pzZ9R+5iR5OOeXYBUQsrQO0RWE3ic3X7Ci1T1/Y2/qlb5357kojcvZeOJqd
         2MS4OJ5bj62B3d2jdKKz0nEkfIfqapjUJ54B7PMy+e2rJwQg5fx2hy4ROsX6FB6wQb9D
         XzqNDjcdVxJNWAbaR7XuGSnfa7xg/8scMFlfdFnEOeUfTM/5rHpBc/ujmaY0kkNI+7v2
         3U5PlmVzuNDj+qZO59C6/LrQEkd/ExOln9lwWMmiZgXwMsoba7Y5CWLDEZkpNplb738b
         y9vw==
Received: by 10.182.177.99 with SMTP id cp3mr9510791obc.28.1334162665201;
        Wed, 11 Apr 2012 09:44:25 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id r8sm2738298oer.6.2012.04.11.09.44.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 09:44:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <20120411060357.GA15805@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195208>

On 4/11/2012 1:04 AM, Jonathan Nieder wrote:
> Neal Kreitzinger wrote:
>
>> Maybe small binaries do xdelta well and the above is a moot point.
>
> If I am reading it correctly, diff-delta copes fine with smallish
> binary files that have not changed much.
>
> I would suggest tracking source code instead of binaries if
> possible, though.
>
I suppose the original "source" in git (linux kernel) was so low level
that it had no graphics files.  However, most projects are end-user
projects and have graphics so I would think that tracking them is a
normal expected use of git to version your software.  If you're going to 
do that then there shouldn't be a problem tracking other binaries that 
are static constants across all servers (as opposed to user edited 
content like databases).  I would consider this subset of "binaries" to 
be the expected domain of git revision control for software, ie, gui 
software.  Graphics files for your app are "source".  The binary is all 
you have.  It's the "source" that you edit to make changes.

Maybe I'm missing something here.  Maybe graphics files are "container" 
files and that makes them a problem.

v/r,
neal
