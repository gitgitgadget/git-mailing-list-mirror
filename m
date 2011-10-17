From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 0/7] Provide API to invalidate refs cache
Date: Mon, 17 Oct 2011 21:43:19 +0200
Message-ID: <4E9C8557.50709@alum.mit.edu>
References: <1318819091-7066-1-git-send-email-mhagger@alum.mit.edu> <20111017184708.GB2540@sandbox-rc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Oct 17 21:43:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFt6C-00086S-3v
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 21:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673Ab1JQTno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 15:43:44 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:50736 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764Ab1JQTnn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 15:43:43 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9HJhK5Z014797
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 17 Oct 2011 21:43:20 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <20111017184708.GB2540@sandbox-rc>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183812>

On 10/17/2011 08:47 PM, Heiko Voigt wrote:
> On Mon, Oct 17, 2011 at 04:38:04AM +0200, mhagger@alum.mit.edu wrote:
>> [1] http://marc.info/?l=git&m=131827641227965&w=2
>>     In this mailing list thread, Heiko Voigt stated that git-submodule
>>     does not modify any references, so it should not have to use the
>>     API.
> 
> This is not entirely true. I was saying that my submodule-merge code is
> currently the only one using the refs api for submodules and that does
> not need to modify submodule refs. I imagine that there will be some
> users when submodule support matures (e.g. recursive push).

Sorry for misunderstanding/misrepresenting you; thanks for the
clarification.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
