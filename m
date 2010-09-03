From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Fri, 3 Sep 2010 11:55:57 +0100
Message-ID: <AANLkTi=ZKVFYH8GnhBmTSJbqsP9_c6ZGzWSyJMf2BSXM@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
	<AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
	<4C7FC3DC.3060907@gmail.com>
	<AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
	<20100902155810.GB14508@sigill.intra.peff.net>
	<alpine.LFD.2.00.1009021233190.19366@xanadu.home>
	<4C7FDA32.5050009@gmail.com>
	<alpine.LFD.2.00.1009021326290.19366@xanadu.home>
	<AANLkTi=Q7EfeUDB6PuSa88PDtaBZSMMuaMqh8hU25ECb@mail.gmail.com>
	<20100902192910.GJ32601@spearce.org>
	<m3y6bjnadu.fsf@localhost.localdomain>
	<AANLkTikSHXivniUk-1KU30Ws23ebnbDhOmjKmpmVH-Y9@mail.gmail.com>
	<alpine.LFD.2.00.1009021931340.19366@xanadu.home>
	<AANLkTik1hfe3jVWy236611d7hdP=yt+d3vCBiGvDa26H@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Jakub Narebski <jnareb@gmail.com>, git <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 03 12:56:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrTwE-0007o9-BK
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 12:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756844Ab0ICKz7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Sep 2010 06:55:59 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:63032 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756415Ab0ICKz6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Sep 2010 06:55:58 -0400
Received: by qwh6 with SMTP id 6so1581120qwh.19
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 03:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3DXJKU3GSKbagQpHt+M0FSOwB1/4gfbL0d3/gg3TlBY=;
        b=MsVteTyZL+61vaYJL2vLSBS9pDim5Q2AOv8NU1Is6BpNCp1xgxsqaEPV2GxB6YNB0Z
         EP8Q9b4Fs9j9JHLPyIS5383MjsNF3Rz04OPQX3BPw/uDWKkqdLVHc/x4TnVqSkRDaeNG
         rNZqnhNxH3M3Rmo9x3RF1fa2G6LNPGbk1YiXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IjTHXq3mmlfFAFRVI9/tUdEQ+einQPHQEIYjzWKv0vVgVX+zQj391FyZHbyAR6lLo0
         8sajoK9bUx0aV9fNNileY518IAnGFUlYYIrbKFK7dawkcbjJkYC1gzPD05+qshQ+R7c4
         Ogmn94d3dO4XeGO/+pKMUPsOABV3C5Y6OxvWc=
Received: by 10.224.54.69 with SMTP id p5mr116643qag.347.1283511357526; Fri,
 03 Sep 2010 03:55:57 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Fri, 3 Sep 2010 03:55:57 -0700 (PDT)
In-Reply-To: <AANLkTik1hfe3jVWy236611d7hdP=yt+d3vCBiGvDa26H@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155243>

On Fri, Sep 3, 2010 at 3:48 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com=
> wrote:
> On Fri, Sep 3, 2010 at 10:29 AM, Nicolas Pitre <nico@fluxnic.net> wro=
te:
>> But usually the very first commit in a pack is huge as it typically
>> isn't delta compressed (a delta chain has to start somewhere). =C2=A0=
And this
>> first commit will roughly represent the same size as a tarball for t=
hat
>> commit. =C2=A0And if you don't get at least that first commit then y=
ou are
>> screwed. =C2=A0Or if you don't get a complete second commit when dee=
pening a
>> clone you are still screwed.
>
> Elijah's recent work on "rev-list --objects -- pathspec" [1] may help
> split a commit into many parts that can be sent separately.

 thank you nguyen, will take a look later in the day at that.   much
appreciated.
