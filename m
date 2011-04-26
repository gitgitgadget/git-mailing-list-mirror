From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH/RFC 2/2] format-patch: show notes as message after the ---
Date: Tue, 26 Apr 2011 11:28:58 +0200
Message-ID: <201104261128.58527.johan@herland.net>
References: <cb2af8d1ef663a68ea96dbb916dcfa0aee71abcb.1303808057.git.git@drmicha.warpmail.net> <826def15eb7204ee30fc4c358f72103ec75b4e42.1303808057.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 26 11:29:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEea3-00019q-R7
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 11:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118Ab1DZJ3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 05:29:06 -0400
Received: from smtp.opera.com ([213.236.208.81]:57999 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753079Ab1DZJ3E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 05:29:04 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p3Q9SwPc008039
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 26 Apr 2011 09:28:58 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <826def15eb7204ee30fc4c358f72103ec75b4e42.1303808057.git.git@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172082>

On Tuesday 26 April 2011, Michael J Gruber wrote:
> When requesting notes with "--notes", "format-patch" produces notes
> within the commit message which "am" misunderstands as being part of
> the message.
>
> Change this so that notes are displayed after an additional "---".
> Any "am" (old or new) will ignore that, so that it is a safe place
> for additional comments:
>
> Log message
> "---"
> notes
> "---"
> diffstat
> patch
>
> (The first "---" appears only when there is a note, of course.)
>
> Later on (say with "--format-notes") the output format can be changed
> easily to accomodate a future "am" which knows how to create notes
> from such patches.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>

Acked-by: Johan Herland <johan@herland.net>

(goes for 1/2 as well)


/me likes :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
