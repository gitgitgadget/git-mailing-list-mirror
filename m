From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Sat, 12 May 2007 11:35:12 +0200
Message-ID: <200705121135.13142.jnareb@gmail.com>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <200705120106.53624.jnareb@gmail.com> <7vlkfu98nn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 12 13:01:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmpM2-0002wS-R6
	for gcvg-git@gmane.org; Sat, 12 May 2007 13:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756355AbXELLBf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 07:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756908AbXELLBf
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 07:01:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:57123 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757064AbXELLBe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 07:01:34 -0400
Received: by ug-out-1314.google.com with SMTP id 44so985589uga
        for <git@vger.kernel.org>; Sat, 12 May 2007 04:01:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GahpnfW4xOJNWGr3EL+RSnk3apwkpHN7Mql/m37xPWwuTxWwCQ8RiFZ8g7GuOm9ZND1bJK7Pu7+mmLxkbdnn9s3HDVXt7f+PlKm8+QIbCX953z7PLcSEIjBFhshxYqeyqWbQ7yllqQx1ZEWm+3T/rWMyeqjePuvyWumoySaA6MI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=O4XnGGKkd1UI7kJFwa1F11MU7QWkomd8legxHe+oYxv/k6hXNEdtNn22JlfWh7//LXOOa5Es+mCU6GLeYfZ/R0m4/+aYLQ4Gn6jvCHZHcFH5Ru732u7FRcyCSvAt1/QKEKS5W7lPkprU084dppPPqc8aR3HRiH+zRlTYBSsdAq4=
Received: by 10.67.22.14 with SMTP id z14mr3403722ugi.1178967692968;
        Sat, 12 May 2007 04:01:32 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id s1sm7707612uge.2007.05.12.04.01.30;
        Sat, 12 May 2007 04:01:31 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vlkfu98nn.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47034>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > -'git-add' [-n] [-v] [-f] [--interactive | -i] [-u] [--] <file>...
> > +'git-add' [-n] [-v] [-f] (-u [[--] <file>...] | [--] <file>...)
> 
> I do not think this is correct; does -u take optionally path and
> when path is ambiguous you can add -- to disambiguate?
> 
> Honestly, I would rather not sprinkle synopsis with too many
> nested parentheses and brackets, which only makes it harder to
> see without giving a clear "this combines with that but is not
> compatible with the other" information.  Adding comment to the
> section that begins with "-u::" that says "... commit -a; this
> option does not take any paths parameters." would be cleaner,
> and easier to understand.
> 
> Of course, I would prefer a patch to allow use of paths with -u
> even more, but that is what I already said ;-).

This synopisis is for _after_ patch mentioned above. If you don't
like too complicated (too deeply nested) expression in synopsis, it
could always be written as:

-'git-add' [-n] [-v] [-f] [--interactive | -i] [-u] [--] <file>...
+'git-add' [-n] [-v] [-f] [--] <file>...
+'git-add' [-n] [-v] [-f] -u [[--] <file>...]

or something like that
-- 
Jakub Narebski
Poland
