From: Johan Herland <johan@herland.net>
Subject: Re: How to supply "raw" bytes to git grep?
Date: Thu, 18 Sep 2008 18:18:42 +0200
Message-ID: <200809181818.42745.johan@herland.net>
References: <200809181728.18597.johan@herland.net> <8c9a060809180846j25e4eb44h291b017aa01bbe36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jacob Helwig" <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 18:20:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgMEi-0004n3-3e
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 18:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611AbYIRQSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 12:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753085AbYIRQSs
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 12:18:48 -0400
Received: from sam.opera.com ([213.236.208.81]:56304 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753368AbYIRQSr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 12:18:47 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m8IGIgNa014600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 18 Sep 2008 16:18:43 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <8c9a060809180846j25e4eb44h291b017aa01bbe36@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96210>

On Thursday 18 September 2008, Jacob Helwig wrote:
> On Thu, Sep 18, 2008 at 08:28, Johan Herland wrote:
> > I wanted to list all text files in my repo which contain carriage
> > returns, so I tried the following command-line:
> >
> >        git grep --cached -I -l -e <CR>
> >
> > where <CR> is some magic incantation that I've yet to figure out.
> > I've tried all the obvious cases (\r, 0x0d, \015, etc.), but none
> > of them seem to DWIM...
>
> Inserting a literal carriage return seems to do the trick for me, in
> bash.
>
> git grep --cached -I -l -e <Ctrl-V><Ctrl-M>

Thanks. That's exactly the incantation I was looking for. ;)


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
