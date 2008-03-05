From: Noel Grandin <noel@peralex.com>
Subject: Re: GSoC 2008 - Mentors Wanted!
Date: Wed, 05 Mar 2008 16:55:11 +0200
Message-ID: <47CEB44F.9040404@peralex.com>
References: <20080304051149.GS8410@spearce.org>	 <1b46aba20803041247h5cc64186q2abf7973372fd3ef@mail.gmail.com>	 <20080305053612.GA8410@spearce.org>	 <7bfdc29a0803042358n6126286dr7a17f3b4dadbabe5@mail.gmail.com>	 <20080305081523.GK8410@spearce.org> <7bfdc29a0803050025p45dfcea9q87a1107a8bed46a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Imran M Yousuf <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 16:06:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWvAz-0002fX-RI
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 16:05:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022AbYCEPES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 10:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752894AbYCEPES
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 10:04:18 -0500
Received: from [41.207.227.243] ([41.207.227.243]:54069 "EHLO mail.peralex.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753022AbYCEPER (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 10:04:17 -0500
X-Greylist: delayed 395 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Mar 2008 10:04:15 EST
Received: from [192.168.1.187] (noel.ct [192.168.1.187])
	by mail.peralex.com (8.14.2/8.14.1) with ESMTP id m25ErEt2040207;
	Wed, 5 Mar 2008 16:53:14 +0200 (SAST)
	(envelope-from noel@peralex.com)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <7bfdc29a0803050025p45dfcea9q87a1107a8bed46a6@mail.gmail.com>
X-Enigmail-Version: 0.95.3
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.61 on 192.168.1.7
X-Synonym: Copied by Synonym (http://www.modulo.ro/synonym) to: mailbackup3@peralex.com, mailbackup3@peralex.com
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (mail.peralex.com [192.168.1.7]); Wed, 05 Mar 2008 16:53:27 +0200 (SAST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76227>

Imran M Yousuf wrote:
> To start with I was actually thinking of JNI + "exec from C". So later
> when libification is completed we can replace the execs with call to
> the libs directly instead. Is this a viable fourth option (sorry I
> forgot to mention it the first time around)?
>
>   

This is probably a good idea. JGIT is always going to be 2 steps behind
the native GIT code when comes to accessing on-disk structures.

This is also how the subversion plugin for the Eclipse IDE worked in the
beginning and the performance seemed to be acceptable (to me).

Regards, Noel.

Disclaimer: http://www.peralex.com/disclaimer.html


