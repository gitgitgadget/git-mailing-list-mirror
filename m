From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 2 Nov 2007 08:25:21 +0100
Message-ID: <200711020825.23464.jnareb@gmail.com>
References: <20071022063222.GS14735@spearce.org> <fgdphj$6ga$1@ger.gmane.org> <20071102022335.GU18279@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Nov 02 08:23:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inqs4-0004g2-2Q
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 08:23:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbXKBHW6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Nov 2007 03:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752131AbXKBHW6
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 03:22:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:22913 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061AbXKBHW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 03:22:57 -0400
Received: by ug-out-1314.google.com with SMTP id z38so584836ugc
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 00:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=jWhMETnLplLZx0nZGyzypKJw47SyykXhQUxKp6Mbih0=;
        b=oA0m6VbNwHGNU8ANaEoL4eptFeIE2hn1wWlkZP8aQqNTwL+BtPEnPpXi1UMGCTzOBcgXAfYTqjN6m//iRhMV3jDlL6SPjVXug8TIL6VrbKYBjTBHIpeBJf02KKYf1NATBqSSVXNhnhIjFXYKsBBRlJNoogff8drnCDtByD0J1K8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bTIxtWWUeebya/JuQJ431GDAc1lEN0uDguXF/TliNyZKArzVUWjkaCo7EMZiD3yCO39mw5McNEI3y68DvPm8loEB4hDGREMYZCp2ewVbsUbguayzxn/1I+4PG3md1WMolWLPLxiNZ1Nh/uhE5dPjwaV4LUa4xlqP2TePnvbIvDY=
Received: by 10.67.116.4 with SMTP id t4mr693065ugm.1193988175969;
        Fri, 02 Nov 2007 00:22:55 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.214.154])
        by mx.google.com with ESMTPS id y34sm3250025iky.2007.11.02.00.22.53
        (version=SSLv3 cipher=OTHER);
        Fri, 02 Nov 2007 00:22:54 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20071102022335.GU18279@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63067>

Petr Baudis napisa=B3:
> On Fri, Nov 02, 2007 at 01:04:03AM +0100, Jakub Narebski wrote:

>> Is 'getopts' bash-ism, or is it in POSIX?
>=20
> 	http://www.opengroup.org/onlinepubs/009695399/utilities/getopts.html
>=20
> (Also, most modern distributions have manpage section 1p (3p, ...) wi=
th
> the same contents, so you can check for this stuff pretty easily.)

Thanks.

I have just realized however that it doesn't help any (option parser
not only for C builtin, but also for shell scripts, Perl scripts and
Python scripts). First, we (the git development community) do not
consider fact that something is in POSIX as indicator that we can use
the construct. Second, getopts delas IIRC only with _short_ options.

--=20
Jakub Narebski
Poland
