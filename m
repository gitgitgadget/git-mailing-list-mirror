From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: ks/precompute-completion (was Re: What's cooking in git.git (Oct
 	2009, #04; Wed, 21))
Date: Thu, 22 Oct 2009 18:20:35 -0400
Message-ID: <4AE0DAB3.1030103@gmail.com>
References: <7veiovly35.fsf@alter.siamese.dyndns.org> <4AE0190E.8020803@gmail.com> <fabb9a1e0910221011r957246dx3162cd675ff16800@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stephen Boyd <bebarino@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Kirill Smelkov <kirr@mns.spb.ru>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 00:28:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N169Q-0001kS-BH
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 00:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753027AbZJVW2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 18:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbZJVW2q
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 18:28:46 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:36045 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbZJVW2p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 18:28:45 -0400
Received: by qw-out-2122.google.com with SMTP id 9so1255235qwb.37
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 15:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=kZDTNuL3I7m5LbvltZFz5rAzJ/pUaY4tD4TZWAQ+LTs=;
        b=DffOwK6BK3WVAnm/rsiAIzx7I+ApgFDHTfPDUNFE2XI84g7wXDS3OS4sfxV/p6kPS6
         /ZhYYq1OKg1oN4QLhayjgj1cMELe+v4h3PY3IKTZDNhAClGB7loOeGa/uocuvQt12oXh
         p2TT49h0MZkSn3227kFgsdBKDLN2c43x9Jn1U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=MRRnMhsS8gHV6/kY4gBe8rrKooM0FDDfIhj/aoU7hAe2c5UdWgk/PbtnvRYGuG4Poq
         X8QSmQFdl1cppIgQAF1WKu7C5d6XmYvhpxcZt0XQoolkH8lKgz7kdcoL+PMEUSTZnn4x
         gdO/X3nrnCHrZZajg2LX+BZid2sA1iE2eXkT4=
Received: by 10.224.58.201 with SMTP id i9mr5016244qah.8.1256250037563;
        Thu, 22 Oct 2009 15:20:37 -0700 (PDT)
Received: from ?10.0.0.6? (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 2sm6505781qwi.22.2009.10.22.15.20.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Oct 2009 15:20:37 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <fabb9a1e0910221011r957246dx3162cd675ff16800@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131073>

Sverre Rabbelier wrote:
> Heya,
> 
> On Thu, Oct 22, 2009 at 03:34, Stephen Boyd <bebarino@gmail.com> wrote:
>> Junio C Hamano wrote:
>>> * ks/precompute-completion (2009-10-05) 1 commit.
>>>   (merged to 'next' on 2009-10-14 at adf722a)
>>>  + Speedup bash completion loading
>>>
>>> Are people happy with this?
>> No. I now have rebase.sh, am.sh, etc. in my completion
> 
> I would really like it if running 'make && make install' in git.git
> would also build the completion script, I don't want to have to
> remember to run 'cd contrib/completion && make' every time we get new
> completion options :P.
> 

Please do not for completion on those that did not ask for it.
