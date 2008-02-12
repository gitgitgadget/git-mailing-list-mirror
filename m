From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: What's in git.git
Date: Tue, 12 Feb 2008 12:35:18 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802121234170.416@yvahk3.pbagnpgbe.fr>
References: <7v8x27iui1.fsf@gitster.siamese.dyndns.org>
 <7vd4r24ox6.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0802121010590.416@yvahk3.pbagnpgbe.fr>
 <20080212094755.GA17195@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Feb 12 12:36:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOtQt-0003E8-B0
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 12:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761532AbYBLLfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 06:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761306AbYBLLfh
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 06:35:37 -0500
Received: from kluster1.contactor.se ([91.191.140.11]:57403 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760881AbYBLLfg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 06:35:36 -0500
Received: from linux3.contactor.se (linux3.contactor.se [91.191.140.23])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id m1CBZI6u012196;
	Tue, 12 Feb 2008 12:35:18 +0100
X-X-Sender: dast@linux3.contactor.se
In-Reply-To: <20080212094755.GA17195@glandium.org>
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73652>

On Tue, 12 Feb 2008, Mike Hommey wrote:

> The important bit in the commit message reads:
>> We work around this by removing the http_init and http_cleanup calls
>> from get_refs_via_curl, replacing them with a transport->data
>> initialization with the http_walker (which does http_init).
>
> Which means there remains only one initialization. I agree it's not a 
> workaround anymore, but the word remained from the 3 previous attempts, 
> which were workarounds.

Ah, ok. Then I'll retract my comments! :-) Sorry for not checking out the 
actual code change, I only read the description!
