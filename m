From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: fast-import and unique objects.
Date: Mon, 7 Aug 2006 00:48:47 -0400
Message-ID: <9e4733910608062148u4341dabag451c3f49f1a792a1@mail.gmail.com>
References: <9e4733910608060532w51fca2c0r8038828df0d41eeb@mail.gmail.com>
	 <9e4733910608060853ua0eabc1w9b35b8414d3c9bae@mail.gmail.com>
	 <20060806180323.GA19120@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 07 06:49:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9x33-0002j7-Nh
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 06:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWHGEsw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 00:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWHGEsv
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 00:48:51 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:15375 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751028AbWHGEst (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 00:48:49 -0400
Received: by nf-out-0910.google.com with SMTP id p46so325012nfa
        for <git@vger.kernel.org>; Sun, 06 Aug 2006 21:48:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=afCTy1kiXPvNFOATzZ9EY6lTcpKqmmWF5WSfkd/kqOfEhyMYmTMGQXYKWvprzZDt5F9+T++yQsEr8HNd8PGfA/Wn3T00MPRiXN6MSpVMPX81pikkPifUmE8B6X2vbrdYZSX94CvB5/5LfNbAph3UOqRxoykNd+zCkF+3e+PwwQ0=
Received: by 10.78.156.6 with SMTP id d6mr2256415hue;
        Sun, 06 Aug 2006 21:48:48 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Sun, 6 Aug 2006 21:48:47 -0700 (PDT)
To: "Shawn Pearce" <spearce@spearce.org>
In-Reply-To: <20060806180323.GA19120@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24996>

On 8/6/06, Shawn Pearce <spearce@spearce.org> wrote:
> So the new version should take about 20 MB of memory and should
> produce a valid pack and index in the same time as it does only
> the pack now.  Plus it won't generate duplicates.

I did a run with this and it works great.

I'm staring at the cvs2svn code now trying to figure out how to modify
it without rewriting everything. I may just leave it all alone and
build a table with cvs_file:rev to sha-1 mappings. It would be much
more efficient to carry sha-1 throughout the stages but that may
require significant rework.

-- 
Jon Smirl
jonsmirl@gmail.com
