From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-tag bug? confusing git fast-export with double tag objects
Date: Sat, 16 May 2009 10:02:59 +0200
Message-ID: <4A0E7333.3020104@op5.se>
References: <op.utv93sdo1e62zd@merlin.emma.line.org> <7v3ab6uuw4.fsf@alter.siamese.dyndns.org> <4A0E67E9.3020208@op5.se> <200905160956.27417.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Matthias Andree <matthias.andree@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 16 10:04:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5EsV-0001My-I8
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 10:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619AbZEPIDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 04:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753503AbZEPIDH
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 04:03:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:54792 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbZEPIDC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 04:03:02 -0400
Received: by fg-out-1718.google.com with SMTP id 16so820763fgg.17
        for <git@vger.kernel.org>; Sat, 16 May 2009 01:03:02 -0700 (PDT)
Received: by 10.86.86.2 with SMTP id j2mr4539141fgb.50.1242460982088;
        Sat, 16 May 2009 01:03:02 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.163.94])
        by mx.google.com with ESMTPS id d6sm3810619fga.27.2009.05.16.01.03.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 May 2009 01:03:01 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <200905160956.27417.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119343>

Jakub Narebski wrote:
> On Sat, 16 May 2009, Andreas Ericsson wrote:
> 
>> Add a tag with a new name, pointing to the original tag. Try doing what
>> Matthias did and then run "git show $tagname". It won't show the original
>> tag at all, so people have to resort to low-level commands in order to
>> see it, but it will still exist as an object.
> 
> Not true. Did you check that?
> 

Yes, but with light-weight tags on a repo after cvs import. Mea culpa, so
this is a non-issue. Thanks for politely pointing out my error :-)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
