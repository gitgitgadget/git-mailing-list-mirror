From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: git update index question
Date: Wed, 17 Oct 2007 14:49:37 +0200
Message-ID: <8c5c35580710170549n25c8b692w2466091ea56d641e@mail.gmail.com>
References: <4715E2AB.4030900@filmaura.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Gonzalo Garramuno" <gga@filmaura.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 14:49:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii8LO-0000Nl-0H
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 14:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754836AbXJQMtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 08:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754523AbXJQMtj
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 08:49:39 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:6493 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbXJQMti (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 08:49:38 -0400
Received: by an-out-0708.google.com with SMTP id b36so370161ana
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 05:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=c/O7j0vU7y6Efgq0ea5EDqId1XU0eCGwkAkIkCW+DD0=;
        b=cgqhKCSw6EvNNxCyMr/8XBc6UIPyrzeHNuCHrJkcVcTgVIElrGOZgvJCBa2rliSkmHletiFBg5oIVC7QuV+3FQUp6Vg2wp07KxhOPE2AXfEgyYUGdW1MhvHU+hFW9Hkne2c2Nbb7rTXPNwB3nd/AUU90HwmPFmzyA86EESYQTro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uFxLJ0CV0V4QVbdIlI6e0a2+XR7DQ1Kc8DcyMqwB3BX0sMyof9xgUh5pZOqt8/f/p3whwz7u68kSRVcg3zgKfz2Jo2VNIttOHquBvh9N/4ABjaEGdAm/DjWHMU8Qw3hSRr+ywykvQi7kGt+ko5BK/BUh+oD8khgFLStkTEfFkvQ=
Received: by 10.114.153.18 with SMTP id a18mr9803616wae.1192625377182;
        Wed, 17 Oct 2007 05:49:37 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Wed, 17 Oct 2007 05:49:37 -0700 (PDT)
In-Reply-To: <4715E2AB.4030900@filmaura.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61373>

On 10/17/07, Gonzalo Garramuno <gga@filmaura.com> wrote:
> what's the proper way to rebuild git's index file for all the files that
> were to be committed but weren't due to the abort.

Have you tried 'git commit -a'? It will run update-index on all
modified files prior to executing the hook.

Btw: If you want to inspect your changes for offending whitespace,
'git diff --color' and  'git diff --cached --color' are your friends.
And if you give up, there is also 'git commit -a --no-verify'.

--
larsh
