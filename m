From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: possible code error at run_command.c
Date: Mon, 21 Dec 2009 09:41:42 +0100
Message-ID: <40aa078e0912210041g1fd94c77g6cf9f1b236b6ecd7@mail.gmail.com>
References: <1976ea660912202246k45732bf2p111bbeb78047693e@mail.gmail.com>
	 <4B2F214D.2020905@viscovery.net>
	 <1976ea660912202329x42f6add3j9175867e8723a4bd@mail.gmail.com>
	 <4B2F2727.4060405@viscovery.net>
	 <1976ea660912210018y15acfe32o78841d5e0968f793@mail.gmail.com>
	 <4B2F320A.6010908@viscovery.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Dec 21 09:41:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMdpu-0007NM-OE
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 09:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310AbZLUIlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2009 03:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752793AbZLUIlo
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Dec 2009 03:41:44 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:42601 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546AbZLUIln (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2009 03:41:43 -0500
Received: by ewy19 with SMTP id 19so3711022ewy.1
        for <git@vger.kernel.org>; Mon, 21 Dec 2009 00:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=KfNoycHnEz2RdgLRm2LuRSFjGn1JnLo4t9C7RKq1fis=;
        b=QHwXVfvuOZMyyszihy5cTyW8N45h7T7LtxbBV97bRcOcJozr2hynADpKHNfxLjtose
         /k0bKeT28enW6myiBdNApsKwc+hNLUnEA3VDs/JZemkhlUfe6raqWt5/FxJWXihUMaNP
         YAm4PVZ2SxLUkhmplAkmfCFBzC/S8ykLSuSWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=EW1bQyV2AaO0ZWFkTN6bcvFHKAxiQtOfMjE8cAOd9HNZuBGSNzzH5kyhUC8uqeuGmr
         IojeXqznhXQjn+uyA0cfvseECgsSXBUbeEWMNYK3n0pf49f0vcGrC3M1ysCGRrbZ/jJL
         lMaY7t+vT5fTbPp86puIzf72HR7M8HlufMbSY=
Received: by 10.216.91.15 with SMTP id g15mr2822749wef.24.1261384902152; Mon, 
	21 Dec 2009 00:41:42 -0800 (PST)
In-Reply-To: <4B2F320A.6010908@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135549>

On Mon, Dec 21, 2009 at 9:30 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Frank Li schrieb:
>> Maybe some excute path miss initialized it. Otherwise compiler will
>> not report warning.
>
> LOOK AT THE CODE. There is no such code path.
>

That's odd. I agree, there isn't such a code path. But this is the
first time I've ever seen this MSVC-feature turn up false positives,
which puzzles me.

Perhaps Frank has had to modify start_command for MSVC, and somehow
introduced such an error? I dunno.

-- 
Erik "kusma" Faye-Lund
