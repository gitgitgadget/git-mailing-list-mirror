From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git User's Survey 2008 partial summary, part 5 - other SCM
Date: Sun, 14 Sep 2008 15:32:56 +0200
Message-ID: <200809141532.58164.jnareb@gmail.com>
References: <200809031607.19722.jnareb@gmail.com> <200809112214.18366.jnareb@gmail.com> <fcaeb9bf0809140345n11d41430ma9b4096c66776b0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 15:34:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kerk3-0002O2-4z
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 15:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950AbYINNdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2008 09:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754109AbYINNdK
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 09:33:10 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:16578 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472AbYINNdJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Sep 2008 09:33:09 -0400
Received: by ey-out-2122.google.com with SMTP id 6so720316eyi.37
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 06:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=GeEl8iWURrQLocIfrU1Gm0BMLDHni61UjXiUrGGY0TQ=;
        b=TgCUqLOO0Su4OOJEnZREVEXYCT5+rSXsww6GCfFvSX+l7kxnbayYT6yChuYwIcg3We
         uMWmVpYw3mO/gWvBVVqssoPrIyK0MX3hUWBzcBnrfBSgS+QsFIC1oAJnIwOa0meggC0N
         Mhnh4Ct1RwWG9XQS69tqqmHfwRRQ2JPmuwixU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=gdEPb2NbAvZiUsG5VPrS8nnG798JHSM2rupRkNV7OiWEanqLEbEUvl3xQ2dUmn7dN7
         Eb2nuxwUOC68hQxmY38voLpaTjDrLebv6wXDFJ6THcksWGoV9UhKtW9t4fweiPWdbG2A
         sTzDII+bRLr1+VODmptR9w3GW3vSuGej3QK7M=
Received: by 10.103.201.12 with SMTP id d12mr4599816muq.36.1221399186792;
        Sun, 14 Sep 2008 06:33:06 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.251.193])
        by mx.google.com with ESMTPS id u9sm27644985muf.9.2008.09.14.06.33.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Sep 2008 06:33:05 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <fcaeb9bf0809140345n11d41430ma9b4096c66776b0c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95844>

On Sun, 14 Sep 2008, Nguyen Thai Ngoc Duy wrote:
> On 9/12/08, Jakub Narebski <jnareb@gmail.com> wrote:
> >
> >  15) Do you miss features in git that you know from other SCMs?
> >     If yes, what features are these (and from which SCM)?
> >     (Open ended text - Essay)
> >
> >  Total respondents       1046 (some/many of them wrote 'no')
> >  skipped this question   1249
> >
> >  This is just a very quick summary, based on a first few pages of
> >  responses, Full analysis is I think best left for after closing the
> >  survey, because I think this would be a lot of work...
> >
> >  So here is preliminary list, or rather beginning of one:
> >   * sparse/partial checkout and clone (e.g. Perforce)
> 
> Have not read the survey result, but do you recall what is the most
> used term for sparse/partial checkout? What SCMs do sparse/partial
> checkout? I think it could be usable as it is now in my
> will-be-sent-again series, but I don't really know how people want it
> to from that.

Well, I do not remember, and I think I haven't got original data now,
only the above summary.  Besides, I haven't even began analysing data
from question 34. about ideas for features, and I guess we would see
'partial checkou' ide there too.

>From short discussion on #git channel, Abhijit Menon-Sen (crab) said
that they are 'restricted views' in Perforce, but this terminology is
completly alien to Git.  Bjorn Steinbrink (doener_) mentioned that
Subversion 1.5 acquired something they call 'sparse directories':

  http://blogs.open.collab.net/svn/2007/06/sparse-director.html

(Sidenote: perhaps it would be worth to follow SVN UI for sparse 
checkout here?).  In short, people on #git agreed that 'partial 
checkout' is a good name; I think that 'sparse checkout' better renders 
idea that one can checkout _set_ of files and directories, and it is 
not only limited to single subdirectory ('subtree checkout' / 
'subdirectory checkout') or a single file.

Comparison table on Better SCM Initiative

  http://better-scm.berlios.de/comparison/comparison.html

names it "Ability to Work only on One Directory of the Repository" and 
uses '"work_on_dir"' id.

HTH
-- 
Jakub Narebski
Poland
