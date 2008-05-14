From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH v2] revision.c: really honor --first-parent
Date: Wed, 14 May 2008 13:10:34 +0200
Message-ID: <20080514111034.GA29387@cuci.nl>
References: <1210547651-32510-1-git-send-email-hjemli@gmail.com> <1210605156-22926-1-git-send-email-hjemli@gmail.com> <20080513201522.GA11485@cuci.nl> <8c5c35580805131343kc115df6yd7ce3281fb3e6171@mail.gmail.com> <7vej85suc2.fsf@gitster.siamese.dyndns.org> <20080514103454.GA28610@cuci.nl> <8c5c35580805140354s62301343n62f8319b1853bfbd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, nanako3@bluebottle.com,
	git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 13:11:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwEtL-0005rp-J2
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 13:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590AbYENLKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 07:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754876AbYENLKf
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 07:10:35 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:36848 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754856AbYENLKf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 07:10:35 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 1D1DF5461; Wed, 14 May 2008 13:10:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8c5c35580805140354s62301343n62f8319b1853bfbd@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82096>

Lars Hjemli wrote:
>On Wed, May 14, 2008 at 12:34 PM, Stephen R. van den Berg <srb@cuci.nl> wrote:
>>  So, I'd say, since the current code does not and cannot work reliably
>>  for anyone specifically using --first-parent (with every merge
>>  encountered, the probability of correctness is multiplied by 0.5 at
>>  most/least), you are going to do them a favour anyway by fixing the code,
>>  then why not simplify the convolution and make the code rock-steady (and
>>  implement my patch)?

>The current 'next' branch in git.git contains your patch with my fixup
>on top and I believe this fixes _both_ the original issue with
>first-parent (thanks to your patch) and the issue Nanako discovered
>(thanks to my patch). Am I missing something?

Probably not.  I didn't check 'next' yet, since neither mine nor your
patch had been Acked on the list (I guess it shows that I don't know the
procedures here all too well yet).
-- 
Sincerely,                                                          srb@cuci.nl
           Stephen R. van den Berg.

What if there were no hypothetical questions?
