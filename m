From: Kevin Ballard <kevin@sb.org>
Subject: Re: Associating tags with changelogs
Date: Sun, 4 May 2008 23:56:31 -0400
Message-ID: <436ECC5F-0664-4379-8F69-0121AE5F496E@sb.org>
References: <218b69370805042040h66d02979jac6bd64456a9d304@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Zack Brown" <zacharyb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 05 05:57:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsrpW-0002Av-Q2
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 05:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbYEED4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 23:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752932AbYEED4i
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 23:56:38 -0400
Received: from sd-green-bigip-74.dreamhost.com ([208.97.132.74]:38146 "EHLO
	randymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752202AbYEED4h (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 May 2008 23:56:37 -0400
Received: from [192.168.0.215] (c-24-91-11-245.hsd1.ma.comcast.net [24.91.11.245])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a1.g.dreamhost.com (Postfix) with ESMTP id 6D12518DAB8;
	Sun,  4 May 2008 20:56:35 -0700 (PDT)
In-Reply-To: <218b69370805042040h66d02979jac6bd64456a9d304@mail.gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81222>

Sounds like you want git describe --contains.

-Kevin Ballard

On May 4, 2008, at 11:40 PM, Zack Brown wrote:

> I'm using git to extract changelog entries into a MySQL database, and
> I want to be able to associate each changelog with the official
> release in which it first appears. I can use "git-tag -l" to see a
> list of the tags, and I can use "git-log tag1..tag2" to view all the
> changelogs between two tags, but neither of these are exactly what I
> want.
>
> My script keeps track of the most recent changelog entry that it has
> processed into the MySQL database, so the next time it runs, it picks
> up from that entry, using "`git-log sha1string.. --pretty=fuller", and
> inserts only the changelogs since that entry into the database.
>
> What I'd like is to still be able to get only the entries since that
> sha1 string, while somehow identifying the tag of the release
> encompassing each entry listed in that set. Then when I input the
> changelog into my database, I can associate it with the proper
> official release (or -rc candidate).
>
> Is there a command to do that? I don't see anything in the man pages  
> for it.

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
