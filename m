From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: why multiple password prompts?
Date: Sat, 29 Mar 2008 14:37:00 -0400
Message-ID: <46a038f90803291137l20244abcke54941dc92c2c8b4@mail.gmail.com>
References: <alpine.WNT.1.10.0803291141550.11992@znlsyl>
	 <alpine.LNX.1.00.0803291241020.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Paul <lists@pote.com>, git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Mar 29 19:38:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JffwB-0000lb-Ih
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 19:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552AbYC2ShG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 14:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753558AbYC2ShF
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 14:37:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:12846 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550AbYC2ShE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 14:37:04 -0400
Received: by ug-out-1314.google.com with SMTP id z38so146622ugc.16
        for <git@vger.kernel.org>; Sat, 29 Mar 2008 11:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=x/YqDQd9+S2k97xJIebmc+UHgH3w1LbDstxCz2bsBxU=;
        b=dB6BnvBy9zT2q70K8B7L0uqJeWbD0ol4B/DGU5V3G56GPE6UgNB8SZdxI4dsrddp2ZDVQKOeK2Yjm56pQPN5rvxM/IyVnujvjok3hoDUTFIn1BuZJ7eGuH1IQx9UuTM/XijM0y5x9xamHBsPwnHw/McWjPpfGq3YOJtXAGZ7EwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BxMxCratK61p1LMgn6gVqauWzJ9GmYM6RlaAdMswjlP50LdSTRE5zL4jTo6a5bMSjQLMrxSfA1cC56+9nzNRAFWpWsES+NvuUlEIo7Y4Cdjcpup+igxHX4ocbdcJRbMrN3Y1JKNJQ9rBG2uN8pKA+V35By25zJiGi8uysZxWQiQ=
Received: by 10.66.251.3 with SMTP id y3mr764736ugh.88.1206815820579;
        Sat, 29 Mar 2008 11:37:00 -0700 (PDT)
Received: by 10.66.252.6 with HTTP; Sat, 29 Mar 2008 11:37:00 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.00.0803291241020.19665@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78476>

On Sat, Mar 29, 2008 at 12:48 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
>  One of the changes in the upcoming release is to reduce this to one,
>  except for an occasional second one.

That's cool - didn't know a rework of the ssh interactions had
happened. It would be really good if we could detect if there's an
existing "master" connection and piggyback over that (see options -M
and -O). Reading man ssh_config it looks like we may be able to say
something along the lines of " -o ControlMaster=auto ".

cheers,



martin
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
