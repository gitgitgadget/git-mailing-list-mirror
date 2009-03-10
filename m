From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH/RFC] recv_sideband: Band #2 always goes to stderr
Date: Tue, 10 Mar 2009 12:35:08 -0400
Message-ID: <76718490903100935see26eake42d328e64b1d09d@mail.gmail.com>
References: <cover.1236639280u.git.johannes.schindelin@gmx.de>
	 <e2b19f6c7c50e5b0a652c40b0d8e4947134ed669.1236639280u.git.johannes.schindelin@gmx.de>
	 <49B61377.90103@viscovery.net> <49B61703.8030602@viscovery.net>
	 <20090310144646.GQ11989@spearce.org> <49B680F7.4040103@viscovery.net>
	 <alpine.DEB.1.00.0903101605460.14295@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	gitster@pobox.com, Peter Harris <git@peter.is-a-geek.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Nicolas Pitre <nico@cam.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 10 17:37:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh4we-0004tU-EM
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 17:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754585AbZCJQfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 12:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754338AbZCJQfL
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 12:35:11 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:14990 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112AbZCJQfK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 12:35:10 -0400
Received: by rv-out-0506.google.com with SMTP id g37so2290587rvb.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2009 09:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aFihCulsvIyaFapHJ9kXdaG7Oi9c9uQYhNWp/dy6gMk=;
        b=t+6beow2JSYlHdX1cC124H4KL5mhObb8QEAImOlFa+C1I3LhLDQ5D4jxv/Fg/r6AQK
         QQ1tJV67uUePPEcm7kcuA6QqRrIrZLW4Wdk81A3LY+2eMK/wh+Lt0sqNJNOq0VDobi8i
         tudXC6FM90fJn4WvCuPIFqu8dgn+vs4OEGXvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jDXbAroXwqnWROc5BtkdEPZ08Qr4p57GBRAZy3gCSknC/OmuzHYEXoDMPIpx1pYQGz
         P1FaS38jSjiATK9FuxT3RpKax7RMn4BHnrhn6ilKwyqZep8MKL5a510+J0MwEiqYqPsS
         qLoQEhdFcfayB1hKi67Ixy9u/HvqVV8CvRoP4=
Received: by 10.141.52.3 with SMTP id e3mr3812850rvk.265.1236702908468; Tue, 
	10 Mar 2009 09:35:08 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903101605460.14295@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112830>

On Tue, Mar 10, 2009 at 11:07 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> I deliberatly avoided "%.*s" in the former hunk (1) because of the posts
>> that we had yesterday about potentially misbehaved fprintf in the case
>> where the precision is 0;
>
> Didn't that turn out to be a false alarm?

Yes. A party who will remain nameless was reading the wrong man page
section (printf(1) vs printf(3)). :-)

j.
