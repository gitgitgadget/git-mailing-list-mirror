From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] rebase: learn --discard subcommand
Date: Mon, 30 May 2011 10:44:05 +0200
Message-ID: <4DE358D5.9010900@alum.mit.edu>
References: <1306551495-26685-1-git-send-email-martin.von.zweigbergk@gmail.com> <20110528230844.GA31498@elie> <4DE32138.4050104@alum.mit.edu> <20110530051434.GA3723@Imperial-SD-Longsword>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Tim Mazid <timmazid@hotmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 10:44:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQy5C-0005Br-6c
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 10:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933Ab1E3IoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 04:44:12 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:51604 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702Ab1E3IoL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 04:44:11 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p4U8i6rm001228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 May 2011 10:44:06 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <20110530051434.GA3723@Imperial-SD-Longsword>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174733>

On 05/30/2011 07:14 AM, Tim Mazid wrote:
> On Mon, May 30, 2011 at 06:46:48AM +0200, Michael Haggerty wrote:
>> On 05/29/2011 01:08 AM, Jonathan Nieder wrote:
>>> Agh, "git rebase --abort --keep-head" feels a little too long to be
>>> memorable.  Still, hope that helps.
>>
>> It seems like the distinction is analogous to "git reset --soft", so maybe
>>
>>     git rebase --abort --soft
> 
> Well, the only problem with that is the "--soft" option refers to the
> "reset" command given to git, whereas in your proposed syntax, the
> "--soft" option refers to the _other_ option, "--abort".
> 
> This may seem a little nit-picky, but such a difference could lead to
> confusion.  Perhaps "--soft-abort" or "--soft-abort" would be better?  A
> single option to the "git rebase" command rather than a "sub-option"
> given to another option.

To be even more nit-picky :-), --abort (and --continue) are really
subcommands of rebase.  The fact that they are implemented as options is
the original source of the inconsistency.  Of course this cannot be
changed because "git rebase abort" already has a different meaning.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
