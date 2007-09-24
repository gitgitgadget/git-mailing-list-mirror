From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] Supplant the "while case ... break ;; esac" idiom
Date: Mon, 24 Sep 2007 16:30:33 +1000
Message-ID: <ee77f5c20709232330n7b47d9e9v38677678dbf197da@mail.gmail.com>
References: <853ax5mb1j.fsf@lola.goethe.zz> <85myvdktb3.fsf@lola.goethe.zz>
	 <20070924060521.GB10975@glandium.org> <85k5qgk295.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Mike Hommey" <mh@glandium.org>, git@vger.kernel.org
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Sep 24 08:30:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZhSq-0007WW-Kg
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 08:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbXIXGae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 02:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752219AbXIXGae
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 02:30:34 -0400
Received: from rv-out-0910.google.com ([209.85.198.191]:47372 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201AbXIXGad (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 02:30:33 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1328677rvb
        for <git@vger.kernel.org>; Sun, 23 Sep 2007 23:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=t1v+ExgnXm1LI27SA9hpImeQewnRUHAjw+IhWI+huCA=;
        b=ETZ+/tfAYNnr8Idqm5FpIogj5r0wEied65T/kALMSxau6dEeTMj9DmXrgNqGsYXJE4/GsdRUY827hxOcnm3H1J0AlCTkjzC6D9/f/X5olo32udPKMFf8yzfpgO8WwJK30V1R27/DQIbg5kcuoScIPKGFXQCaTkKJ4Ag9BuFeMA0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PcJvH5BqoCe1uTEwuQIEwLpFq6SzWvUlivAqaCTXkL13zh9uwiRgBl/rCEXzWDBK95qqLAjnb3ENKCOSFhXXhEB4cUfugLH9E8k86D6zl1syFsqm5e/v+aqIB7Q0vlKoUPezJd3+JCHtH8S/fFodIYBI3t5CQ2G4U20leLOXH3k=
Received: by 10.141.210.5 with SMTP id m5mr464925rvq.1190615433132;
        Sun, 23 Sep 2007 23:30:33 -0700 (PDT)
Received: by 10.141.153.4 with HTTP; Sun, 23 Sep 2007 23:30:33 -0700 (PDT)
In-Reply-To: <85k5qgk295.fsf@lola.goethe.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59023>

On 24/09/2007, David Kastrup <dak@gnu.org> wrote:
> Mike Hommey <mh@glandium.org> writes:
>
> > On Sun, Sep 23, 2007 at 10:42:08PM +0200, David Kastrup wrote:
> >> -while case $# in 0) break ;; esac
> >> +while test $# != 0
> >
> > Wouldn't -ne be better ?
>
> Why?

Because -ne does a numeric comparison, != does a string comparison,
and it's a numeric comparison happening, semantically speaking.


Dave.
