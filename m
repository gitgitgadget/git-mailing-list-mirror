From: Aaron Schrab <aaron@schrab.com>
Subject: Re: [PATCH 2/2] clone: Allow repo using gitfile as a reference
Date: Sun, 7 Apr 2013 20:08:45 -0400
Message-ID: <20130408000845.GH27178@pug.qqx.org>
References: <1365376629-16054-1-git-send-email-aaron@schrab.com>
 <1365376629-16054-2-git-send-email-aaron@schrab.com>
 <20130407235112.GH19857@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 08:49:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5rj-0000sy-Dn
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934504Ab3DHAIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 20:08:46 -0400
Received: from pug.qqx.org ([50.116.43.67]:33304 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757616Ab3DHAIp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 20:08:45 -0400
Received: by pug.qqx.org (Postfix, from userid 1000)
	id 428F21D3EA; Sun,  7 Apr 2013 20:08:45 -0400 (EDT)
Mail-Followup-To: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20130407235112.GH19857@elie.Belkin>
User-Agent: Mutt/1.5.21+145 (gd0ebb66) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220393>

At 16:51 -0700 07 Apr 2013, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> -	char *ref_git;
>> +	char *ref_git, *repo;
>[...]
>> +	repo = (char *)read_gitfile(mkpath("%s/.git", ref_git));
>
>Why not make repo a "const char *" and avoid the cast?  The above
>would seem to make it too tempting to treat the return value from
>read_gitfile() as a mutable buffer instead of a real_path string that
>should be copied asap.

Good catch.  I'll fix that in the next version.

Thanks.
