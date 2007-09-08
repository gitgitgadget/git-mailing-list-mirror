From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 7 Sep 2007 17:37:38 -0700
Message-ID: <a1bbc6950709071737h155c78b7ie6d2b77719239a6a@mail.gmail.com>
References: <46DDC500.5000606@etek.chalmers.se>
	 <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>
	 <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
	 <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org>
	 <a1bbc6950709061808q85cf75co75f2331dc2bdbcbe@mail.gmail.com>
	 <alpine.LFD.0.999.0709070212300.5626@evo.linux-foundation.org>
	 <a1bbc6950709062009x59a41cb7re6051739c11e370c@mail.gmail.com>
	 <46E0F04D.7040101@op5.se>
	 <a1bbc6950709071517n7e7e99ffl3dd351092e7f19d6@mail.gmail.com>
	 <85sl5q1570.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Matthieu Moy" <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Sep 08 02:37:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IToKX-00065Y-AF
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 02:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbXIHAhk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 20:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbXIHAhk
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 20:37:40 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:30079 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbXIHAhj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 20:37:39 -0400
Received: by rv-out-0910.google.com with SMTP id k20so565010rvb
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 17:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=GLJaK7y6LzP+a8DPIfTiPQAxIoEFhpzu7c8AbS2W1yA=;
        b=l4vkd+nI3+CYl3MNDUygvhpLXSZ9xIAo1RK3YNSbiDUeJX/IsXl6NN3lSniUPdung+rJ2PkhSi5V+H6GPaxJ0vluD59+0ktEiijAfy8TDoFmeE5+rKg9UQHm6KcYxb/FMCCSOyEE/+IIQHR1g7pXrguoa4y+PnWc3Whsss7R364=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oc9hDn6LTgVgCVHUiPhAWY+Awg1P6y+1h+Yf2JXCaYS/oxyvnfF774Sasegrckz5l598rZyBN2mloevS0o93Fq/7KpFNISytTc34Qw9l/YMa/cdtm/76Bm/CcTRLJ/rMZ3yMxQHux5o6WpPnK50on3bb45gveS5L8svEPwIRbSY=
Received: by 10.141.14.14 with SMTP id r14mr940562rvi.1189211859023;
        Fri, 07 Sep 2007 17:37:39 -0700 (PDT)
Received: by 10.141.21.17 with HTTP; Fri, 7 Sep 2007 17:37:38 -0700 (PDT)
In-Reply-To: <85sl5q1570.fsf@lola.goethe.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58094>

On 9/7/07, David Kastrup <dak@gnu.org> wrote:
> Just compiling under C++, with no source changes, is likely to impact
> performance and compile time rather badly

This in fact is a very specific statement. Would you care to back it
up with facts?

-- 
- Dmitry
