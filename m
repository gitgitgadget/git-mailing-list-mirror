From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: ks/precompute-completion
Date: Fri, 23 Oct 2009 18:29:28 -0400
Message-ID: <4AE22E48.9050408@gmail.com>
References: <7veiovly35.fsf@alter.siamese.dyndns.org> <4AE0DAB3.1030103@gmail.com> 	<fabb9a1e0910221555k287b45ebwb15ac97851b845f9@mail.gmail.com> 	<fabb9a1e0910221556s694a344ag8e5ae07c35351ee4@mail.gmail.com> 	<4AE0E542.8010501@gmail.com> <fabb9a1e0910231127i3ab469qebdc17168a58f22a@mail.gmail.com> 	<7vd44eaqc5.fsf@alter.siamese.dyndns.org> <fabb9a1e0910231216j2a024ac5mf5b5ccb5322722f8@mail.gmail.com> 	<7v1vktc1uk.fsf@alter.siamese.dyndns.org> <m3d44deu93.fsf@localhost.localdomain> <fabb9a1e0910231322y1355ca8ck209bcd64bd29dec6@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Stephen Boyd <bebarino@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 24 00:29:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1Sdf-0004oJ-Ul
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 00:29:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbZJWW3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 18:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbZJWW3a
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 18:29:30 -0400
Received: from mail-gx0-f216.google.com ([209.85.217.216]:51743 "EHLO
	mail-gx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbZJWW33 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 18:29:29 -0400
Received: by gxk8 with SMTP id 8so11077417gxk.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2009 15:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=dC+GukJEAzCy+FOtyD3JtLmEWS96rNKxMIq3j6yljIc=;
        b=v0rafYDfhJlIPpiCLlZKIpMpzR4JLdqMMyNPS/0LzgIuRgCqJHdDQjZVsdo3x0NDhG
         tBy63ZYitKYd2IaaLLWYP1fGh5ZGgUBiEOgHE+Pv7JR9UiArzFvjnT9i8EI9WzW5hXlJ
         yiVBXQDePE4Ea/XAFCx9n70oln9JoHtZ5XDRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=X1+eqxrsOFYYV6KSPMQL6sbPN7XFjAO4qR6Shr/on8Ay02RoGYex1I9a0o0IRluPb1
         UWXFempbPJYv8a+wGEQjGuNvtwIMx5gWOL7C1ScCY8OP471r92dgo544HNlWsDRaBhzN
         iFuCHa37oQ35AZi3PBJ0/ewmUWY8gl3oSSmuU=
Received: by 10.150.43.3 with SMTP id q3mr19215425ybq.73.1256336974076;
        Fri, 23 Oct 2009 15:29:34 -0700 (PDT)
Received: from ?10.0.0.6? (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 20sm401522ywh.17.2009.10.23.15.29.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Oct 2009 15:29:33 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <fabb9a1e0910231322y1355ca8ck209bcd64bd29dec6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131137>

Sverre Rabbelier wrote:
> Heya,
> 
> On Fri, Oct 23, 2009 at 15:20, Jakub Narebski <jnareb@gmail.com> wrote:
>> (and not make this target part of "make all")
> 
> But that I can already do through 'make contrib/completion/Makefile',
> what I want is to not have to worry about doing that whenever I update
> my git install (that is, the same way as it was before it became
> pre-computed).
> 

It seems that you want the completion script promoted out of contrib. 
Otherwise, you're asking for it to be treated special with respect to 
everything else in contrib and have the top level Makefile be aware of 
it and add it to the main targets.

The promotion I have no problem with as long as the install location is 
not somewhere where any shell will find it without a config setting in 
the user's shell. Leaving it in contrib and and adding it to top level 
Makefile, I do have a problem with.
