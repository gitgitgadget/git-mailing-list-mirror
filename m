From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Why is git clone not checking out files?
Date: Tue, 30 Jan 2007 20:17:14 +0100
Message-ID: <200701302017.15364.jnareb@gmail.com>
References: <17855.35058.967318.546726@lisa.zopyra.com> <17855.38543.761930.929267@lisa.zopyra.com> <20070130190907.GE26415@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Bill Lear <rael@zopyra.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 30 20:16:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HByTN-00083N-BP
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 20:16:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbXA3TQI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 14:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbXA3TQI
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 14:16:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:54811 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbXA3TQF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 14:16:05 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1622925uga
        for <git@vger.kernel.org>; Tue, 30 Jan 2007 11:15:59 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fwCTDG2XLOOIwqubob5K+p0QdE2MlD+rZgasylU7LvpjU0Agsv7BQhjsydtpqIWYVjVYVA+qCzO9XkIOF2+AIzjRDyfeSFUQdNNbc2CD/ONuY7VkeAsKXGXESHYetA/iHwBMaJCFXY8LFQiHdYJxst38GiwdNUUxw4toieB8gkE=
Received: by 10.66.243.4 with SMTP id q4mr10579651ugh.1170184559064;
        Tue, 30 Jan 2007 11:15:59 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id 59sm10802980ugf.2007.01.30.11.15.58;
        Tue, 30 Jan 2007 11:15:58 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20070130190907.GE26415@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38191>

Shawn O. Pearce wrote:
> Bill Lear <rael@zopyra.com> wrote:

>> % git --bare clone --shared
>> % GIT_DIR=. git fetch git://source/public/project
> 
> You did not ask for a tracking branch to be created.  So the
> result of your fetch is in FETCH_HEAD only.  Try instead:
> 
> GIT_DIR=. git fetch git://source/public/project topic:refs/heads/master

Or you can use "git clone --bare --shared" (not "git --bare clone";
there is a diference).

-- 
Jakub Narebski
Poland
