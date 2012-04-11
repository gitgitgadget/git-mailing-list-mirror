From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: GSoC - Some questions on the idea of
Date: Wed, 11 Apr 2012 11:29:50 -0500
Message-ID: <4F85B17E.4080005@gmail.com>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com> <CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com> <loom.20120328T131530-717@post.gmane.org> <CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com> <20120330203430.GB20376@sigill.intra.peff.net> <CA+M5ThR6jtxqs0-Kz-8fcRuOFRbLr-GvsJcTmrOQ7_geNspDLg@mail.gmail.com> <4F76E430.6020605@gmail.com> <4F772E48.3030708@gmail.com> <20120402210708.GA28926@sigill.intra.peff.net> <4F84DD60.20903@gmail.com> <20120411060357.GA15805@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Sergio Callegari <sergio.callegari@gmail.com>,
	Bo Chen <chen@chenirvine.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 18:30:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI0Qh-0007kQ-4h
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 18:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759665Ab2DKQ3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 12:29:54 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40255 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756811Ab2DKQ3x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 12:29:53 -0400
Received: by yenl12 with SMTP id l12so560229yen.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 09:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=pK/j5vwjpls/+w6Ca1BeApVrvf8EyHpj0HvZanbBc54=;
        b=j/w2xuSS4LviUtLSmD3kszY5+jWvjYeQV8OUX1sskvCr9ASwoIGtB0CvDFcFbk9jTl
         kim6ZUYwc+hdqd0NrBov5yz/ne/m2zMQ5+xxUkwJbDaUmSEMTNv4kAcdOmLRYHfoMuS8
         p+iT7n54UBBykwP8dP5Q2Ak/wotJLxbZRetNSkCxDlSemoYYRejVZGdhPkSifOBO2hA+
         GFk04aUZxHeXp1qp1xjAVNJJEPTSb/8GiMjLcenH00gYZ0gIUp7dYMB9pijAaGFrFOBe
         p9Cz4xfumX18PhIFXIYF9bpiuCQ5ctNANF7ahTXJZftcXIHov9GexTZRG1J3rBeEmUyE
         gr3A==
Received: by 10.60.21.103 with SMTP id u7mr23037484oee.11.1334161793294;
        Wed, 11 Apr 2012 09:29:53 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id n9sm2704429oen.2.2012.04.11.09.29.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 09:29:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <20120411060357.GA15805@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195206>

On 4/11/2012 1:04 AM, Jonathan Nieder wrote:
> Neal Kreitzinger wrote:
>
>> Maybe small binaries do xdelta well and the above is a moot point.
>
> If I am reading it correctly, diff-delta copes fine with smallish
> binary files that have not changed much.  Converting to hex would
> only hurt.
>
How do I check the history size of a binary?  IOW, how to I check the
size of the sum of all the delta-compressions and root blob of a binary?
  That way I can sample different binary types to get a symptomatic idea
of how well they are delta compressing.  I suspect that compiled
binaries will compress well (efficient history) and graphics files may
not compress well (large history).

v/r,
neal
