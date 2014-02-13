From: David Kastrup <dak@gnu.org>
Subject: Re: Make the git codebase thread-safe
Date: Thu, 13 Feb 2014 09:38:50 +0100
Message-ID: <8761oj8l0l.fsf@fencepost.gnu.org>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
	<CABPQNSZ_LLg5i+mpwUj7pzXVQMY1tcXz2gJ+PWG-mP1iyjxoaw@mail.gmail.com>
	<CAHOQ7J8QxfvtrS2KdgzUPvkDzJ1Od0CMvdWxrF_bNacVRYOa5Q@mail.gmail.com>
	<CABPQNSZtQd51gQY7oK8B-BbpNEhxR-onQtiXSfW9sv1t2YW_nw@mail.gmail.com>
	<CAHOQ7J_Jrj1NJ_tZaCioskQU_xGR2FQPt8=JrWpR6rfs=c847w@mail.gmail.com>
	<CABPQNSYVGc9m0_xfAWe=3b7CXyGZ-2FfTMRbTJ=UECeZUtdgmg@mail.gmail.com>
	<52FBC9E5.6010609@gmail.com>
	<CAHOQ7J9A7zPV-kYe1WiQrVuWXXTNDVOQJEbnB+_jzEQ2_4Umxw@mail.gmail.com>
	<52FC820F.3030707@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Zager <szager@google.com>,
	Karsten Blees <karsten.blees@gmail.com>, kusmabite@gmail.com,
	Stefan Zager <szager@chromium.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Feb 13 09:39:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDrpQ-0006Vx-Me
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 09:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753065AbaBMIjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 03:39:25 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:41811 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbaBMIjY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 03:39:24 -0500
Received: from localhost ([127.0.0.1]:40850 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WDrpL-0006Tb-04; Thu, 13 Feb 2014 03:39:23 -0500
Received: by lola (Postfix, from userid 1000)
	id 8FCB3E047C; Thu, 13 Feb 2014 09:38:50 +0100 (CET)
In-Reply-To: <52FC820F.3030707@viscovery.net> (Johannes Sixt's message of
	"Thu, 13 Feb 2014 09:27:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242048>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 2/12/2014 20:30, schrieb Stefan Zager:
>> On Wed, Feb 12, 2014 at 11:22 AM, Karsten Blees <karsten.blees@gmail.com> wrote:
>>> Am 12.02.2014 19:37, schrieb Erik Faye-Lund:
>>>> ReOpenFile, that's fantastic. Thanks a lot!
>>>
>>> ...but should be loaded dynamically via GetProcAddress, or are we
>>> ready to drop XP support?
>> 
>> Right, that is an issue.  From our perspective, it's well past time to
>> drop XP support.
>
> Not from mine.

XP has not even reached end of life yet.  As a point of comparison,
there are tensions on the Emacs developer list several times a decade
because some people suggest it might be time to drop the MSDOS port
and/or the associated restriction of having filenames be unique in the
8+3 naming scheme.

-- 
David Kastrup
