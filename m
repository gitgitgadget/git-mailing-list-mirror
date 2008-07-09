From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH] Fix problem with authentification on http repository.
Date: Wed, 9 Jul 2008 10:04:56 +0200 (CEST)
Message-ID: <alpine.LRH.1.10.0807090955520.5588@yvahk3.pbagnpgbe.fr>
References: <11911047823308-git-send-email-jean.guyader@linkea.org> <7v8x6pjb4c.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709300039430.28395@racer.site> <7v4phdja01.fsf@gitster.siamese.dyndns.org> <7v4p6zmx0l.fsf@gitster.siamese.dyndns.org>
 <20080709055150.GA28482@glandium.org> <7vlk0blgg0.fsf@gitster.siamese.dyndns.org> <20080709075345.GA22022@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 10:19:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGUtI-0000Mq-P0
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 10:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797AbYGIISK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 04:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752192AbYGIISK
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 04:18:10 -0400
Received: from kluster1.contactor.se ([91.191.140.11]:54199 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbYGIISJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 04:18:09 -0400
X-Greylist: delayed 739 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jul 2008 04:18:09 EDT
Received: from linux3.contactor.se (linux3.contactor.se [91.191.140.23])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id m6985mD8021226
	for <git@vger.kernel.org>; Wed, 9 Jul 2008 10:05:48 +0200
X-X-Sender: dast@linux3.contactor.se
In-Reply-To: <20080709075345.GA22022@glandium.org>
User-Agent: Alpine 1.10 (LRH 962 2008-03-14)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87858>

On Wed, 9 Jul 2008, Mike Hommey wrote:

> Actually, the howto tells to setup a ~/.netrc file, which should make
> the http://user@server/path/ format work. I don't know if dropping user@
> would still work, that depends how libcurl works with it.

git has the netrc parser set to "optional", which makes libcurl use the login 
name given in the URL (if present) and search for the associated password in 
the .netrc file.

Typical users probably only have one user per host name in the .netrc file and 
then the name part in the URL provides no particular extra goodness but can 
just as well be excluded.

-- 

  / daniel.haxx.se
