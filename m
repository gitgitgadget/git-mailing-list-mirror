From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] make --color-words separate word on ispunct
Date: Sat, 12 Apr 2008 23:32:19 +0800
Message-ID: <46dff0320804120832x733000e8md813e3f8525b889a@mail.gmail.com>
References: <1207996421-29651-1-git-send-email-sgala@apache.org>
	 <alpine.DEB.1.00.0804121621560.16366@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: sgala@hisitech.com, git@vger.kernel.org,
	"Santiago Gala" <sgala@apache.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 12 17:33:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jkhj8-0003zx-T2
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 17:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894AbYDLPcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 11:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752784AbYDLPcV
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 11:32:21 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:45684 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774AbYDLPcU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 11:32:20 -0400
Received: by an-out-0708.google.com with SMTP id d31so224984and.103
        for <git@vger.kernel.org>; Sat, 12 Apr 2008 08:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=siJXueWj71EQF5JOhypVj19v7BdVUNEyAOFyZBvq+ec=;
        b=Xf7Lwm/V3PjG/Nnx+XkpL0a4Uk2HxTzv8xnVrk22ZJU8CVaqms2N2ScAjpHmYfgspqWVHYAMaN4LsoIPQTY8tcpGmWvqgqxiTt38qTjh8vdxcY09cdACfFF878P3vTQHFmPvUgKvNtEBV53UBKWT2GD6St7Uj55dSCR13ktLzAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P27OBINRvkOVIM1T2HKtiqMDFcwKsBaI2nizsRly8SMqlUCu+dd7jq360ZBAY51UIZ0oJaGPuTuEfJdearpR2RIqh/qH8xaEdWEOecuCxaSA55uDeVxAR87ndBKeWXxVJFLIlVKQ9syIuakZqWefcfwlRIhLl+/9V+QoS4uQkRc=
Received: by 10.100.96.9 with SMTP id t9mr1379491anb.129.1208014340018;
        Sat, 12 Apr 2008 08:32:20 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Sat, 12 Apr 2008 08:32:19 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0804121621560.16366@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79365>

On Sat, Apr 12, 2008 at 11:23 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>
>  On Sat, 12 Apr 2008, sgala@hisitech.com wrote:
>
>  > Note that this may actually be harmful when trying to spot punctuation
>  > changes, but for this use case I don't think color-words is helping now
>  > either.
>
>  I do not know how commonly supported ispunct(), therefore I do not like
>  the patch too much.
>
>  Besides, since long ago I want to make the list of boundary characters
>  configurable, preferably as a tr(1) style list, but I have not come around
>  to do that yet.
>

It is so good an idea. I look forward to it. Futher, should
--color-words support
multibyte characters where every character is a boundary?



-- 
Ping Yin
