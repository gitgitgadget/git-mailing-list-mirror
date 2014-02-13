From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Make the git codebase thread-safe
Date: Thu, 13 Feb 2014 09:27:59 +0100
Message-ID: <52FC820F.3030707@viscovery.net>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>	<CABPQNSZ_LLg5i+mpwUj7pzXVQMY1tcXz2gJ+PWG-mP1iyjxoaw@mail.gmail.com>	<CAHOQ7J8QxfvtrS2KdgzUPvkDzJ1Od0CMvdWxrF_bNacVRYOa5Q@mail.gmail.com>	<CABPQNSZtQd51gQY7oK8B-BbpNEhxR-onQtiXSfW9sv1t2YW_nw@mail.gmail.com>	<CAHOQ7J_Jrj1NJ_tZaCioskQU_xGR2FQPt8=JrWpR6rfs=c847w@mail.gmail.com>	<CABPQNSYVGc9m0_xfAWe=3b7CXyGZ-2FfTMRbTJ=UECeZUtdgmg@mail.gmail.com>	<52FBC9E5.6010609@gmail.com> <CAHOQ7J9A7zPV-kYe1WiQrVuWXXTNDVOQJEbnB+_jzEQ2_4Umxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>, kusmabite@gmail.com,
	Stefan Zager <szager@chromium.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 13 09:28:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDreS-0006iN-D3
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 09:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878AbaBMI2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 03:28:04 -0500
Received: from so.liwest.at ([212.33.55.18]:45050 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751990AbaBMI2D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 03:28:03 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WDreK-0006rA-ER; Thu, 13 Feb 2014 09:28:00 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 302CC16613;
	Thu, 13 Feb 2014 09:28:00 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <CAHOQ7J9A7zPV-kYe1WiQrVuWXXTNDVOQJEbnB+_jzEQ2_4Umxw@mail.gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242044>

Am 2/12/2014 20:30, schrieb Stefan Zager:
> On Wed, Feb 12, 2014 at 11:22 AM, Karsten Blees <karsten.blees@gmail.com> wrote:
>> Am 12.02.2014 19:37, schrieb Erik Faye-Lund:
>>> ReOpenFile, that's fantastic. Thanks a lot!
>>
>> ...but should be loaded dynamically via GetProcAddress, or are we ready to drop XP support?
> 
> Right, that is an issue.  From our perspective, it's well past time to
> drop XP support.

Not from mine.

-- Hannes
