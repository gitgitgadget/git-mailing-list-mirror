From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Make "git am" properly unescape lines matching ">>*From "
Date: Tue, 08 Jun 2010 13:54:32 -0700
Message-ID: <4C0EAE08.60904@zytor.com>
References: <87hbldjo0s.fsf@yoom.home.cworth.org> <87d3w1jlp0.fsf@yoom.home.cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Junio C Hamano <junkio@cox.net>
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Tue Jun 08 22:54:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM5oo-0003aO-Dp
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 22:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756027Ab0FHUyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 16:54:37 -0400
Received: from terminus.zytor.com ([198.137.202.10]:58036 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754655Ab0FHUyh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 16:54:37 -0400
Received: from anacreon.sc.intel.com (hpa@localhost [127.0.0.1])
	(authenticated bits=0)
	by mail.zytor.com (8.14.3/8.14.3) with ESMTP id o58KsWJe032453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Tue, 8 Jun 2010 13:54:33 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-3.fc13 Thunderbird/3.0.4
In-Reply-To: <87d3w1jlp0.fsf@yoom.home.cworth.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148716>

On 06/08/2010 01:47 PM, Carl Worth wrote:
> On Tue, 08 Jun 2010 12:57:23 -0700, Carl Worth <cworth@cworth.org> wrote:
>> I'm adding support to notmuch[1] to more easily pipe a thread full of
>> But I noticed that "git am" wasn't removing any of these added '>'
>> characters, so I was getting corrupted commit messages.
> 
> I've also noticed that format-patch is generating bogus mbox files
> without any escaping. (The only way it gets away with this is that
> mailsplit only treats "From " lines as separators if they end with
> something that looks quite a bit like the output of asctime.)
> 

At the same time, it would be a fairly major lose to not be able to
generate individual messages easily.  I have personally considered the
fact that git format-patch produces something-vaguely-like mboxes rather
than individual plain RFC 2822 messages to be a bug; fixable by "tail"
but annoying.

	-hpa
