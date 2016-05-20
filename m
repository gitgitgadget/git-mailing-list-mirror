From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH v6 2/9] connect: only match the host with core.gitProxy
Date: Sat, 21 May 2016 07:30:54 +0900
Message-ID: <20160520223054.GB7752@glandium.org>
References: <20160517013554.22578-1-mh@glandium.org>
 <20160517013554.22578-3-mh@glandium.org>
 <xmqqbn40cser.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tboegi@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 21 00:31:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3swk-0007Ag-87
	for gcvg-git-2@plane.gmane.org; Sat, 21 May 2016 00:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbcETWbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 18:31:01 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:56878 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750836AbcETWbA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 18:31:00 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1b3swY-00023m-Vo; Sat, 21 May 2016 07:30:54 +0900
Content-Disposition: inline
In-Reply-To: <xmqqbn40cser.fsf@gitster.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295218>

On Fri, May 20, 2016 at 02:48:28PM -0700, Junio C Hamano wrote:
> So, even if we agree that per-port behaviour is not something we
> would use if we were building the system without any existing users
> today, I do not think we want "git now fails with an error" at all.
> It goes against the approach Git takes to give smooth transtion to
> users when we must break backward compatibility.

I don't disagree. I went with a hard fail because it was easier. I'm
not too keen blocking this series on this transition happening. So I'll
try to finish this series without this change, and we can separate this
transition discussion from the rest of the connect.c changes.

Mike
