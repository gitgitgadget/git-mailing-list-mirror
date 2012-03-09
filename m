From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH] tests: modernise style: more uses of test_line_count
Date: Sat, 10 Mar 2012 00:00:07 +0100
Message-ID: <4F5A8B77.7020900@gmail.com>
References: <08c65508e2a643cb3352b829675f79d592c917cb.1331329464.git.stefano.lattarini@gmail.com> <7vpqcl4diw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 00:00:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S68nh-0000i3-PG
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 00:00:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030416Ab2CIXA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 18:00:27 -0500
Received: from mail-wi0-f170.google.com ([209.85.212.170]:63554 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758397Ab2CIXAW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 18:00:22 -0500
Received: by wibhr17 with SMTP id hr17so897345wib.1
        for <git@vger.kernel.org>; Fri, 09 Mar 2012 15:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=ii7HqZb+oKWGG4RYxynRAvoqUfRGHMArUSxUgtI23k0=;
        b=EqoPFi1fYziNmmuRZi8BuHXQgHlu5yw7/3Lu6uVc8Mx737E64Ga9ZrAA74qfEVLp93
         8rMisfBZw7bgS6S57YJjf7Cu2IcH9Od8K/NGIYLVNJVZFh6WMde+tddPFMCeEpJqQwaq
         vVos60cQL2bvGHVUXopdmfcaa9LQa9p2y63AvvXuJ0rBzX6m79fT1+6IzWEtz3WU42Rq
         Fg/N16hbseTGyvjX9LesGQBWO65U7HzsBcoDeI4qcJyRVrKqN32Z3UJZGNA5jIkztSnH
         licp9ufXRPs1qtU8SYA3hhOp6IIQtxMkYvyGWUMsZ59aedx7k01IF1jI2VgyO1rIIWXm
         Ts/g==
Received: by 10.216.138.17 with SMTP id z17mr2512757wei.18.1331334021573;
        Fri, 09 Mar 2012 15:00:21 -0800 (PST)
Received: from [87.0.103.201] (host201-103-dynamic.0-87-r.retail.telecomitalia.it. [87.0.103.201])
        by mx.google.com with ESMTPS id h19sm8894956wiw.9.2012.03.09.15.00.19
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Mar 2012 15:00:20 -0800 (PST)
In-Reply-To: <7vpqcl4diw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192755>

On 03/09/2012 11:26 PM, Junio C Hamano wrote:
> Stefano Lattarini <stefano.lattarini@gmail.com> writes:
> 
>>  This change modernizes one (and just one) kind of obsolescent idiom
>>  throughout (almost) all the tests, rather than tweaking one single test
>>  with lots of different and unrelated modernizations.  This approach
>>  seems safer, and IMHO makes for patches easier to write and review.
> 
> Yes, but during the pre-release "regression fix only" period is not
> a good time to do so.
>
Sorry, I don't follow the list well enough to know when a release is imminent.
But you of course right that the maintainers shouldn't be distracted with
cosmetic/tweaking patches when a release is in preparation.  I will ping this
patch once 1.7.10 is out then (and put similar patches on hold until then).

Thanks, and sorry for the noise,
  Stefano
