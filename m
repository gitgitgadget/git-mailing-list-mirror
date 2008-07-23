From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not
 been set
Date: Wed, 23 Jul 2008 12:04:44 -0600
Message-ID: <488772BC.80207@workspacewhiz.com>
References: <alpine.DEB.1.00.0807222255450.8986@racer> <7vy73tihl6.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807230203350.8986@racer> <7vej5kfs0w.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807231817460.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 20:12:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLipR-0005c9-EZ
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 20:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbYGWSL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 14:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753101AbYGWSL2
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 14:11:28 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:40406 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032AbYGWSL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 14:11:28 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jul 2008 14:11:28 EDT
Received: (qmail 13255 invoked by uid 399); 23 Jul 2008 12:04:47 -0600
Received: from unknown (HELO ?10.102.18.63?) (jjensen@workspacewhiz.com@204.128.230.1)
  by hsmail.qwknetllc.com with ESMTPAM; 23 Jul 2008 12:04:47 -0600
X-Originating-IP: 204.128.230.1
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <alpine.DEB.1.00.0807231817460.8986@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89727>

----- Original Message -----
From: Johannes Schindelin
Date: 7/23/2008 11:22 AM
> On msys we do that.  A few users decided they know better and switched it 
> off.  Me for example.  But I wouldn't do something as stupid as editing a 
> file with an editor that tries to be helpful and adds CR/LFs.
>   
There are certain file formats, such as a Visual Studio .sln file, that 
MUST be CRLF.  When a .sln file is not CRLF, Visual Studio refuses to 
read it.  I want to be able to set into the committed .gitattributes 
file the list of files that must be translated to the proper format 
regardless of the autocrlf setting.  An example is below:

*.bat crlf
*.def crlf
*.dsp crlf
*.dsw crlf
*.rc crlf
*.sln crlf
*.vcproj crlf
*.vcp crlf
*.vcw crlf

I'm not sure your patch was intended to accomplish the forced crlf 
settings above, but certainly, this functionality would be useful, if 
not critical.

Thanks.

Josh
