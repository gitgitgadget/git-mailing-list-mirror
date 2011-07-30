From: "John M. Dlugosz" <ngnr63q02@sneakemail.com>
Subject: Re: File Systems and a Theory of Edits
Date: Sat, 30 Jul 2011 14:40:57 -0500
Message-ID: <23101-1312054868-691056@sneakemail.com>
References: <CADo4Y9hG=-Bye5g7OWROJNbbUOcnH0hj0f3csws5V+YzEUKAMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 21:41:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnFPo-0008ML-2s
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 21:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347Ab1G3TlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 15:41:12 -0400
Received: from sneak2.sneakemail.com ([38.113.6.65]:50327 "HELO
	sneak2.sneakemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751597Ab1G3TlK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 15:41:10 -0400
Received: (qmail 27996 invoked from network); 30 Jul 2011 19:41:08 -0000
Received: from unknown (HELO localhost.localdomain) (192.168.0.1)
  by sneak2.sneakemail.com with SMTP; 30 Jul 2011 19:41:08 -0000
Received: from 207.58.245.194 by mail.sneakemail.com with SMTP;
 30 Jul 2011 19:41:08 -0000
Received: (sneakemail censored 23101-1312054868-691056 #1); 30 Jul 2011
 19:41:08 -0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.8.1.24)
 Gecko/20100228 Thunderbird/2.0.0.24 Mnenhy/0.7.5.666
In-Reply-To: <CADo4Y9hG=-Bye5g7OWROJNbbUOcnH0hj0f3csws5V+YzEUKAMg@mail.gmail.com>
X-Mailer: Perl5 Mail::Internet v
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178218>

On 7/30/2011 9:29 AM, Michael Nahas wrote:
> For these commands to work, the git command will have to include an
> argument that specifies which commit it operates on.  So some basic
> ones might be:
>      "git ls<commit>  -- <path>"
>      "git cat<commit>  -- <path>"
> (There exists "git ls-files", "git ls-tree", and "git cat-file" but

If you could "mount" a repository, then you would not need these commands at all.  It 
would be in fact a read-only file system.  Once mounted, the individual commits could be 
directories, and under that you explore in the usual way.
