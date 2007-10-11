From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git-cvsserver: added support for update -p
Date: Thu, 11 Oct 2007 10:45:14 +0200
Message-ID: <470DE29A.5010001@op5.se>
References: <200710101316.03633.jan@swi-prolog.org> <20071010200029.GK31659@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jan Wielemaker <jan@swi-prolog.org>,
	Git Mailing List <git@vger.kernel.org>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Thu Oct 11 10:45:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iftfk-0008Vd-4x
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 10:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756640AbXJKIp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 04:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756623AbXJKIp0
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 04:45:26 -0400
Received: from mail.op5.se ([193.201.96.20]:33201 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756521AbXJKIpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 04:45:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 9A18D173067A;
	Thu, 11 Oct 2007 10:44:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JXo-tPlKaS1e; Thu, 11 Oct 2007 10:44:37 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 44B01173067F;
	Thu, 11 Oct 2007 10:44:36 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071010200029.GK31659@planck.djpig.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60587>

Frank Lichtenheld wrote:
> On Wed, Oct 10, 2007 at 01:16:03PM +0200, Jan Wielemaker wrote:
>> +	# if we have a -p we should just send the file
>> +        if ( exists ( $state->{opt}{p} ) )
>> +	{
>> +	    if ( open my $fh, '-|', "git-cat-file", "blob", $meta->{filehash} )
>> +	    {   while ( <$fh> )
>> +		{ print "M " . $_;
>> +		}
>> +		close $fh or die ("Couldn't close filehandle for transmitfile(): $!");
>> +	    } else
>> +	    { die("Couldn't execute git-cat-file");
>> +	    }
>> +
>> +	    next;
>> +	}
> 
> 
> There seems to be inconsistent whitespace in the patch.
> And please never do that else\n{ again, it hurts my eye ;)
> 

That cuddled opening brace hurts mine more.

{ while()\n{ print()...

It's usually a good idea to pick some indentation style that at least *some* tool
can create, and when contributing to a project it's usually considered good form
to stick to the style already used.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
