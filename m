From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH 2/3] git-bundle: die if a given ref is not included in
 bundle
Date: Sat, 10 Mar 2007 00:48:20 -0500
Message-ID: <45F246A4.2040304@gmail.com>
References: <Pine.LNX.4.63.0703090348300.22628@wbgn013.biozentrum.uni-wuerzburg.de>	<45F0D1B3.9020204@gmail.com> <7vejny7umx.fsf@assigned-by-dhcp.cox.net>	<45F17EF0.5060008@gmail.com> <7v1wjy56qf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 10 06:48:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPuRN-0008LY-TK
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 06:48:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993176AbXCJFsS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 00:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993177AbXCJFsS
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 00:48:18 -0500
Received: from wx-out-0506.google.com ([66.249.82.232]:35662 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993176AbXCJFsR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 00:48:17 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1095500wxd
        for <git@vger.kernel.org>; Fri, 09 Mar 2007 21:48:16 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=isyx8FMKlSTq1gixN2rxoYIjK2bXoO7Z2YULfvqNMjP0j3sPgRTETTLQXSVGgkA7BNjZUueHcjAUtjjFOW3940q3SSf+OKq9lkcaquWD9DBMwHvTr6u2hwd5mu75i9nk5GOg2MRd8iIyW7mFwBB/0NqDScGioIglB98OgvTZNeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=toMz5xSAa55CANbKjbbM26gGaM0hCTesx0SkAwTluBseRae+ozF0EdavrgJWraiiOew4s6WJathfchoGN+vvn0Md/4dGjaHjugxTBmPJLmRSNLqJvoL1rH4VghlVRSeqLnRy9/6iQkPPN0VESOnlK9wdYIaxttwrCgEt1I0mr24=
Received: by 10.70.100.14 with SMTP id x14mr4623115wxb.1173505696743;
        Fri, 09 Mar 2007 21:48:16 -0800 (PST)
Received: from ?192.168.100.117? ( [71.246.235.75])
        by mx.google.com with ESMTP id i40sm5775489wxd.2007.03.09.21.48.15;
        Fri, 09 Mar 2007 21:48:16 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <7v1wjy56qf.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41849>

Junio C Hamano wrote:
> My answer is that it should list master and side as the
> available heads and master itself as also a prerequisite (which
> is not what the current code does).
>   
So, practically speaking the proposal is that for each ref where 
git-bundle currently issues a warning, instead the ref should be added 
to the prerequisites list, and that all refs given on the command line 
are in the bundle's defined refs.

Sounds reasonable to me.

Mark
