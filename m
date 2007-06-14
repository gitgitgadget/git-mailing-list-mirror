From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: That improved git-gui blame viewer..
Date: Thu, 14 Jun 2007 08:24:40 +0200
Message-ID: <e5bfff550706132324p5978852dm4d4cdaf05d01ded8@mail.gmail.com>
References: <alpine.LFD.0.98.0706091117510.20321@woody.linux-foundation.org>
	 <20070611064203.GG6073@spearce.org>
	 <alpine.LFD.0.98.0706110826590.14121@woody.linux-foundation.org>
	 <7vveduqxxr.fsf@assigned-by-dhcp.pobox.com>
	 <e5bfff550706112316j42c7c8e8uf8383de990ca9707@mail.gmail.com>
	 <7vbqflll55.fsf@assigned-by-dhcp.pobox.com>
	 <e5bfff550706120427g7ad9d38bpc34d9ea284ace693@mail.gmail.com>
	 <20070612135303.GT6073@spearce.org>
	 <7v645thto7.fsf@assigned-by-dhcp.pobox.com>
	 <f4ptq3$71v$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 08:25:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hyilj-0005Ed-FT
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 08:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291AbXFNGYn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 02:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbXFNGYm
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 02:24:42 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:24702 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbXFNGYl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 02:24:41 -0400
Received: by wa-out-1112.google.com with SMTP id v27so554312wah
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 23:24:40 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n5fytXumtYltWG2ndNhN7vbs3zMWTSBLZAiw8WfQcmjvp9Ij32R4JOB+Zwkr4lbjQx9RoJgMZceHV2H079e7o0FDNszmQ7Wuvx/34G/mV6XSjwvAyNVxNscRlAM9BNb0ZF/Yb1izog+gt/zef+SarOdvNnnZXjNEOqZesvx74nY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=chakk1FUCSjLAZmNmGJfgd/4czKSBEgMjWFRncLDC+O4Dlg+XbIXyieEDQEH9NpL5ZSI07C8tXkbgyH9OfgqSkbrUhhQMJ1phcWGd49cRiRHvR7R/uoPRPqCHCMTEMHmNXyN0i3bjudMY7AvL6iFFl3VeYKqNjx6Yg8YnzNo+r4=
Received: by 10.115.46.9 with SMTP id y9mr1451236waj.1181802280932;
        Wed, 13 Jun 2007 23:24:40 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Wed, 13 Jun 2007 23:24:40 -0700 (PDT)
In-Reply-To: <f4ptq3$71v$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50170>

On 6/14/07, Jakub Narebski <jnareb@gmail.com> wrote:
>
> On the other hand side, blaming multiple files in parallel has sense I think
> only for graphical viewer, not for command line command.
>

Yes, I agree. The only useful thing for command line is if you use it
togheter with some cache mechanism to allow following runs faster.

git-blame --cache-full-history (?)


Marco
