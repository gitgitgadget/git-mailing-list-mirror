From: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>
Subject: Re: multiple checked out branches
Date: Thu, 2 Aug 2007 19:16:08 +0200
Message-ID: <8b65902a0708021016j4eb11577v8da5bd67df58adea@mail.gmail.com>
References: <20070801220435.GA19226@raptus.dandreoli.com>
	 <Pine.LNX.4.64.0708012309010.28202@beast.quantumfyre.co.uk>
	 <20070802000217.GA20018@raptus.dandreoli.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Domenico Andreoli" <cavokz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 19:16:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGeHY-0006HV-7m
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 19:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107AbXHBRQM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 13:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbXHBRQL
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 13:16:11 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:58633 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbXHBRQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 13:16:09 -0400
Received: by an-out-0708.google.com with SMTP id d31so113063and
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 10:16:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ti+FbiwKM1IZots4n5Cpklb9+kPl0rufw2d+IC6roY/mDKIUQ9XFwz3KO2wpqaCKS5FhlK1BTIHovAeKDJfKrmyRiNyKyHa6+iIsiAERtZrkxPA/FSW9doJvcCvN7yMUD//MSeVsqZvlL0TE1Zpw0nT6Zi36rKlWS5QLmLaL+uc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SqZrnDO50Qh2qW1t8Ch8LzZR8WnStbkYpsSfluTcY3WttmebwZdCiCEwzPF4M708Bznj3Oe6Vs4Qq0FaW+bdUOTen4HuAHRaUw086QQyn8XyrcR7KtwUQbvGlWgvK+2k/UTUjgx5WCdHStiLrZ47xaZH7rorupyU31PHypc2oLI=
Received: by 10.100.32.1 with SMTP id f1mr1260830anf.1186074968833;
        Thu, 02 Aug 2007 10:16:08 -0700 (PDT)
Received: by 10.100.44.8 with HTTP; Thu, 2 Aug 2007 10:16:08 -0700 (PDT)
In-Reply-To: <20070802000217.GA20018@raptus.dandreoli.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54573>

On 8/2/07, Domenico Andreoli <cavokz@gmail.com> wrote:
> On Wed, Aug 01, 2007 at 11:19:25PM +0100, Julian Phillips wrote:
> The actual problem is that switching form a branch to another makes
> my autotools fuck and I have to rebuild stuff all the time. My box is
> still a faint-hearted single core...

I encounter same problem. Actually, I did full rebuild every time
(which is counter-productive). But, reading at your mail, I have an
other idea: what about the "remote" compilation offered by autotools?

Normally, autotools are design in such way that you can share the same
source for different configuration. To do this, simply create one
"build" directory per branch, go to this directory and do:
../configure && make

I'm unable to try it now, so I express now all my "confuses" if it was
a bad idea.
-- 
Guilhem BONNEFILLE
-=- #UIN: 15146515 JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
-=- mailto:guilhem.bonnefille@gmail.com
-=- http://nathguil.free.fr/
