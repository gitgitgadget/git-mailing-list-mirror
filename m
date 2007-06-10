From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 1/3] git-submodule: allow submodule name and path to differ
Date: Sun, 10 Jun 2007 10:37:58 +0200
Message-ID: <8c5c35580706100137m3c3f3d24n873f2474a8835e0e@mail.gmail.com>
References: <1181425132239-git-send-email-hjemli@gmail.com>
	 <1181425132294-git-send-email-hjemli@gmail.com>
	 <7vbqfod57b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Sven Verdoolaege" <skimo@kotnet.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 10:38:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxIw9-0004Pd-2S
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 10:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763074AbXFJIiB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 04:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763047AbXFJIiA
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 04:38:00 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:15247 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763012AbXFJIh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 04:37:59 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1687362wah
        for <git@vger.kernel.org>; Sun, 10 Jun 2007 01:37:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SH9vN3zcXceiNR4mTx7MS23x6JR1vym/+xpJT2cNdkn4G+5tMTv/D2qcuvCUlMckYTaskZ1NRF2LQfDLRGWjzvXeyHZkPfy9ORs0IysA3Us76uBurW4ZXlE1Iusl7mVyOT9uYN18VDBkqrj8e83zCYXgUiU97cmb1+HdbSvlkz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TYMEbAHJEr3kewTq+L0AO7PBN4LEFeC6hNriJtZvZD3i57VHgI10IIQK6Co4IGGU3TwGF+Uz7ebin4ubTWGMZsPmyNf+NX8zGYdPbLxRAj3U0YccudP5/E3ftPUbMwy4MntXPc69brbOQSdfKO9CHAtm1UYvKPBFSZ/K7SiITAc=
Received: by 10.114.67.2 with SMTP id p2mr4374104waa.1181464678583;
        Sun, 10 Jun 2007 01:37:58 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Sun, 10 Jun 2007 01:37:58 -0700 (PDT)
In-Reply-To: <7vbqfod57b.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49678>

On 6/10/07, Junio C Hamano <gitster@pobox.com> wrote:
> Lars Hjemli <hjemli@gmail.com> writes:
>
> > This teaches git-submodule to check module.*.path when looking for the
> > config for a submodule path. If no match is found it falls back to the
> > current behaviour (module.$path).
>
> I have a feeling that it might be much less troublesome in the
> longer term to admit that module.$path was a mistake and support
> only one format;

Hmm, what the patch does should match what is described in

  http://article.gmane.org/gmane.comp.version-control.git/48879

except that I've kept [module] instead of renaming it to [submodule].
But my wording ("module.$path") might be disconcerting :)

Fwiw: I do admit that the [path "path"] construct was a mistake.

-- 
larsh
