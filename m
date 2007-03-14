From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Make gc a builtin.
Date: Wed, 14 Mar 2007 11:48:06 +0000
Message-ID: <200703141148.12364.andyparkins@gmail.com>
References: <11738375021267-git-send-email-jbowes@dangerouslyinc.com> <200703141045.58739.andyparkins@gmail.com> <7vps7caxjb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Theodore Tso <tytso@mit.edu>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	James Bowes <jbowes@dangerouslyinc.com>,
	Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 12:48:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRRxt-0007sJ-0q
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 12:48:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161159AbXCNLsS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 07:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161162AbXCNLsS
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 07:48:18 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:48408 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161159AbXCNLsR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 07:48:17 -0400
Received: by wx-out-0506.google.com with SMTP id h31so141114wxd
        for <git@vger.kernel.org>; Wed, 14 Mar 2007 04:48:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Y8Z4QDy5DOfDvQIA6wnEda2GMCg8ws/46APL/x1Q1AZKmx+KIndU9VUxi3d+P3Euq5b8WMV9W4K2+jQq5smYEccbkY5GIVPmK4pJAIzveIciehkTC9yQ1yZWsCN/zql+muX5dtg8BDmd99bEnKh/3ViSFpnV+1hzo3H8YIXIjTY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=hP+W1OVnL5uVhsUmzmMCGD4eIM8L0Yrr6j5PgJgXQ3oL/esJUTXfpTJ20DlsLxDTSbnQUNldmZ0ChR8ENAT7i5z3ib+ld2zJNxL2jey5M393+igrE/FhqmO1cPXYmkGCRTfOYXCNwTO6HIe/ngzhUZaJ31ena7V8coNt4uoQVw8=
Received: by 10.90.88.13 with SMTP id l13mr6975975agb.1173872897111;
        Wed, 14 Mar 2007 04:48:17 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id g1sm24546190nfe.2007.03.14.04.48.16;
        Wed, 14 Mar 2007 04:48:16 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <7vps7caxjb.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42201>

On Wednesday 2007 March 14 11:12, Junio C Hamano wrote:

> There is a difference between having a readily greppable and
> lessable copy handy to study at your own initiative, and being
> able to retrieve to review only after being told.

Well I was only joking really.

> You could argue that we can all do that with git-grep and
> git-less ;-).

Definitely.  git is so good at this sort of stuff that encouraging the 
retention of commented out code is just filling up source files with junk.

In the old days, before version control, I would often have files with

#if 0
// This is how I used to do it
// ...
#endif

These days I comment it out, then after a few successful commits it gets 
removed from the source file.  Git makes my code cleaner and clearer as it's 
not filled with obsolete junk.  I am always secure in the knowledge that I 
can go back and look if I want.  The same is true, I think, for shell script 
replaced with C code.

What will you do if in the future the C gets a feature that wasn't in the 
shell code - should the shell code be updated?  If you don't then the comment 
is a lie, if you do then it's a maintenance nightmare.

Chuck it and be happy it's chucked.  A rule for life.  I should write fortune 
cookies.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
