From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFH] What do you think about adding graphical merge to git-gui?
Date: Fri, 7 Mar 2008 14:46:37 +0100
Message-ID: <200803071446.39468.jnareb@gmail.com>
References: <200803071240.09999.jnareb@gmail.com> <alpine.LSU.1.00.0803071254310.19395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 07 14:48:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXcv0-0004nZ-AV
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 14:47:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756751AbYCGNqt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2008 08:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756652AbYCGNqs
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 08:46:48 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:50005 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871AbYCGNqs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 08:46:48 -0500
Received: by ug-out-1314.google.com with SMTP id z38so4340038ugc.16
        for <git@vger.kernel.org>; Fri, 07 Mar 2008 05:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=Bn9QHUiWZDAPKL9uNA/PvJzbia0dDQgYi/nKWWaNO3I=;
        b=oD2wZ+AKJgAH+/m5VKpVxzvYO262jBcJjUP1bGo4+lfGbcEM8OLiWmXUxJ3RS8gUe3ZxSRY7UapSVWZdn9wk1bz5LEN/VtUwK/9tKCm06D0AtjmDlG0KQlSRP0BBvObR5+dF4ElQO+aBKYX01wEHf0vBqk03AX5oGurkGNZGqCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bxbLFKkvyXcJtO89ZfgCbFkuiFj+U820iRn48OKgcdApfsbDFOaxA04Vy7aDV/Zr5EZBA2vjvRccHG3n/UcKsPJc+MLRqgDjW7OxhxmNzFu4Egur5eyd0e3hswUAFoOEoNM8sNW2sMgG6N7yl1FapyXn/uNFdOcZjnrey35bO9c=
Received: by 10.78.204.1 with SMTP id b1mr3722377hug.49.1204897605414;
        Fri, 07 Mar 2008 05:46:45 -0800 (PST)
Received: from ?192.168.1.15? ( [83.8.252.126])
        by mx.google.com with ESMTPS id 37sm4937157hub.4.2008.03.07.05.46.42
        (version=SSLv3 cipher=OTHER);
        Fri, 07 Mar 2008 05:46:44 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LSU.1.00.0803071254310.19395@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76492>

Hello!

Dnia pi=B1tek 7. marca 2008 12:54, Johannes Schindelin napisa=B3:
> On Fri, 7 Mar 2008, Jakub Narebski wrote:
>=20
>> What do you think about adding "merge" subcommand to git-gui,
>> or to be more exact adding tree-level merge and/or file-level
>> merge tool to git-gui? I think we could "borrow" some code from
>> TkDiff: http://tkdiff.sourceforge.net/ (which is also GPL)
>=20
> Is there any reason not to use mergetool?

To quote original email:

>> Inspired by one of complaints in http://openradix.org/archives/349
>>
>> (Merging tools and file servers on Windows are lacking. Windows
>>  users expect the revision control to supply these tools.)

Besides "git gui merge" can be more Git-aware than for example TkDiff
invoked from git-mergetool. It can offer also resolution also to tree
level conflicts, such as rename/rename, rename/delete and rename/add,
delete/modify or for example the case when one side has file in=20
subdirectory, and other has file in submodule.

--=20
Jakub Narebski
Poland
