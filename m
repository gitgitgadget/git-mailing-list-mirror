From: "Joel C. Salomon" <joelcsalomon@gmail.com>
Subject: Re: Breakage in master?
Date: Fri, 03 Feb 2012 09:22:27 -0500
Message-ID: <4F2BEDA3.8070308@gmail.com>
References: <CABPQNSbWu0r_gKGvCHk567pUtQiyDOCO8vFfrzPMFW1eUaj1nw@mail.gmail.com> <20120202174601.GB30857@sigill.intra.peff.net> <CABPQNSZfKCTsuusPpHa2djEOeGVN9z5s_Fr+S3EaHiv7Q4Re9w@mail.gmail.com> <4F2BE759.4000902@gmail.com> <CABPQNSbQTF1UiDuOZkX-KrTQ7oFyVvx6FxZ85c9uCF2FFUtTSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 15:22:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtK2B-0000m1-Ho
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 15:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756625Ab2BCOWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 09:22:35 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57976 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756583Ab2BCOWe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 09:22:34 -0500
Received: by qadc10 with SMTP id c10so746969qad.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 06:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=TSjVS+AZt8vZMdDAfHckPztjSCUe/mZzt2GjC2yzojE=;
        b=Ph5iz/4qAKA4cMZ/gAXkCuVwMiHFNhVyJW/GGeZMwgPl+vEMQ0HXBIC/hkEcFERn4I
         hVouYrMxGCw267HXSburGiX+gHUPjksTcYBcbSWOraEhZaMNwm/wX8w9YV345iWRZziN
         vch5PMEU8u5hfFH/ymp3xThVWuoRDELfPaEDE=
Received: by 10.229.69.96 with SMTP id y32mr2798633qci.150.1328278953974;
        Fri, 03 Feb 2012 06:22:33 -0800 (PST)
Received: from [192.168.1.47] (pool-173-77-102-10.nycmny.east.verizon.net. [173.77.102.10])
        by mx.google.com with ESMTPS id el3sm13114389qab.8.2012.02.03.06.22.29
        (version=SSLv3 cipher=OTHER);
        Fri, 03 Feb 2012 06:22:29 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:9.0) Gecko/20111229 Thunderbird/9.0
Newsgroups: gmane.comp.version-control.git,gmane.comp.version-control.msysgit
In-Reply-To: <CABPQNSbQTF1UiDuOZkX-KrTQ7oFyVvx6FxZ85c9uCF2FFUtTSg@mail.gmail.com>
X-Enigmail-Version: 1.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189777>

On 02/03/2012 09:05 AM, Erik Faye-Lund wrote:
> On Fri, Feb 3, 2012 at 2:55 PM, Joel C. Salomon <joelcsalomon@gmail.com> wrote:
>> That doesn't sound right; MinGW defaults to linking to a fairly old
>> version of the Windows C library (MSVCRT.dll from Visual Studio 6,
>> IIRC).
> 
> I'm not entirely sure what you are arguing. On MinGW, calling
> vsnprintf vs _vsnprintf leads to different implementations on MinGW.
> This is documented in the release-notes:
> http://sourceforge.net/project/shownotes.php?release_id=24832

Never mind; I stand corrected.  It's been some time since I actively
followed MinGW development.

--Joel
