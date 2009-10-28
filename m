From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] mergetool--lib: add support for p4merge
Date: Wed, 28 Oct 2009 03:02:45 -0700
Message-ID: <76718490910280302o7db153dah50d7c2c4afece8e6@mail.gmail.com>
References: <1256721087-72534-1-git-send-email-jaysoffian@gmail.com>
	 <76718490910280221u4e1d3e78me7f9b0b45f590e56@mail.gmail.com>
	 <20091028093655.GC90780@gmail.com>
	 <76718490910280252n7a2c41baj5e220c784f1f3617@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, "Shawn O . Pearce" <spearce@spearce.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 11:02:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N35Mh-0002dN-VO
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 11:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbZJ1KCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 06:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbZJ1KCl
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 06:02:41 -0400
Received: from mail-iw0-f180.google.com ([209.85.223.180]:35713 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbZJ1KCk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 06:02:40 -0400
Received: by iwn10 with SMTP id 10so460770iwn.4
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 03:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=a9ouYnOxnvA0ng8pP/POyuyhL1FglVXUbYqQ5BXk1MU=;
        b=vKHNdB2HYDwE96AMXAWbXgfx5RleCT/Ue/8Bb+wETI87m01BvpR4FKhldN4lefEO4P
         sqSVXD+DSEK3KH0IS9eHy4qYrgO4lSUsXYFKWpf/+UCDe+yvpgF3H5ZFLW9oZvsAgSoR
         udf2XHoJ0Eod1hOVcOmPkKNfPluGV+sa00MF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=t7CANUkpiBfyVr0EXPw2D9S1bcRXYAe4bE0Xu9toxiNaECGOlR+oLD4mSWJWdtnZat
         IWppDgb9jUV32rExEV8l8nLF5DEFqrl+3IODWxZIHBUvx9q2xrVIELlDuHhfsQXJhQSF
         819sUWIkQiCf7VFPCJY6M2r/P2F74USuTFXAI=
Received: by 10.231.9.33 with SMTP id j33mr5939998ibj.37.1256724165179; Wed, 
	28 Oct 2009 03:02:45 -0700 (PDT)
In-Reply-To: <76718490910280252n7a2c41baj5e220c784f1f3617@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131444>

On Wed, Oct 28, 2009 at 2:52 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
> 2) Does p4merge/launchp4merge require absolute paths for its arguments.
>
> I found that it does.

I lie. Running p4merge directly works with relative paths. Launching
p4merge via launchp4merge (or via open) requires absolute paths, which
I guess makes sense.

I'd still lean toward using launchp4merge with absolute paths.

$0.02.

j.
