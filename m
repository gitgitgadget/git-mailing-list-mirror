From: Pascal Obry <pascal@obry.net>
Subject: Re: gmail smtp server and git-send-mail. Is this combination working?
Date: Tue, 08 Jan 2008 19:25:39 +0100
Organization: Home - http://www.obry.net
Message-ID: <4783C023.4000901@obry.net>
References: <4d8e3fd30801080858h5f109b47v87abc6b315fcfa08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 19:26:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCJ9Y-0007ne-8R
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 19:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbYAHSZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 13:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbYAHSZs
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 13:25:48 -0500
Received: from smtp20.orange.fr ([80.12.242.26]:35521 "EHLO smtp20.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752643AbYAHSZq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 13:25:46 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2027.orange.fr (SMTP Server) with ESMTP id 642BF1C0009D
	for <git@vger.kernel.org>; Tue,  8 Jan 2008 19:25:44 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-90-111.w86-205.abo.wanadoo.fr [86.205.32.111])
	by mwinf2027.orange.fr (SMTP Server) with ESMTP id 269C81C000C3;
	Tue,  8 Jan 2008 19:25:44 +0100 (CET)
X-ME-UUID: 20080108182544158.269C81C000C3@mwinf2027.orange.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <4d8e3fd30801080858h5f109b47v87abc6b315fcfa08@mail.gmail.com>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69903>

Paolo,

I never tried msmtp. I'm using Cygwin ssmtp to send e-mail via Google 
mail. Works fine. If it can be useful to others:

My /etc/ssmtp/ssmtp.conf:

root=<username>@gmail.com
mailhub=smtp.gmail.com:587
FromLineOverride=YES
hostname=<username>@gmail.com
rewriteDomain=
UseSTARTTLS=YES
AuthUser=<username>@gmail.com
AuthPass=<password>

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
