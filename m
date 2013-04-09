From: Aaron Schrab <aaron@schrab.com>
Subject: Re: [PATCH 2/2] clone: Allow repo using gitfile as a reference
Date: Tue, 9 Apr 2013 12:50:22 -0400
Message-ID: <20130409165022.GB20752@pug.qqx.org>
References: <20130408185957.GM27178@pug.qqx.org>
 <1365461200-13509-1-git-send-email-aaron@schrab.com>
 <1365461200-13509-3-git-send-email-aaron@schrab.com>
 <20130409002456.GW30308@google.com>
 <20130409163149.GA20752@pug.qqx.org>
 <7v8v4rtzw4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 18:50:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPbke-0000WX-Jd
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 18:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937190Ab3DIQuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 12:50:24 -0400
Received: from pug.qqx.org ([50.116.43.67]:38605 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934679Ab3DIQuX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 12:50:23 -0400
Received: by pug.qqx.org (Postfix, from userid 1000)
	id A96A11D31B; Tue,  9 Apr 2013 12:50:22 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v8v4rtzw4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+145 (gd0ebb66) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220584>

At 09:47 -0700 09 Apr 2013, Junio C Hamano <junio@pobox.com> wrote:
>Aaron Schrab <aaron@schrab.com> writes:
>> But if others disagree, I could be convinced to add support for that.
>
>If M/.git weren't a gitfile that points elsewhere, that request
>ought to work, no?  A gitfile is the moral equilvalent of a symbolic
>link, meant to help people on platforms and filesystems that lack
>symbolic links, so in that sense, not supporting the case goes
>against the whole reason why we have added support for gitfile in
>the first place, I think.

OK, I'm convinced.  I'll modify it to support that as well.
