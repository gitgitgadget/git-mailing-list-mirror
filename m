From: Miles Bader <miles@gnu.org>
Subject: Re: [RFC][PATCH] Print the usage string on stdout instead of stderr.
Date: Mon, 17 May 2010 22:54:38 +0900
Message-ID: <AANLkTikEOxUZz4aP8dw7sqLdDDp-Z5iDPMP2rsmZkPPy@mail.gmail.com>
References: <878w7ieu4p.fsf@thor.thematica.it> <4BF12C96.9030802@drmicha.warpmail.net> 
	<buofx1qhgum.fsf@dhlpc061.dev.necel.com> <4BF14500.30806@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Giuseppe Scrivano <gscrivano@gnu.org>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon May 17 15:55:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE0mv-0001v1-0i
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 15:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426Ab0EQNzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 09:55:01 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:37240 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755314Ab0EQNy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 09:54:59 -0400
Received: by ewy8 with SMTP id 8so1853739ewy.28
        for <git@vger.kernel.org>; Mon, 17 May 2010 06:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        bh=lbJHjAGPvTayJQLslpcICiftC0LS67huLHeSLzk0D/8=;
        b=VbYV6hmOp7lYVoDh4Y/X4TbJcmVi8ZldkS8Q37bFRoPKdyuD61oHwoj7ftGuWEw0IA
         oN6Dnk6ofEmmqjDEp4WYpFafAJMJYWQTFHOJk0sWaB2NRlLpQ8TcrEOvw9SgeEqOim/R
         StAL9AAm+AUezHfy/yshN+HPBROrd2o9DXQfI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=em05ZoTMBnhgy3PRGqVfOGK8MGVQ9iKZZzj941eRNQYFurkstYB+dAmAJiE8ropPoD
         tphzx+A8IvJDxHYXbp6aJgfs4VAr5fDqPIW/HXzvG3nFw7kTmXtZtBVA2o/oWoA9ZsUN
         aVrZ65L/BGnnMpbb9Un7fWTfZO9amMNRT4wQw=
Received: by 10.103.48.21 with SMTP id a21mr3462445muk.98.1274104498148; Mon, 
	17 May 2010 06:54:58 -0700 (PDT)
Received: by 10.103.169.2 with HTTP; Mon, 17 May 2010 06:54:38 -0700 (PDT)
In-Reply-To: <4BF14500.30806@drmicha.warpmail.net>
X-Google-Sender-Auth: 32AkaW2zODKbecctfZYn7uMyINA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147237>

On Mon, May 17, 2010 at 10:30 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
>> [Note that for GNU progs, this behavior is explicitly required by the
>> GNU coding standards, and I think it's a pretty reasonable rule.]
>
> Fortunately, Git is not GNU software.

The point is not that git must follow these standards, but that it''s
a reasonable guideline (as are many of the GNU standards), and it's
generally useful if free software such as git is broadly consistent
with other free software.  For instance, git uses GNU-style long
command-line option syntax, and this is a good thing.

-Miles

-- 
Do not taunt Happy Fun Ball.
