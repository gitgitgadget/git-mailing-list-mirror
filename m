From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 3/3] Add sideband status report to git-archive protocol
Date: Tue, 12 Sep 2006 10:45:43 +0200
Message-ID: <450673B7.8050704@innova-card.com>
References: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net>	<7vk64ctctv.fsf@assigned-by-dhcp.cox.net>	<7v1wqkt2v4.fsf_-_@assigned-by-dhcp.cox.net>	<45053BA2.6050502@innova-card.com> <7vzmd5eedk.fsf@assigned-by-dhcp.cox.net> <45066CFD.5040202@innova-card.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 12 10:46:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GN3uG-0005b6-La
	for gcvg-git@gmane.org; Tue, 12 Sep 2006 10:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWILIpZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Sep 2006 04:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWILIpZ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Sep 2006 04:45:25 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:48732 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751332AbWILIpY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Sep 2006 04:45:24 -0400
Received: by nz-out-0102.google.com with SMTP id n1so684887nzf
        for <git@vger.kernel.org>; Tue, 12 Sep 2006 01:45:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=tQcvSCQ2BBPwF2wMnw6OTYYNwaK2Vgoy2lrktw3vWyv1y7V6FigyrKgOAoZg3+oqPr1dOsbxXBl4y2dPkO0OVFKsXO8OuXYr4UoAj+aTV3a9PvhkXns8oUThgmNFTHlThn9LHPdCMFM74nsR7HDTGFrTo+ld6MRGkgmBL6HY0gk=
Received: by 10.65.114.16 with SMTP id r16mr6053767qbm;
        Tue, 12 Sep 2006 01:45:23 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.gmail.com with ESMTP id e15sm4792625qba.2006.09.12.01.45.22;
        Tue, 12 Sep 2006 01:45:23 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <45066CFD.5040202@innova-card.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26884>

Franck Bui-Huu wrote:
> Junio C Hamano wrote:
>>
>> We should also check when read() returns an error, so how about
>> this on top of your patch?
>>

argh, there's still something broken...doing:

$ while true; do
> git archive --format=tar --remote=git://localhost/repo.git HEAD | tar tf -
> done

stucks somehow. I won't have time to look at it today :(

		Franck
