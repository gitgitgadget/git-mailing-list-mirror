From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] Teach remote machinery about remotes.default config variable
Date: Tue, 15 Jan 2008 20:25:27 -0500
Message-ID: <478D5D07.3030202@gmail.com>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org> <478855B5.9070600@gmail.com> <7vbq7ry405.fsf@gitster.siamese.dyndns.org> <47885B2C.8020809@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com> <alpine.LSU.1.00.0801122123430.8333@wbgn129.biozentrum.uni-wuerzburg.de> <47893F53.2070908@gmail.com> <alpine.LSU.1.00.0801132220200.8333@wbgn129.biozentrum.uni-wuerzburg.de> <478AD5A0.50900@gmail.com> <7vabn9m30a.fsf@gitster.siamese.dyndns.org> <478C3CD3.6010504@gmail.com> <7vy7a
 rhas9.fsf@gitster.siamese.dyndns.org> <478D3CD8.3040805@gmail.com> <alpine.LSU.1.00.0801160016320.17650@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 16 02:26:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEx2X-0000NV-25
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 02:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbYAPBZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 20:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752178AbYAPBZc
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 20:25:32 -0500
Received: from nz-out-0506.google.com ([64.233.162.233]:13912 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbYAPBZb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 20:25:31 -0500
Received: by nz-out-0506.google.com with SMTP id s18so73347nze.1
        for <git@vger.kernel.org>; Tue, 15 Jan 2008 17:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=ny0hjIPy5E9zFHDcCTMDMOAKYMavi5ow1w+F8b8zR3E=;
        b=QDsUjHaiTpHplkqkdV3GCPLowarnTQah1qKrUzmKtsZvmsmd5akc9Qom+wCpF1dMaEeSWCKFJ+JgGF4+jzTYPeC785Wx44hi151k0Oii51EW1NOmSAgRkuETbdpJmYBZpEyGmo7aXZipAzgG3sWfuN54DY7kc/3bnJb3GcC6uwg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=gOkCaJT4iE9zg7t2jzO+72YtSpjZ2/1sHtAw4hKYvyv81otjHf4qErpQoP6bK7XBCzc/GSa/PKTqOETuYiTcJXMy/LVhjD1JamKscdBWr4pXcWNyQ3aDMt85Q2260F43FRFrdx1UnEz9EI1nwF93UKj2TJDTDNH6TJnXLISQeB0=
Received: by 10.142.241.10 with SMTP id o10mr93368wfh.155.1200446729881;
        Tue, 15 Jan 2008 17:25:29 -0800 (PST)
Received: from ?192.168.1.117? ( [71.163.17.196])
        by mx.google.com with ESMTPS id h17sm576033wxd.24.2008.01.15.17.25.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 15 Jan 2008 17:25:28 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <alpine.LSU.1.00.0801160016320.17650@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70594>

Johannes Schindelin wrote:
>
> There's got to be a way to fix this _without_ affecting other users.
>
> Ciao,
> Dscho
>
>
>   
I believe the only normally visible change from my proposal is that   
git-submodule update will follow top-level's branch from 
branch.<name>.remote, which is a good thing. The other changes are only 
visible if using clone -o or otherwise explicitly asking that "origin" 
not be used or defined, which again is actually following the user's 
request.

If you know of other effects, please explain them.

Mark
