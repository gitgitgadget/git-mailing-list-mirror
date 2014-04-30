From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Pull is Evil
Date: Wed, 30 Apr 2014 13:01:46 -0700
Message-ID: <20140430200146.GU9218@google.com>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
 <xmqqoazlqot4.fsf@gitster.dls.corp.google.com>
 <536106EA.5090204@xiplink.com>
 <xmqqppjyhnom.fsf@gitster.dls.corp.google.com>
 <536152D3.5050107@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 22:09:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfaof-0006EM-3Z
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 22:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759413AbaD3UJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 16:09:11 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:61240 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbaD3UJK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 16:09:10 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj1so2538784pad.15
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 13:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=JbGNq3SAal0wsl9s2p5s1uBpZ4g2bXpTYQUF0Ea2fP8=;
        b=xihpV4+xrylIBtPfvWRnSkxK1yyVBMFdxiF9QJHPEBz8KOoc4Crmf9FfjfgGvo/4ju
         7bcLai4aw0Hk4If16mORYKDEbAvR6cRPjIku07MIRqNLN2zb9GdlSqpdjycfBM/3wwiS
         1ccs0eDBv+yJlCj6o6tDXYrkEevLHaMOThsluVbrahPqzx/J6Nc1gkHcysW9xWuTOOdx
         /Ebsgjs0C98sOz8NPP1mCcefi0iQTL3vR6HXW4uMC6vKySDQ8Y3lXkdCucUYf2JJtUTF
         NUrApfcIGxL2YHEu8XJIZKEx75vfRuFFSMPiRn2DAJgwJAtUKhv7NFsKUfiYt4NEr9OQ
         v/lw==
X-Received: by 10.66.147.99 with SMTP id tj3mr12089990pab.47.1398888108839;
        Wed, 30 Apr 2014 13:01:48 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id qh2sm142076535pab.13.2014.04.30.13.01.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 30 Apr 2014 13:01:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <536152D3.5050107@xiplink.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247772>

Marc Branchaud wrote:

> All that said, I don't object to any attempts at improving the command
> either.  But I also don't see any kind of improvement that would lead me to
> start using "git pull" let alone recommending it to new users.

If "git pull" starts using --ff-only by default then I might start
recommending it.

I'm a little scared to look at the details of this thread.  Hopefully
once the topic matures and settles down a little it will be worthwhile
to review, or if there's any way I can help before then, feel free to
ask me privately.

Thanks for your work,
Jonathan
