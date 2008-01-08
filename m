From: "Peter Harris" <peter@peter.is-a-geek.org>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 8 Jan 2008 08:07:15 -0500
Message-ID: <eaa105840801080507j1b748fy6fdff8b240cf8c33@mail.gmail.com>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se>
	 <200801071947.28586.robin.rosenberg.lists@dewire.com>
	 <alpine.LSU.1.00.0801071915470.10101@racer.site>
	 <200801072203.23938.robin.rosenberg.lists@dewire.com>
	 <20080107224204.55539c31@jaiman>
	 <Pine.LNX.4.64.0801081150010.25629@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Peter Karlsson" <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Jan 08 14:07:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCEBL-0004Ec-V0
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 14:07:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246AbYAHNHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 08:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753789AbYAHNHT
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 08:07:19 -0500
Received: from fk-out-0910.google.com ([209.85.128.191]:20420 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbYAHNHR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 08:07:17 -0500
Received: by fk-out-0910.google.com with SMTP id z23so9116579fkz.5
        for <git@vger.kernel.org>; Tue, 08 Jan 2008 05:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=HR5doLDF7h9IkQ+beFCXoBcK0AES1yFpjLZveIvMebg=;
        b=qAhP9bIrkxYhqDXYGOwFG2GmDD3YQDkMCEDmnAKj/3TVJCSVO/HF81iCmrmo/Ci5gMEQz3kRwDIIB1Pdpo9UGd3L1NYAy0s1OLsDrzxwOcGYU9d3YITgOtpLpLDiN9VEp/W1H8bDOLdgKaYMLvzunpMaTuxsAW2JhqgZtaMSYGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=U+ecxc2hUphf5ajRJGweXpkxsbuz6evkTHbhJgPynAw1MGQr2Hzm8k+wHjIrLxOHLErzGCKFqfXP37VUftJHtlagQCCmwS4jpx+SxFKKOe53OrZUo++Y2x3Ig135b3S/5JzFuT0vJTi9bCYQ7ilvFEMuw7kWodQGTfI5ZZ/OM2w=
Received: by 10.78.159.7 with SMTP id h7mr577057hue.17.1199797635582;
        Tue, 08 Jan 2008 05:07:15 -0800 (PST)
Received: by 10.78.203.14 with HTTP; Tue, 8 Jan 2008 05:07:15 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0801081150010.25629@ds9.cixit.se>
Content-Disposition: inline
X-Google-Sender-Auth: 736425382e841313
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69874>

On Jan 8, 2008 5:56 AM, Peter Karlsson <peter@softwolves.pp.se> wrote:
> Thomas Neumann:
>
> > as a user, I expect a SCM to only modify a file when I have
> > explicitly asked it to do so.
>
> As a user, I exepect things to just work. With RCS/CVS/Subversion, it
> does, because it differentiates between text files (internally encoding
> NLs with "LF", but I couldn't care less what it uses there) and binary
> files (which it doesn't change). With git it currently doesn't since it
> treats everything as binary files.

Actually, Subversion does the Right Thing, and treats everything as a
binary file until and unless you explicitly set the svn:eol-style
property on each file that you want it to mangle.

Maybe you set up Subversion auto-props and forgot about it? That would
be almost (but not really) like setting autocrlf=true in your global
git config.

Peter Harris
