From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFH] What do you think about adding graphical merge to git-gui?
Date: Fri, 7 Mar 2008 16:21:35 +0100
Message-ID: <200803071621.37376.jnareb@gmail.com>
References: <200803071240.09999.jnareb@gmail.com> <200803071446.39468.jnareb@gmail.com> <alpine.LSU.1.00.0803071453160.19395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 07 16:23:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXePK-0001D3-99
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 16:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761449AbYCGPVx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2008 10:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762300AbYCGPVw
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 10:21:52 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:34815 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754900AbYCGPVv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 10:21:51 -0500
Received: by ug-out-1314.google.com with SMTP id z38so4369095ugc.16
        for <git@vger.kernel.org>; Fri, 07 Mar 2008 07:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=TWKqhWejjmcq0Yum1wt8g7yrMxDc68FHq2yaP/KvTGo=;
        b=sSdiclzMrhnB5LckoUS3FpDbGnx/IIDuhyLjFX4jqf+ymBgYhbguycBTNkRrwhO5EzfILO2pKkjzxajEFdITowMGEEmCCh5bn9uB0dWYdG8rAzFkBt1iIyAZsbYp/OoyMiSJdQdVHiK+qFVu5HO/q+BhmnXBLoqNAdfFv9dYEgo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YGHPUgRgWObzELPAM1BMoLRC8NsaAdGBz2eQi3ARZpNJw8/e8JKoHscfEG77QBGNmzDrzPoNsLgcOy6NYS4/p+ugSK1h95BahtvX9z34whmXyePiuyoRPcP5NYXJhqpnbiANAwK0Np6BEm5z7LQPk5pnx0U945oPPL+zxBOe0U4=
Received: by 10.78.97.7 with SMTP id u7mr4095319hub.53.1204903308681;
        Fri, 07 Mar 2008 07:21:48 -0800 (PST)
Received: from ?192.168.1.15? ( [83.8.252.126])
        by mx.google.com with ESMTPS id 31sm5124772hub.10.2008.03.07.07.21.41
        (version=SSLv3 cipher=OTHER);
        Fri, 07 Mar 2008 07:21:45 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LSU.1.00.0803071453160.19395@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76495>

Johannes Schindelin wrote:
> On Fri, 7 Mar 2008, Jakub Narebski wrote:
>> Dnia pi=B1tek 7. marca 2008 12:54, Johannes Schindelin napisa=B3:
>>> On Fri, 7 Mar 2008, Jakub Narebski wrote:
>>>=20
>>>> What do you think about adding "merge" subcommand to git-gui,
>>>> or to be more exact adding tree-level merge and/or file-level
>>>> merge tool to git-gui? I think we could "borrow" some code from
>>>> TkDiff: http://tkdiff.sourceforge.net/ (which is also GPL)
>>>=20
>>> Is there any reason not to use mergetool?
[...]

>> Besides "git gui merge" can be more Git-aware than for example TkDif=
f=20
>> invoked from git-mergetool. It can offer also resolution also to tre=
e=20
>> level conflicts, such as rename/rename, rename/delete and rename/add=
,=20
>> delete/modify or for example the case when one side has file in=20
>> subdirectory, and other has file in submodule.
>=20
> Sure, go ahead.

Could you recommend some good (best if also free) documentation of=20
Tcl/Tk, so I won't be doing "cargo cult" (copy'n'paste) programming?

--=20
Jakub Narebski
Poland
