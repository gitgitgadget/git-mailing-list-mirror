From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git mergetool vs stash apply
Date: Tue, 20 May 2008 04:52:07 -0700 (PDT)
Message-ID: <m3prrh42hl.fsf@localhost.localdomain>
References: <c6c947f60805200102h3fd27742vfd9310912907cfa@mail.gmail.com>
	<20080520090258.GB31703@sigill.intra.peff.net>
	<c6c947f60805200416s61b0cc1eqd6d6c804abd15b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org
To: "Alexander Gladysh" <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 13:53:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyQOw-0001p6-3b
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 13:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762392AbYETLwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 07:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762365AbYETLwM
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 07:52:12 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:14952 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762140AbYETLwK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 07:52:10 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2277132fkq.5
        for <git@vger.kernel.org>; Tue, 20 May 2008 04:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=nlGTOjoTynxOaVJgnUO6MjTQb/VWXUBA1P+Dh9V0B8E=;
        b=YlTOLBqK7kzg94PehgcxUwf6ohXo7XDTNcWQb+sfNI6kLJXdmmjxQMjicJpo0D9PyihUZpPq9wYkvNT55N1s0Gur5PwjyMJB5v4i+oQbiJt1s7vtXSxrA+RutSpmJ/L2dX3olVXQljXeRRqXBAomePDyV1jJkh4f3/MSd/vujJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=Q+u9BoQiPN53QSLmmDq4CjMqvIYbIoRYgokhs6NhJ/AhNmG3NOKRyALlpD0XnBZLiXFHoGjwOqrzntAHOIMRSElw4p+XMSI5wQHhjhI8Gdk5nkTVenXeYYwYncD+yWxMtkh76PDSbeeXzIiXqhEml1dj44RuAMsQY/qLvFDASuA=
Received: by 10.125.95.19 with SMTP id x19mr7165342mkl.17.1211284328719;
        Tue, 20 May 2008 04:52:08 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.215.5])
        by mx.google.com with ESMTPS id 12sm9852548fgg.0.2008.05.20.04.52.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 May 2008 04:52:07 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4KBq92H008477;
	Tue, 20 May 2008 13:52:10 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4KBq77N008474;
	Tue, 20 May 2008 13:52:07 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <c6c947f60805200416s61b0cc1eqd6d6c804abd15b4@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82478>

"Alexander Gladysh" <agladysh@gmail.com> writes:

> On Tue, May 20, 2008 at 1:02 PM, Jeff King <peff@peff.net> wrote:
>>
>> So there is perhaps something specific about your setup or your conflict
>> that is causing mergetool not to work as expected.
> 
> Most likely so.
> 
>> Can you give us a test case that fails?
> 
> No, unfortunately I can not. I was unable to produce a minimal test
> case, and I can not share the whole repo.

Can you use contents-scrambling tool by Jeff King from
  Message-ID: <20080510055332.GB11556@sigill.intra.peff.net>
  http://permalink.gmane.org/gmane.comp.version-control.git/81652

I hope it would be aded at least to contrib when it is tested more...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
