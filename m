From: Thomas Koch <thomas@koch.ro>
Subject: Re: How to hide a git repository?
Date: Tue, 25 Nov 2008 20:01:37 +0100
Organization: Young Media Concepts
Message-ID: <200811252001.37259.thomas@koch.ro>
References: <900638.56188.qm@web37904.mail.mud.yahoo.com> <alpine.LNX.1.00.0811251327480.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Gary Yang <garyyang6@yahoo.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Nov 25 20:03:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L53Bn-0004HE-Jq
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 20:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163AbYKYTB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 14:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbYKYTB4
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 14:01:56 -0500
Received: from koch.ro ([195.34.83.107]:49394 "EHLO
	ve825703057.providerbox.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752086AbYKYTBz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2008 14:01:55 -0500
Received: from 44-13.1-85.cust.bluewin.ch ([85.1.13.44] helo=noname)
	by ve825703057.providerbox.net with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <thomas@koch.ro>)
	id 1L53AH-0005jO-Fm; Tue, 25 Nov 2008 20:01:37 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.LNX.1.00.0811251327480.19665@iabervon.org>
X-Face: ##Diipbu!WHqpJ%Eb+k:m;]n%VcrM\f\MJ-:0\<0.r?ULf7g"kC!"Cg,o;D]
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101675>

Am Tuesday 25 November 2008 19:38:02 schrieb Daniel Barkalow:
> On Mon, 24 Nov 2008, Gary Yang wrote:
> > Do I have to create two git servers? One is for public to download the
> > released code. For example: gitpub.mycompany.com:/pub/linux/kernel.
>
> The public can't generally use this URL, because it's an ssh URL, and they
> won't be able to connect with ssh. They can only really use
> git://gitpub.mycompany.com/pub/linux/kernel or something similar.
>
> The normal pattern is to have R/W access with ssh and anonymous read
> access via git://...; you can then have multiple repositories on the same
> host, with the git server only serving the public one. All of them will be
> accessible to the ssh methods (restricted by the user's UNIX permissions
> on the files in those directories).
>
> 	-Daniel
> *This .sig left intentionally blank*
> --
Do you now of a way to show public repos with gitweb to the public and
private repos to the staff with the same gitweb installation?

Best regards,
-- 
Thomas Koch, Software Developer
http://www.koch.ro

Young Media Concepts GmbH
Sonnenstr. 4
CH-8280 Kreuzlingen
Switzerland

Tel    +41 (0)71 / 508 24 86
Fax    +41 (0)71 / 560 53 89
Mobile +49 (0)170 / 753 89 16
Web    www.ymc.ch
