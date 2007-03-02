From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Quick description of possible gitattributes system
Date: Fri, 2 Mar 2007 08:58:54 +0000
Message-ID: <200703020858.58741.andyparkins@gmail.com>
References: <200703011206.47213.andyparkins@gmail.com> <7vejo8o69o.fsf@assigned-by-dhcp.cox.net> <7vps7smevd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 13:01:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN6Rr-0007oI-Qb
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 13:01:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933347AbXCBMBE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 07:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933348AbXCBMBE
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 07:01:04 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:53007 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933347AbXCBMBD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 07:01:03 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1257595nfa
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 04:01:02 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=l7KiZudFsIuZX6dMe5Y0vaaChCeba80o+vwvvXnbflG4MiVjnKF6e+O2jYqKrdKu0lJ8RB4Eiw5Dae8Q0/QavItbNNXeMhgm0fiR3lqtGwA6gFRgF3t9COwKWsfPv85KLOPBWGFrVBUabmfzSpT1TCS/M1IOmPrlDID/4Zy4b2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tqpbe0cmGHRqOPpRWk5ZWxbXmr5+inhRuGLpNult4vnwU47Q4z0ctsEGES/m1nN2Xy8+afLwwEz0idgFNystcK9x86jgZKUGVrhyE+9E3wvzdWK08S9vQqHMNFAQ/T5HCO+hIawGwM60hfLkf2zbD3tsjcmbR45lUl5pAPW9wL0=
Received: by 10.49.54.3 with SMTP id g3mr7629203nfk.1172836862654;
        Fri, 02 Mar 2007 04:01:02 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id c24sm6241526ika.2007.03.02.04.01.00;
        Fri, 02 Mar 2007 04:01:00 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vps7smevd.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41197>

On Friday 2007 March 02 04:46, Junio C Hamano wrote:

> Thinking about this a bit more, I take this "syntax" part back.
> One-line-per-record format is much nicer if we want to keep this
> information in .gitattributes files in-tree, especially because

That was my original thought.  However, it occurred to me that we might have 
an implicit handler for .gitattributes that said

[handler "attributesfile"]
  merge = builtin-attributes-merge

So you don't necessarily have to keep it line based (although I suppose that 
is easier than writing a special merger).


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
