From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Question about bare repositories
Date: Fri, 16 Mar 2007 11:52:35 +0000
Message-ID: <200703161152.37485.andyparkins@gmail.com>
References: <200703160947.03833.andyparkins@gmail.com> <7vhcslv701.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 16 12:53:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSAzd-0008M5-BD
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 12:53:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbXCPLwn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 07:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965330AbXCPLwn
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 07:52:43 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:23352 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965095AbXCPLwm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 07:52:42 -0400
Received: by wx-out-0506.google.com with SMTP id h31so518326wxd
        for <git@vger.kernel.org>; Fri, 16 Mar 2007 04:52:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qCE7e6wGSVjvVfEYh1O0N3gLeb7w3aLkJ9fz+t3mGISUphO55Ty72gw1OsoUn4W4Lj//f9zKqa313AxNRFgX4ehgjvTX29mUIz2Bh9ZKB70T5rOX9gceG19NMYNl9RKq3bpi/O+AqxJNBexgIeEdkZceg9RtElrDWhEMVsNi2vQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=aIu97SdrT3pcjjA0UuC+m/9lQlrxehWYgJZ5t4PKs9Nhbxe24nATBCZnz7rVV/n6qFSsDXJ+i7/moP571F5pdxgtelMxOAkf4+H7oRkGXgOpiMOt5b4WnpeKoB1mQ7IzGJgeKql0wX10Mv3Do9YkN6kUMIeEk6yb3OxbFZoi9s4=
Received: by 10.70.44.4 with SMTP id r4mr2186213wxr.1174045961778;
        Fri, 16 Mar 2007 04:52:41 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id q28sm4087905nfc.2007.03.16.04.52.40;
        Fri, 16 Mar 2007 04:52:40 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <7vhcslv701.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42352>

On Friday 2007 March 16 10:05, Junio C Hamano wrote:
> Andy Parkins <andyparkins@gmail.com> writes:
> > Why does a bare repository have/need a HEAD?
>
> To mark which branch the repository owner considers the primary
> branch of the repository.  I think "git pull $URL" (i.e. without

Interesting.   So it's got a much reduced importance and sounds like it is 
mainly as guidance for cloners, etc.

> using shorthand arranged in the config nor $GIT_DIR/remotes/)
> defaults to fetching and merging HEAD from there, for example (I
> say "I think" because it's been a while I did so myself, and we
> might have broken it during the 1.5.0 process, which had a lot
> of work in that area).

Me too; I don't think I've ever used it, which is where my confusion came 
from.

Thanks for the help.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
