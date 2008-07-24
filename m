From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git-svn does not seems to work with crlf convertion enabled.
Date: Thu, 24 Jul 2008 12:28:00 -0400
Message-ID: <32541b130807240928u695277bfx4873a3f782e3abc@mail.gmail.com>
References: <200807231544.23472.litvinov2004@gmail.com>
	 <alpine.DEB.1.00.0807231117290.2830@eeepc-johanness>
	 <200807231852.10206.litvinov2004@gmail.com>
	 <20080724142453.GV2925@dpotapov.dyndns.org>
	 <alpine.DEB.1.00.0807241539400.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>,
	"Alexander Litvinov" <litvinov2004@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 24 18:29:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM3gf-0004ad-QR
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 18:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbYGXQ2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 12:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbYGXQ2E
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 12:28:04 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:43101 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbYGXQ2C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 12:28:02 -0400
Received: by py-out-1112.google.com with SMTP id p76so2161577pyb.10
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 09:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Zd7Fr4IZJIIN+aartRP1d4kif/2fIOQ1GNbVNes58vA=;
        b=xBrqPyCWsotYHVwf5y48uNeTa0AsSMr3z4ryWUYDI5NBnpbNvACs/wr9OsLftXkWtj
         3SO7Y5BmZUqAHLPP1tplxqArKCi0rWYrIQeaYVKdnRGmAcOndoVZtN7VegAsQceNekdx
         vPU7TPKMBFmvL53jnhtMGPerBctZnKlAGW0uc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=NO20Ua49Vu1AoqZMthTHgXr0epsNEVRNm/hy7qwM2h/o2WLBdMC6cpT4Z03nOAaIb3
         z4xcyAJCtLn6CpBBczDH99DwEgJcRaK5YLGCZoRpvotVVZFLt4YMoOUH882Vy3/rcD0/
         VTMUjQeL3plFp59IJUggSkwrlDN68BO4DVihw=
Received: by 10.65.93.12 with SMTP id v12mr839766qbl.72.1216916881526;
        Thu, 24 Jul 2008 09:28:01 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Thu, 24 Jul 2008 09:28:00 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807241539400.8986@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89902>

On 7/24/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  On Thu, 24 Jul 2008, Dmitry Potapov wrote:
>  > Practically all Windows editors do not have problems to open and edit
>  > files with LF endings, but some of them will write back using CRLF.
>
> 95.23% of all statistics are made up on the spot.  I would be surprised if
>  that was not the case here.

Without assigning a specific number, Dmitry's experience matches mine.
 I haven't seen an editor that can't *read* LF since notepad.  But
many of them happily mangle the files.

Of course, notepad is probably at least 50% of the editors most
Windows users actually use, on a per-transaction basis.

Have fun,

Avery
