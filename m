From: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
Subject: Re: Generalised bisection
Date: Wed, 11 Mar 2009 08:59:58 +0000
Message-ID: <efe2b6d70903110159h78de744yc141effaf5aa0821@mail.gmail.com>
References: <efe2b6d70903081840v18e77aa7w2dac2bed553d0d6a@mail.gmail.com>
	 <200903100808.15875.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, John Tapsell <johnflux@gmail.com>,
	Ingo Molnar <mingo@elte.hu>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Mar 11 10:01:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhKJh-00035b-M9
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 10:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477AbZCKJAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 05:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753391AbZCKJAE
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 05:00:04 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:24971 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319AbZCKJAB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 05:00:01 -0400
Received: by an-out-0708.google.com with SMTP id c2so1405734anc.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 01:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/zNO14E/6iVfli6vptWJiJArtiRd6Tp27U0yKu/eWmA=;
        b=orS+fYc1/vbj/jIDuxnvWONYQHDKYdoMDmmkmSuSokwciuLrIVsh2qixzX8040zf52
         Xo7UCGALqrgJ3UL7hgx4QCYsgjVEvipqcEa5dPDs5NSGlkTisSQ+S+KmIFnNB++prGl9
         BmEXna6TrEkYOpX4nMuJe4Oqaro+C6gbNaFoc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=R6hENulfZIl6aZrUHwGRf9Jv/91iRNtgH54QfzLJeUBJOfEmsxF+NCVTgmG9DwTUNh
         dpiLnoUg6SNKbfnTMzB6cQ7b2bujZDGajG410mlm7N3LrkQE8PR9dB/oHE/WADToxBhd
         k8kB8tLSQ2x2OZJsqaIqtp0Z6juoyt7dwDGeg=
Received: by 10.100.211.3 with SMTP id j3mr5324114ang.42.1236761998897; Wed, 
	11 Mar 2009 01:59:58 -0700 (PDT)
In-Reply-To: <200903100808.15875.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112894>

On Tue, Mar 10, 2009 at 7:08 AM, Christian Couder
<chriscool@tuxfamily.org> wrote:

> I will try to have a look at the end of this week.
> But do you want it to be integrated with Git or do you want it to be an
> independant project that works with many different version control system?

Hmm. Whatever works, I guess. On the one hand the code does seem
naturally generic. On the other hand, it's good if users don't
have to separately obtain an extra package to use it. Supposing that
the algorithm proves useful, would the git project  be okay with an
extra dependency, or would you want to integrate it? Right now it's in
python, which I understand is an obstacle to integration.

In the short term, I assume the algorithm needs to prove its
usefulness before either being integrated or added as a dependency.
It seems the majority of potential users - developers of code of the
sort likely to have intermittent bugs, such as the kernel or xorg -
use git,
so I would like it to be as easy as possible for git users to try it
out. Maybe it could live in the contrib directory for a while?

Ealdwulf
