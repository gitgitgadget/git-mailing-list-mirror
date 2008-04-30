From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Making submodules easier to work with (auto-update on checkout or merge, stash & restore submodules)
Date: Wed, 30 Apr 2008 16:26:43 -0400
Message-ID: <32541b130804301326l6c740f79nac03f1045af4d6fc@mail.gmail.com>
References: <8B885217-8C18-417E-8F11-BB6661792CD3@gmail.com>
	 <alpine.DEB.1.00.0804301121240.17469@eeepc-johanness>
	 <32541b130804300947s6083156etc6514cc13c24af13@mail.gmail.com>
	 <1209585345.25663.797.camel@work.sfbay.sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Tim Harper" <timcharper@gmail.com>, git@vger.kernel.org
To: "Roman Shaposhnik" <rvs@sun.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 22:27:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrItt-00083o-SY
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 22:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762940AbYD3U0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 16:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761045AbYD3U0q
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 16:26:46 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:55186 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757984AbYD3U0p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 16:26:45 -0400
Received: by fk-out-0910.google.com with SMTP id 18so468434fkq.5
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 13:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=UiYXveOgg30jJ8nZu8vhZY4i6chNUaKznok1DmlQa6o=;
        b=eSru2kuu7fT3q+q3GuKC+sRmhTkd1xGDaTsRfKYmpprXuYclk6zGPFrJ+6Swu4RFsc9Zt1KNr5r7If7lMDwlKeB9Y+XjVJS3/PpNRLzpRSzzbyustZongDAWBubaXlF3YsjRzpMKNDBz4Q1gFgO+UPtCeMbhcTzcpGDrrxH3IUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VoeGm5a4d/MskJOUoByrUtzKjlG/Iy2EID0pEgSsnRRSJ8OKjIfMRHhhLIhhXF3gnG95EKx4yD0iGZ8BZjqqK4pPY87TGVaaN0h62hJpkHatqvvO30ntQKARkOWGidpA9qg7GhawK2MarF0ET+dNdDEL1W7VRH/PiuTHaF2Pp40=
Received: by 10.82.107.3 with SMTP id f3mr179503buc.87.1209587203111;
        Wed, 30 Apr 2008 13:26:43 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Wed, 30 Apr 2008 13:26:43 -0700 (PDT)
In-Reply-To: <1209585345.25663.797.camel@work.sfbay.sun.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80869>

On 4/30/08, Roman Shaposhnik <rvs@sun.com> wrote:
> Well said.

Thanks.  I'm having a bad day so a little agreement helps a lot :)

>  > We had some discussion on the list earlier about having submodule
>  > checkouts automatically acquire a branch name, so that commits don't
>  > get lost as easily.  I was going to think about this more and
>  > eventually submit a patch, but I haven't gotten to it yet.  Anyway,
>  > the idea is that you have a branch by default, so that you don't end
>  > up in the useless situation of not being on a branch, which encourages
>  > checking in without being on a branch, in the first place.
>
> Can you give a gmane pointer to that thread?

Try this:
http://article.gmane.org/gmane.comp.version-control.git/78675

Note that this particular message is representative, but is not the
best of the solutions proposed during that thread.  Exactly which of
the solutions, if any, is the best is left as an exercise to the
reader :)

Have fun,

Avery
