From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Fri, 19 Mar 2010 19:39:55 +0100
Message-ID: <fabb9a1e1003191139v6ea37df3uba441f2cba9bc992@mail.gmail.com>
References: <f3271551003191018j67aa133es2fee4e3dda519ce0@mail.gmail.com> 
	<32541b131003191132y119037f8rae598d0037786703@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 19:40:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsh7P-0007bX-V8
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 19:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592Ab0CSSkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 14:40:18 -0400
Received: from mail-pz0-f194.google.com ([209.85.222.194]:39456 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab0CSSkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 14:40:16 -0400
Received: by pzk32 with SMTP id 32so2395170pzk.4
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 11:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=aMjWgjPKChcJslT+qj+fSvguKt6E0e7EnEjD/iIhWEs=;
        b=hKAUWSxN+3i7eSgRRt1XGRVpKcNSGR77My56PYj/FDBx7w+18WdmpRNOGH1WvKM/mj
         Q5Oo7zxCYoHrhMZc4vmutYykiylygQHag43B8HKrH97x/EBOlCCbBDvXd1AUgCQy2Tdh
         nRVV4SkGZc95q5qeG/Zw9OdCJk353mZlMQtsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=neLCFiPsNuBlCTAAlLV9qxfmiv+iIdhPliTZTclk/IO/9yg/o8Al8t2dpH2eoFOs42
         07uMUUQQQZdR95X1zyd+yVcdFDEGFo/CbxXjyII7cnMKIcne0hDQEAilobElFTITTiR7
         zVF29PcDFpClSyfdlysFZpG+NthAqrS/LNA3E=
Received: by 10.142.122.11 with SMTP id u11mr1069928wfc.227.1269024015171; 
	Fri, 19 Mar 2010 11:40:15 -0700 (PDT)
In-Reply-To: <32541b131003191132y119037f8rae598d0037786703@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142629>

Heya,

On Fri, Mar 19, 2010 at 19:32, Avery Pennarun <apenwarr@gmail.com> wrote:
> - all those "extra commands" that git-svn supports are considered
> backwards compatibility, even if they're absolutely obsolete because
> of newer commands, and therefore will be very hard to justify getting
> rid of

I don't think this is true. The proposal is to implement
git-remote-svn, which would allow _native_ interaction with svn
repositories, so without using 'git svn'. It would allow 'git clone
svn://example.com/myrepo' and subsequent "git pull"s from that svn
source. Do you agree that makes (part of) your comments moot, or am I
missing something?

-- 
Cheers,

Sverre Rabbelier
