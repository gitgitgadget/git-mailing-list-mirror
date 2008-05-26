From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] git-grep: add --color to highlight matches
Date: Mon, 26 May 2008 17:57:08 +0700
Message-ID: <fcaeb9bf0805260357t2bce7753vab5331bb21d98e4b@mail.gmail.com>
References: <20080524043118.GA23118@laptop>
	 <m3ve142jkc.fsf@localhost.localdomain>
	 <fcaeb9bf0805240220x78943f8ap67344a508531faa0@mail.gmail.com>
	 <200805241259.13132.jnareb@gmail.com> <483A7B1F.1050608@op5.se>
	 <alpine.DEB.1.00.0805261113050.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 26 12:58:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0aP7-0001i2-AA
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 12:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894AbYEZK5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 06:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753857AbYEZK5U
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 06:57:20 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:22421 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892AbYEZK5T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 06:57:19 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1199433fgg.17
        for <git@vger.kernel.org>; Mon, 26 May 2008 03:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=5SPr2h3Rzv7MPdcWDqzAw+ugEZD0D1VKUppaQpM1GBU=;
        b=h/+HSp2ePv/SUdmY34/Grwo/3nEfDqH90BxI/HTBxLnKxtAnwJQbsYyatHmqK+uoArKK3kHcaMMdT7agzjvCWJuvPlzzZ8PaZTqx7S4zMrGytR5OHta/AxqdK6RelF8ydLvFUmsCUODF2R1I1ACJXtI/H0i1ci2JYFac8pzN1ZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gM4dKHddCP80eXF1TM+SzxH2GwST8hVDISSpd6myewCGLIxFiCvaErmYCI3JD7rtF/II5Qispi8F24T+yHyDMQyhfuotQScIb6/CizuHdbu8I+yKehAqG4snweNIbqwIUsKHXczeWrH9BSJpSha/9ubwahy4+1cu2W8dQ2PfVpI=
Received: by 10.86.26.1 with SMTP id 1mr5351711fgz.49.1211799438577;
        Mon, 26 May 2008 03:57:18 -0700 (PDT)
Received: by 10.86.62.13 with HTTP; Mon, 26 May 2008 03:57:08 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805261113050.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82918>

On Mon, May 26, 2008 at 5:16 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Besides, it would be a kludge at best to work _twice_ to find out the
> search terms, once in the external grep, and a second time in the coloring
> code.  So I think it should not be done.

I think if it's GNU grep, just passing it --color, it will grep and
colorize search terms in one turn.
-- 
Duy
