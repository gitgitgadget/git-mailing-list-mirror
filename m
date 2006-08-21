From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Mon, 21 Aug 2006 12:23:19 -0400
Message-ID: <9e4733910608210923qba3ca96n40c4c392fc65baa8@mail.gmail.com>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
	 <Pine.LNX.4.64.0608172323520.11359@localhost.localdomain>
	 <9e4733910608180553r34fa7b25he0bf910ef804630f@mail.gmail.com>
	 <Pine.LNX.4.64.0608181226460.11359@localhost.localdomain>
	 <9e4733910608180956n64e3362fm5c72d652e6b6243a@mail.gmail.com>
	 <Pine.LNX.4.64.0608202257020.3682@localhost.localdomain>
	 <20060821064659.GB24054@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 21 18:24:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFCZ6-0003Lm-4e
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 18:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbWHUQXW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 12:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751903AbWHUQXW
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 12:23:22 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:38667 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751904AbWHUQXV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 12:23:21 -0400
Received: by nz-out-0102.google.com with SMTP id 14so290964nzn
        for <git@vger.kernel.org>; Mon, 21 Aug 2006 09:23:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nQVt0xSjQ5ProcKNkKEWUhTd1BO4+xBPd6pLL7CUBLmd77zKN7XZ09/mbmI71gWJMsrxQ2EeAoBSRyW/GyOZLGKxawc9+23E561iSDTDu/VBOW9bpdfOU/wR8kfeQnPLwAb4MtGJIpNk0dGp3F4KCRZ74+cNCd+TK8bZfqLzTws=
Received: by 10.65.59.20 with SMTP id m20mr6899526qbk;
        Mon, 21 Aug 2006 09:23:19 -0700 (PDT)
Received: by 10.65.133.17 with HTTP; Mon, 21 Aug 2006 09:23:19 -0700 (PDT)
To: "Shawn Pearce" <spearce@spearce.org>
In-Reply-To: <20060821064659.GB24054@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25804>

On 8/21/06, Shawn Pearce <spearce@spearce.org> wrote:
> Based on the stats Jon provided me it appeared as though the code
> skipped about 9% of the objects, and at the time I thought I new
> why but looking at it again right now I'm not sure why.  :-)

9% of the objects may be duplicates because of branching. I have no
way of detecting them since I am not maintaining a map of sha1s
encountered.  The way CVS branching works some revisions are built
using forward diffs and some reverse, I can't tell when they will end
up with the same result.

-- 
Jon Smirl
jonsmirl@gmail.com
